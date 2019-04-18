var cells = "cells.scd".resolveRelative.load;
var win, content, footer;
var path = thisProcess.nowExecutingPath;
~makeWindow = {
	var cellList = cells[\cells].values.sort({ |a, b|
		a.metadata[\number] < b.metadata[\number]
	});
	var actionBtn = { |parent, name, action|
		Button(parent).states_([[name]]).action_(action);
	};
	defer {
		var makeSlot = { |name|
			var cell = cellList[0];
			var playing;
			var setReverb = {

				"seeting reverb".postln;
				if (cell.settings[\reverb].notNil) {
					cells.set("fx.reverb.amp", cell.settings[\reverb][\amp] ? 0);
					cell.settings[\reverb][\time] !? { |time|
						cells.set("fx.reverb.time", time);
					}
				} {
					cells.set("fx.reverb.amp", 0);
				}

			};
			var view = View(content).layout_(HLayout().spacing_(0).margins_(0, 5));
			var list = ListView(view).action_({ |lv|
				cell = cellList[lv.value];
				if (playing.isPlaying) {
					playing.freeAll;
					cells.reloadCell(cell);
					playing = cell.play;
					setReverb.value;
				};
				fork {
					cell.wait;
					defer {
						playBtn.value = cell.isPlaying.asInteger;
					}
				}
			});
			var btns = View(view).layout_(VLayout().spacing_(0).margins_([10, 0]));
			var playBtn	= Button(btns).states_([["Stopped"], ["Playing"]]).action_({ |btn|
				if (cells.isPlaying.not) {
					cells.play;
				};
				if (btn.value == 0) {
					cell.freeAll;
				} {
					if (playing.isPlaying) { playing.freeAll } ;
					cells.reloadCell(cell);
					playing = cell.play;
					setReverb.value;
				};
			});

			var reloadBtn = Button(btns).states_([["Reload"]]).action_({ |btn|
				cellList[list.value] = try {
					cells.reloadCell(cell)
				} { |err|
					err.postProtectedBacktrace;
					cell
				};
			});

			var editBtn = Button(btns).states_([["Edit"]]).action_({ |btn|
				cells.editCell(cell);
			});
			var fadeBtn = Button(btns).states_([["Fade in"]]).action_({ |btn|
				if (cell.isPlaying.not) {
					cell.fadeIn(5);
				};
			});
			var fadeOutBtn = Button(btns).states_([["Fade out"]]).action_({ |btn|
				if (cell.isPlaying) {
					cell.fadeOut(5);
				}
			});
			btns.layout.add(nil);

			list.items = cellList.collect { |cell| "% %".format(cell.metadata[\number], cell.metadata[\title]) };
			list.items.postln;

			view.refresh
		};
		win = Window.new("Celler", Rect(0, 0, 400, 600).center_(Window.availableBounds.center)).layout_(VLayout());
		content = View(win).layout_(HLayout().spacing_(0).margins_(0));
		footer = View(win).layout_(HLayout().spacing_(0).margins_(0));
		actionBtn.value(footer, "Reload", {
			win.close;
			path.load
		});
		footer.layout.add(nil);
		1.do { |index|
			makeSlot.(index);
		};

		win.front;
	}
};

~makeWindow.value;

