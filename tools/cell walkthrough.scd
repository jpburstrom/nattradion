(
var cells;
// -- These three share keys --
// Playing cells for each category
var nowPlaying = ();
// Currently selected cells for each category
var currentlySelected = ();
// GUI listViews
var listViews = ();
// ----
// Last selected item, used for load test
var lastSelected;
var transitionButtons;
var document;
var task;
var rebuildListViews = {
	var cell;
	listView.(\cells, cells.cells.values);
	cell = currentlySelected[\cells];
	listView.(\friends, cells.friends.filteredCells(cell[\friendFilter]));
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
var stopAll = {
	nowPlaying.values.do(_.free);
	cells.transitions.stopTransitionTest;
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
var loadTestWindow;
var loadTest = { |cell|
	var win, cont, view;
	var t = { |str, p|
		StaticText(p).font_(Font.monospace.size_(10)).string_(str)
	};
	var f = { |str, p|
		var class = TextField;
		if (str.contains("\n")) {
			class = TextView
		};
		class.perform(\new, p).maxHeight_(50).enabled_(false).font_(Font.monospace.size_(10)).string_(str)
	};
	var displayEnvir = { |envir, view|
		View(view).layout_(GridLayout.rows(
			*envir.keys.asArray.sort.collect({ |k|
				var val = envir[k];
				if (val.isKindOf(Dictionary)) {
					val = displayEnvir.(val)
				} {
					val = f.(val.asCompileString);
				};
				[t.(k), val]
			})
		).spacing_(0).setColumnStretch(0, 1).setColumnStretch(1, 3))
	};
	if (cell.isNil) {
		cell = lastSelected;
	};
	if (cell.isPlaying) { cell.free };
	cell.load;
	win = Window("Load test: %".format(cell.name), Rect(800, 600, 800, 600))
	.onClose_({ cell.free }).front;
	cont = ScrollView(win, Rect(0, 0, 800, 600)).hasHorizontalScroller_(false);
	view = View().layout_(VLayout());
	Button(view).states_([["Edit"]]).action_({
		editDocument.(cell.metadata[\path]);
	}).maxWidth_(100).keyDownAction_(false);
	displayEnvir.(cell.envir, view);
	t.(\PROTO, view);
	displayEnvir.(cell.envir.proto, view);
	t.(\PARENT, view);
	displayEnvir.(cell.envir.parent, view);
	view.layout.add(nil);
	cont.canvas = view;

	view.focus.keyDownAction_({ |v, char, mod, unicode, keycode, key|
		// Pass on space to main window
		switch(key,
			16777216, { win.close }, //Esc,
			69, { editDocument.(cell.metadata[\path]) }
		);
	});

	loadTestWindow !? (_.close);
	loadTestWindow = win;

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
		var cell = model[v.value];
		lastSelected = cell;
		currentlySelected[key] = cell;

		if (key == \cells) {
			var allowed = cell.settings[\transitions];
			cells.transitions.types.do { |k, i|
				transitionButtons.do { |arr|
					if (arr.notNil) {
						arr[i].enabled = allowed.includes(k);
					}
				}
			};
			listView.(\friends, cells.friends.filteredCells(cell[\friendFilter]));
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
				69, { editDocument.(paths[v.value]) },
				// t
				84, { loadTest.(model[v.value]) }
			);
		};

	}).keyDownAction_({ |v, char, mod, unicode, keycode, key|
		// Pass on space to main window
		if (key == 32) { false };
	});

	if (model.isEmpty.not) {
		//If we have a selection, restore it, otherwise set to first item
		currentlySelected[key] ?? {
			currentlySelected[key] = model[0];
		} !? {
			listViews[key].valueAction = model.collect(_.name).indexOfEqual(currentlySelected[key].name) ? 0
		};
	} {
		currentlySelected[key] = nil
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

var loadPath = "../cells.scd".resolveRelative;
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
	Button().states_(
		[["Stop all"]]).action_(stopAll).keyDownAction_(false),
	Button().states_(
		[["Load test"]]).action_({
		loadTest.value
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
		rebuildListViews.value;
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
			1.wait;
			rebuildListViews.value;
		};
	}, 0.5);
};

~walkWin.view.keyDownAction_({ |v, char, mod, unicode, keycode, key|
	if (key == 32) { //Space
		stopAll.value;
	};
});

// buildListViews.value;
cells.play;
)
