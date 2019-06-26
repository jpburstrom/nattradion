// A bag for cells
// But not really, since we need all cells to be unique
// Resets to original when empty
// Check and add if metadata matches with checkAddCell(cell, key)
// Get one cell with takeCell(filter)
var out = (
	orig: List(),
	current: List(),
	nilCount: 0,
	//Reset after so many nils in a row
	nilThreshold: 5,
	clearAll: { |self|
		self.current.clear;
		self.orig.clear;
	},
	init: { |self|
		self.nilCount = 0;
		self.current.clear;
		self.orig.do { |cell|
			self.current.add(cell);
		};
	},
	//Check cell and add if metadata matches key
	checkAddCell: { |self, cell, key|
		var count, modFunc,
		settings = cell.settings !? (_[key]);
		settings !? {
			if (settings.isNumber) {
				count = settings;
			} {
				count = settings[\count];
				modFunc = settings[\modFunc];
			};
			//Pass count to modFunc, so we can have different inits for different cells
			count.asInteger.do { |c|
				var name = "%_%-%".format(cell.name, key, c);
				var copy = cell.clone({
					modFunc.(c)
				})
				.name_(name);
				copy.metadata ?? { copy.metadata = () };
				cell.metadata.keysValuesDo { |k, v|
					if (copy.metadata.notNil) {
						copy.metadata[k] = v;
					}
				};
				self.orig.add(copy);
			}

		}
	},
	setMother: { |self, mom|
		self.orig.do { |cell|
			cell.setMother(mom);
		};
	},
	cells: { |self|
		self.current
	},
	removeCell: { |self, cell|
		self.orig.remove(cell);
		self.current.remove(cell);
	},
	removeCellsByMetadata: { |self, key, value|
		var cells = List();
		self.orig.do { |cell|
			if (cell.metadata[key] == value) {
				cells.add(cell);
			}
		};
		cells.do { |cell|
			self.removeCell(cell)
		};
	},
	takeCell: { |self, filter|
		var cells;
		if (self.current.isEmpty) {
			self.init
		};
		cells = self.current;
		if (filter.notNil) {
			cells = filter.value(cells);
		} {
			cells = cells.choose;
		};
		// filter may cause nil output for a long time
		// if non-matching friends are all that's left
		// so only go on without friends for so long
		if (cells.isNil) {
			self.nilCount = self.nilCount + 1;
			if (self.nilCount == self.nilThreshold) {
				self.init;
			}
		};
		self.current.remove(cells);
		cells;
	},
	matchesForFilter: { |self, filter=true|
		self.orig.select(filter).size;
	}
);

out;
