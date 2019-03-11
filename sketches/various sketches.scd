/*
Various parameters
Global tempo
Global params: Intensity, Activity, Weirdness, Randomness... ??
Local tempo
Local params: Time (relative to cell duration), Time (relative to phrase)
Global events
Local events: onsets, phrases,
Spy on other cells' local events
*/


(
//UI test
var draglv = { ListView().beginDragAction_({ |view, x, y|
	view.items[view.value];
})
};
var droplv = {
	draglv.value.receiveDragHandler_({ |view, x, y|
		if (View.currentDrag.isString) {
			view.items = view.items.add(View.currentDrag);
		}
	})
};
var lv2 = {
	var cells = PathName("~/Dropbox/Delat/Nattradion/celler/").folders.collect(_.folderName);
	draglv.value.items_(cells);
};

~win !? { ~win.close };
~win = Window.new.front.layout_(VLayout());
View(~win).layout_(GridLayout.rows(
	8.collect { Slider().orientation_(\vertical) },
	#[tempo, intensity, density, weirdness,
		glitter, muddyness, randomness, boredom].collect { |lbl|
		StaticText().string_(lbl)
	}
));
View(~win).layout_(HLayout(
	droplv.value,
	droplv.value,
	lv2.value
));
~win.layout.add(nil);
~win.front;
)

