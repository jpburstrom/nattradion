var actionBtn = "actionBtn.scd".resolveRelative.load;

{ |parent, cells, name="cells", toolbar=true|
	var cellList = cells[\cells].values.sort({ |a, b|
		a.metadata[\number] < b.metadata[\number]
	});
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
	var container = View(parent).layout_(VLayout(
		StaticText().string_(name).align_(\center);
	).spacing_(5).margins_(0, 5));
	var view = View(container).layout_(HLayout().spacing_(0).margins_(0, 5));
	var list = ListView(view).action_({ |lv|
		cell = cellList[lv.value];
		if (playing.isPlaying) {
			playing.freeAll;
			cells.reloadCell(cell);
			playing = cell.play;
			setReverb.value;
		};
		if (toolbar) {
			fork {
				cell.wait;
				defer {
					playBtn.value = cell.isPlaying.asInteger;
				}
			}
		}
	});
	var btns, playBtn, reloadBtn, editBtn, fadeBtn, fadeOutBtn;
	if (toolbar) {
		btns = View(view).layout_(VLayout().spacing_(0).margins_([10, 0]));
		playBtn	= Button(btns).states_([["Stopped"], ["Playing"]]).action_({ |btn|
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

		reloadBtn = Button(btns).states_([["Reload"]]).action_({ |btn|
			cellList[list.value] = try {
				cells.reloadCell(cell)
			} { |err|
				err.postProtectedBacktrace;
				cell
			};
		});

		editBtn = Button(btns).states_([["Edit"]]).action_({ |btn|
			cells.editCell(cell);
		});
		fadeBtn = Button(btns).states_([["Fade in"]]).action_({ |btn|
			if (cell.isPlaying.not) {
				cell.fadeIn(5);
			};
		});
		fadeOutBtn = Button(btns).states_([["Fade out"]]).action_({ |btn|
			if (cell.isPlaying) {
				cell.fadeOut(5);
			}
		});
		btns.layout.add(nil);
	};

	list.items = cellList.collect { |cell| "% %".format(cell.metadata[\number], cell.metadata[\title]) };
	list.items.postln;

	view.refresh
}