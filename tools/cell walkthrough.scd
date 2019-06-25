(
var cells;
var nowPlaying = ();
var currentlySelected = ();
var document;
var editDocument = { |path|
	var oldDoc = document;
	document = Document.open(path.postln);
	//Using open to activate window
	"open \"/Applications\/SuperCollider\/SuperCollider.app\"".unixCmd;
	oldDoc !? (_.close);
};
var togglePlay = {  |key, cell|
	var func = {
		var old = nowPlaying[key];
		if (old.isNil) {
			nowPlaying[key] = cell.play;
		} {
			nowPlaying[key] = nil;
			old.free;
			if (old != cell) {
				nowPlaying[key] = cell;
				nowPlaying[key].play;
			};
		}
	};
	if (cells.isPlaying.not, {
		cells.play.then(func)
	}, func);
};
var listView = { |key, model|
	var names, paths;

	// Sort first by number, then by name
	model = model.sort({|a, b|
		if (a.metadata[\number] == b.metadata[\number]) {
			a.name < b.name
		} {
			a.metadata[\number] < b.metadata[\number]
		}
	});

	names = model.collect({ |cell| "% %".format(cell.metadata[\number].asStringToBase(10, 3), cell.name) });
	paths = model.collect({ |cell| cell.metadata[\path] });

	currentlySelected[key] = model[0];

	ListView().items_(names).mouseDownAction_({ |v, x, y, mod, btn, clickCount|
		// Double click to open file
		if (clickCount == 2) {
			editDocument.(paths[v.value]);
		}
	}).mouseUpAction_({ |v, x, y, mod, btn, clickCount|
		//Cmd-click to play/stop
		if (mod.isCmd) {
			togglePlay.(key, model[v.value])

		}
	}).action_({ |v|
		currentlySelected[key] = model[v.value];
	}).keyUpAction_({ |v, char, mod, unicode, keycode, key|

		if (mod.isCmd) {

			if (key == QKey.down || key == QKey.up) {
				togglePlay.(key, model[v.value])
			};

		} {
			key.postln;
			// Pass on space to main window
			switch(key,
				32, { false },
				// e
				69, { editDocument.(paths[v.value]) }
			);
		};

	}).keyDownAction_({ |v, char, mod, unicode, keycode, key|
		// Pass on space to main window
		if (key == 32) { false };
	});


};

var stopBtn, loadPath = "../cells.scd".resolveRelative;
Window.closeAll;
cells = loadPath.load;

~document = nil;
~walkWin !? (_.close);
~walkWin = Window("Nattradion", Window.availableBounds.width_(200)).layout_(VLayout(
	stopBtn = Button().states_([["Stop all"]]).action_({ |b|
		nowPlaying.values.do(_.free);
		cells.transitions.stopTransitionTest;
	}).keyDownAction_(false),
	listView.(\cells, cells.cells.values),
	View().layout_(HLayout(
		View().layout_(VLayout(
			StaticText().string_("Transition from").font_(Font.default.size_(10)),
			*~cells.transitions.types.collect { |type|
				Button().states_([[type]]).font_(Font.default.size_(10)).action_({
					var cur = currentlySelected[\cells];
					//Set mask if type is oneshot or bridge

					cells.transitions.testTransition(
						cur.debug("From"),
						cells.cells.values.reject(_==cur).choose.debug("To"),
						type.debug("Type"),
						//mask is only used  for oneshot and bridge
						currentlySelected[type].debug("Mask")
					);
				}.inEnvir).keyDownAction_(false);
			}
		).margins_(0, 0).spacing_(0)),
		View().layout_(VLayout(
			StaticText().string_("Transition to").font_(Font.default.size_(10)),
			*cells.transitions.types.collect { |type|
				Button().states_([[type]]).font_(Font.default.size_(10)).action_({
					var cur = currentlySelected[\cells];
					//Set mask if type is oneshot or bridge
					cells.transitions.testTransition(
						cells.cells.values.reject(_==cur).choose.debug("From"),
						cur.debug("To"),
						type.debug("Type"),
						//mask is only used  for oneshot and bridge
						currentlySelected[type].debug("Mask")
					);
				}.inEnvir).keyDownAction_(false);
			}
		).margins_(0, 0).spacing_(0))
	).margins_(0, 0).spacing_(0)),

	//ListView with cells
	//Select (for play) on single click
	//Edit on double click

	StaticText().string_("Friends"),
	listView.(\friends, cells.friends.cells),
	//TODO display all onsets/bridges, or just filtered by cell?
	//Display list of onsets, play on click
	StaticText().string_("Oneshots"),
	listView.(\oneshot, cells.transitions.oneshots.cells),
	StaticText().string_("Bridges"),
	listView.(\bridge, cells.transitions.bridges.cells),
	Button().states_([["Reload"]]).action_({
		cells.free;
		cells = loadPath.load;
	}.inEnvir).keyDownAction_(false);
))
.onClose_({
	cells.free;
}).front;

~walkWin.view.keyDownAction_({ |v, char, mod, unicode, keycode, key|
	if (key == 32) { //Space
		stopBtn.valueAction = 1;
	};
});

// buildListViews.value;
cells.play;

)
