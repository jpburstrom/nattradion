"cellBag.scd".resolveRelative.load.putAll((
	extra: List(),
	//Modify this function so it takes a
	//addCell: { |self, count, modFunc, key, collection|

	//Add cell as extra friend -- won't be a part of main collection
	addExtraFriend: { |self, cell, modFunc|
		self.addFriend(cell, 1, modFunc, \extraFriend, self.extra);
	},

	//Similar to the function in cellBag, but look for cells in both current and extra
	takeCell: { |self, filter|
		var cells;
		if (self.current.isEmpty) {
			self.init
		};
		cells = self.filteredCells(filter, self.current) ?? {
			self.filteredCells(filter, self.extra);
		};
		// filter may cause nil output for a long time
		// if non-matching friends are all that's left
		// so only go on without friends for so long
		if (cells.isNil) {
			self.nilCount = self.nilCount + 1;
			if (self.nilCount == self.nilThreshold) {
				self.init;
			}
		} {
			cells = cells.choose;
		};
		// We can safely remove from current even if we've used the extra collection
		// Since the extra collection shouldn't share items with current
		// If remove doesn't find the item it's a no-op
		self.current.remove(cells);
		cells;
	}

))