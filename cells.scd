Cell({

	~load = {
		~cells = IdentityDictionary();
		"celler/*/cell.scd".resolveRelative.pathMatch.collect { |path|
			var cell, num;
			var dir = path.dirname;
			var metadata = IdentityDictionary();

			// Get metadata from info.txt
			(dir +/+ "info.txt").parseYAMLFile.keysValuesDo({ |k, v|
				metadata[k.asSymbol] = v
			});

			// cell.scd should return a Cell instance
			cell = path.load;

			if (cell.isKindOf(Cell)) {
				// Add metadata;
				cell.metadata = metadata;
				// If tempo is not set in cell, get tempo from metadata
				cell.settings[\tempo] = cell.settings[\tempo] ? metadata[\tempo];
				cell.name = metadata[\title];

				// Get number from directory name
				num = dir.basename.split(Char.space).first.asInteger;
				cell.metadata[\number] = num;
				~cells[num] = cell;
			} {
				// PathName(path).pathOnly.openOS;
				Error("Path at % should return a cell".format(path)).throw;
			}
		};

	};

	~freeAll = {
		~cells.do(_.free);
		~cells.clear;
	};

	~reload = { |self|
		currentEnvironment.free;
		currentEnvironment.load;
	};


}).name_("cells").load;

