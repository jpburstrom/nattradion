var fun = "lib/functions.scd".resolveRelative.load;
var cells = "cells.scd".resolveRelative.load;
var win, content, footer;
var path = thisProcess.nowExecutingPath;
~makeWindow = {
	var cellgui, friends, transitions, target;
	var actionBtn = "gui/actionBtn.scd".resolveRelative.load;
	defer {
		win = Window.new("Celler", Rect(0, 0, 1000, 600).center_(Window.availableBounds.center)).layout_(VLayout());
		content = View(win).layout_(HLayout().spacing_(0).margins_(0));
		footer = View(win).layout_(HLayout().spacing_(0).margins_(0));
		actionBtn.value(footer, "Reload", {
			win.close;
			path.load
		});
		footer.layout.add(nil);
		cellgui = "gui/cells.scd".resolveRelative.load.value(content, cells, "Cells");
		friends = "gui/friends.scd".resolveRelative.load.value(content, cells.friends, "Friends");
		transitions = "gui/transitions.scd".resolveRelative.load.value(content, cells.transitions);
		target = "gui/cells.scd".resolveRelative.load.value(content, cells, "Target", false);

		win.front;
	}
};

~makeWindow.value;

