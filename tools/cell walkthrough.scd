(
var cells;
var nowPlaying = ();
var currentlySelected = ();
var listViews = ();
var transitionButtons;
var document;
var task;
var rebuildListViews = {
	listView.(\cells, cells.cells.values);
	listView.(\friends, cells.friends.cells);
	listView.(\oneshot, cells.transitions.oneshots.cells);
	listView.(\bridge, cells.transitions.bridges.cells);
};
var editDocument = { |path|
	var oldDoc = document;
	document = Document.open(path);
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


	listViews[key] = (listViews[key] ?? { ListView() }).items_(names).mouseDownAction_({ |v, x, y, mod, btn, clickCount|
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

		if (key == \cells) {
			var allowed = model[v.value].settings[\transitions];
			cells.transitions.types.do { |k, i|
				transitionButtons.do { |arr|
					if (arr.notNil) {
						arr[i].enabled = allowed.includes(k);
					}
				}
			};
		};

	}).keyUpAction_({ |v, char, mod, unicode, keycode, key|

		if (mod.isCmd) {

			if (key == QKey.down || key == QKey.up) {
				togglePlay.(key, model[v.value])
			};

		} {
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

	//If we have a selection, restore it, otherwise set to first item
	currentlySelected[key] ?? {
		currentlySelected[key] = model[0];
	} !? {
		listViews[key].valueAction = model.indexOf(currentlySelected[key]) ? 0
	};

	listViews[key]
};
//A view factory which creates a view the first time it's called, then
//the same function is used to update the values
var transitionView = {
	var strings = [
		from: "",
		to: "",
		type: "",
		mask: ""

	];
	var view;
	{ |...args|
		#[from, to, type, mask].do { |key, i|
			strings[i*2+1] = args[i] ? "";
		};
		if (view.isNil) {
			view = View().layout_(GridLayout.rows(
				*strings.asPairs.clump(2).collect { |row|
					row.collect({ |str|
						StaticText().string_(str).font_(Font.default.size_(10));
					})
				}
			).spacing_(0).margins_(0, 5))
		} {
			var r = strings.asPairs;
			view.children.pairsDo { |label, val, i|
				val.string_(r[i+1])
			}
		};
		view
	}
}.value;

var transitionFactory = { |type, reverse=false|
	{
		var from = currentlySelected[\cells];
		var to = cells.cells.values.reject(_ == to).choose;
		if (reverse) {
			#from, to = [to, from];
		};
		transitionView.(from.name, to.name, type, currentlySelected[type] !? (_.name));
		cells.transitions.testTransition(
			from, to, type, currentlySelected[type]
		);
	}

};

var stopBtn, loadPath = "../cells.scd".resolveRelative;
Window.closeAll;
cells = loadPath.load;

transitionButtons = [
	cells.transitions.types.collect { |type|
		Button().states_([[type]]).font_(Font.default.size_(10)).action_(
			transitionFactory.(type);
		).keyDownAction_(false);
	},
	cells.transitions.types.collect { |type|
		Button().states_([[type]]).font_(Font.default.size_(10)).action_(
			transitionFactory.(type, true);
		).keyDownAction_(false);
	}
];


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
			*transitionButtons[0]
		).margins_(0, 0).spacing_(0)),
		View().layout_(VLayout(
			StaticText().string_("Transition to").font_(Font.default.size_(10)),
			*transitionButtons[1]
		).margins_(0, 0).spacing_(0))
	).margins_(0, 0).spacing_(0)),

	transitionView.(),
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
	task.stop;
	cells.free;
}).front;

 value {
	var paths, mtimes;
	paths = cells.cells.collect({ |cell|
		cell.metadata[\path];
	});
	mtimes = paths.collect({ |path|
		File.mtime(path)
	});
	task = SkipJack({
		var rebuild = List();
		paths.do { |path, i|
			var newTime, mtime = mtimes[i];
			newTime = File.mtime(path);
			if (mtime != newTime) {
				mtimes[i] = newTime;
				rebuild.add(path);
			}
		};
		rebuild.do { |path|
			var cell;
			cell = cells.loadCellFromPath(path);
			//TODO: This should be done by cells
			if (cell.notNil) {
				cells.addChildren(cell.metadata[\number], cell);
			};

		};
		if (rebuild.notEmpty) {
			"Rebuilding list views".postln;
			cells.init;
			rebuildListViews.value;
		};
	}, 0.5);
};

~walkWin.view.keyDownAction_({ |v, char, mod, unicode, keycode, key|
	if (key == 32) { //Space
		stopBtn.valueAction = 1;
	};
});

// buildListViews.value;
cells.play;
)
