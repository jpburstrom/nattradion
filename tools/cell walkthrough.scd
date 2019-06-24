(
var active = ();
var activeLabels = ();
var doPlayAction = { |val, envirKey|
	var thing = currentEnvironment[envirKey].postln;
	if (val == 1) {
		if (~cells.isPlaying.not) {
			~cells.play.then {
				thing.play;
				~cells.setReverb(~cell);
			}
		} {
			active[envirKey].stop;
			thing.play;
			~cells.setReverb(~cell);
		}
	} {
		thing.stop;
	};
	active[envirKey] = thing;
}.inEnvir;
var nowPlaying = ();
var listView = { |name, model|
	var names, paths, key;
	key = name.asSymbol;
	model = model.sort({|a, b|
		if (a.metadata[\number] == b.metadata[\number]) {
			a.name < b.name
		} {
			a.metadata[\number] < b.metadata[\number]
		}
	});

	names = model.collect({ |cell| "% %".format(cell.metadata[\number].asStringToBase(10, 3), cell.name) });
	paths = model.collect({ |cell| cell.metadata[\path] });

	ListView().items_(names).mouseUpAction_({ |v, x, y, mod, btn, clickCount|
		var old = ~document;
		if (clickCount == 2) {
			~document = Document.open(~paths[v.value]);
			old !? (_.close);
		} {
			if (mod.isCmd) {
				var old = nowPlaying[key].stop;
				nowPlaying[key] = nil;
				if (old != model[v.value]) {
					nowPlaying[key] = model[v.value];
					nowPlaying[key].play;
				};
				// false;
			}
		}

	});

};
var buildListViews = {
	var friends = ~cells.friends.cells;
	var oneshots = ~cells.transitions.oneshots.cells;
	var bridges = ~cells.transitions.bridges.cells;
	//TODO: Play/stop on click;
	//TODO maybe make protos for each view
	~friendView.items = friends.collect({ |cell|
		cell.name;
	});
	~oneshotView.items = oneshots.collect({ |cell|
		cell.name;
	});
	~bridgeView.items = bridges.collect({ |cell|
		cell.name;
	});

};
var cells, loadPath = "../cells.scd".resolveRelative;
Window.closeAll;
~cells.free;
cells = loadPath.postln.load;
~cells = cells;
~paths = "/Users/johannes/kod/nattradion/celler/*/cell.scd".pathMatch;

~document = nil;
~win = Window("Ok", Window.availableBounds.width_(200)).layout_(VLayout(
	~playBtn = Button().states_([["Play"], ["Stop"]]).action_({ |b|
		//FIXME: not done
		doPlayAction.(b.value, \cell);
	}),
	//ListView with cells
	//Select (for play) on single click
	//Edit on double click

	listView.("Cells", ~cells.cells.values),

	StaticText().string_("Friends"),
	listView.("Friends", ~cells.friends.cells),
	//TODO display all onsets/bridges, or just filtered by cell?
	//Display list of onsets, play on click
	StaticText().string_("Oneshots"),
	listView.("Friends", ~cells.transitions.oneshots.cells),
	StaticText().string_("Bridges"),
	listView.("Friends", ~cells.transitions.bridges.cells),
	Button().states_([["Reload"]]).action_({
		~cells = loadPath.load;
		buildListViews.value;
	}.inEnvir);
)).front;

CmdPeriod.add( { ~playBtn.value = 0 }.inEnvir );
// buildListViews.value;
~cells.play;

)
