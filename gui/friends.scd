var actionBtn = "actionBtn.scd".resolveRelative.load;

{ |parent, friends, name="friends"|
	var cell = friends.cells[0].postln;
	var container = View(parent).layout_(VLayout(
		StaticText().string_(name).align_(\center);
	).spacing_(5).margins_(0, 5));
	var view = View(container).layout_(HLayout().spacing_(0).margins_(0, 5));
	var list = ListView(view).action_({ |lv|
		cell = friends[lv.value];
	});

	list.items = friends.cells.collect { |cell| cell.name; };

	view.refresh
}