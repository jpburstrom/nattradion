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
		self.orig.do { |cell|
			self.current.add(cell);
		};
	},
	//Check cell and add if metadata matches key
	checkAddCell: { |self, cell, key|
		var count, modFunc,
		settings = cell.metadata !? (_[key]);
		settings !? {
			if (settings.isNumber) {
				count = settings;
			} {
				count = settings[\count];
				modFunc = settings[\modFunc];
			};

			//Pass count to modFunc, so we can have different inits for different cells
			count.do { |c|
				self.orig.add(cell.clone({
					modFunc.(c)
				}).name_("%_%-%".format(cell.name, key, c)))
			}

		}
	},
	cells: { |self|
		self.current
	},
	takeCell: { |self, filter|
		var cells;
		if (self.current.isEmpty) {
			self.init
		};
		cells = self.current;
		if (filter.notNil) {
			cells = cells.select(filter);
		};
		cells = cells.choose;
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

out.checkAddCell(Cell({
	~init = {
		~metadata = ();
		~metadata[\isriend] = (
			count: 3,
			modFunc: { |count|
				~test = count;
			};
		);
	}
}).name_("ok"), \isFriend);

out;
