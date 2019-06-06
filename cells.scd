Cell({

	~template[\cells] = IdentityDictionary();

	~disabledCells = Set();

	~loadCellFromPath = { |path|
		var cell, num;
		var dir = path.dirname;
		var metadata = IdentityDictionary();

		// Get metadata from info.txt
		(dir +/+ "info.txt").parseYAMLFile.keysValuesDo({ |k, v|
			metadata[k.asSymbol] = v
		});

		cell = path.load;

		if ((cell.settings[\disabled] == true).not) {

			if (cell.isKindOf(Cell)) {
				// Add metadata;
				cell.metadata = metadata;
				cell.metadata[\path] = path;
				// If tempo is not set in cell, get tempo from metadata
				cell.settings[\tempo] = cell.settings[\tempo] ? metadata[\tempo];
				cell.name = metadata[\title];

				// Get number from directory name
				num = dir.basename.split(Char.space).first.asInteger;
				cell.metadata[\number] = num;
				~template[\cells][num] = cell;
				cell
			} {
				// PathName(path).pathOnly.openOS;
				Error("Path at % should return a cell".format(path)).throw;
			}
		} {
			"Cell % disabled".format(cell.name).postln;
			~disabledCells.add(cell);
		}
	};

	"celler/*/cell.scd".resolveRelative.pathMatch.do { |path|
		// cell.scd should return a Cell instance
		~loadCellFromPath.(path);
	};

	//Some cell code sets tempo in various ways, let's reset that
	TempoClock.tempo = 1;

	~init = {

		~updateTemplate.((
			group: #[main, fx, level, out],
			fx: [
				limiter: [\limiter, [\preamp, 9.dbamp]],
				reverb: [\hall],
			]
		));

	};

	~load = {
		//"nop".postln;
	};

	~play = {
		//"no-op".postln;
	};


	~reloadCell = { |cell|
		var path = cell[\metadata][\path];
		~loadCellFromPath.(path);
	};

	~reload = { |self|
		currentEnvironment.free;
		currentEnvironment.load;
	};

	~editCell = { |cell|
		cell[\metadata][\path].openDocument;
	};


}, \cells).name_("cells");

