var fun = "lib/functions.scd".resolveRelative.load;
var cells = "cells.scd".resolveRelative.load;
var win, content, footer;
var path = thisProcess.nowExecutingPath;
~makeWindow = {
	var actionBtn = "gui/actionBtn.scd".resolveRelative.load;
	defer {
		win = Window.new("Celler", Rect(0, 0, 800, 600).center_(Window.availableBounds.center)).layout_(VLayout());
		content = View(win).layout_(HLayout().spacing_(0).margins_(0));
		footer = View(win).layout_(HLayout().spacing_(0).margins_(0));
		actionBtn.value(footer, "Reload", {
			win.close;
			path.load
		});
		footer.layout.add(nil);
		"gui/cells.scd".resolveRelative.load.value(content, cells, "Cells");
		"gui/cells.scd".resolveRelative.load.value(content, cells, "Friends");
		// "gui/transitions.scd".resolveRelative.load.value(content, cells.transitions);

		win.front;
	}
};

~makeWindow.value;

