"lib/*".resolveRelative.pathMatch.do(_.load);
Cell({

	~template[\cells] = IdentityDictionary();

	~disabledCells = Set();

	~transitions = "lib/transitions.scd".resolveRelative.load;

	//cellBag is a bag-like data structure
	~friends = "lib/cellBag.scd".loadRelative[0];

	~cellData = "data/cellData.scd".loadRelative[0];

	//Returns a filter function for a given cell.
	//Every time cell is played, we use that function
	//to determine whether or not the cell should play together with a
	//friend.
	~friendFilterFactory = { |cell, debug=false|
		var filter = true, prob;
		var hasFriend = cell.settings[\hasFriend] ? 0;

		var validateProbability = { |prob|
			if (prob.isNumber) {
				prob.max(0).min(1);
			} {
				"Invalid value for friend probability".warn;
				0
			};
		};


		//If filter is passed as a dictionary, look for values in cell metadata
		//If function, use as is
		//return function

		var setupFilter = { |filter, prob|
			var fun = true; //default filter
			if (filter.isKindOf(Dictionary)) {
				fun = { |cell|
					var match = false;
					filter.keysValuesDo { |k, v|
						if (v.isString) {
							v = [v];
						} {
							v = v.asArray;
						};

						//Match if any metadata value matches
						cell.metadata[k].do { |val|
							if (v.includes(val)) {
								match = true;
							}
						};

					};
					match
				};
			} {
				if (filter.isFunction) {
					fun = filter;
				};
			};
			fun;
		};


		case { hasFriend.isNumber } {
			prob = validateProbability.(hasFriend);

		} { hasFriend.isKindOf(Dictionary) } {
			prob = validateProbability.(hasFriend[\prob] ? 1);
			filter = setupFilter.(hasFriend[\filter]);
		};
		if (debug) {
			prob.debug("Probability");
		};
		// Return function if prob
		if (prob > 0) {
			{ |cells|
				if (prob.coin) {
					cells = cells.select(filter);
					if (debug) {
						cells.debug("Filtered cells");
					};
					cells.choose
				}
			}
		} {
			nil
		}

	};

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

				//Update settings from our TSV-generated data blob
				~cellData[num] !? {
					cell.updateSettings(~cellData[num]);
				};

				//Remove old instances from friends and transitions
				//This is not useful now, but might become later if
				//we manage to get dynamic loading up and running
				~template[\cells][num] !? { |oldCell|
					~friends.removeCell(oldCell);
					~transitions.removeCell(oldCell);
				};

				cell.metadata[\number] = num;
				~template[\cells][num] = cell;

				~friends.checkAddCell(cell, \isFriend);
				~transitions.checkAddCell(cell);
				cell.friendFilter = ~friendFilterFactory.(cell);

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

	//I think we need to do this here, to be able to populate the
	//template before anything else
	//TODO see if this could be done in load instead
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
		//Override
	};

	~play = {
		//"no-op".postln;
	};


	~reloadCell = { |cell|
		var path = cell[\metadata][\path];
		//Don't think this works, actually
		~loadCellFromPath.(path);
	};

	~reload = { |self|
		currentEnvironment.free;
		currentEnvironment.load;
	};

	~editCell = { |cell|
		cell[\metadata][\path].openDocument;
	};

	~freeAll = {
		~friends.clearAll;
		~transitions.clearAll;
	}


}, \cells).name_("cells").load;

