"lib/*".resolveRelative.pathMatch.do(_.load);
Cell({

	~template[\cells] = IdentityDictionary();

	~disabledCells = Set();

	~transitions = "lib/transitions.scd".resolveRelative.load;

	//cellBag is a bag-like data structure
	~friends = "lib/friends.scd".loadRelative[0];
	~extraFriendNumbers = Set();

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
						var cellVal;

						if (v.isString) {
							v = [v];
						} {
							v = v.asArray;
						};

						//Match if any metadata value matches
						cellVal = cell.metadata[k];

						if (cellVal.isString) {
							cellVal = [cellVal];
						} {
							cellVal = cellVal.asArray;
						};

						cellVal.do { |val|
							if (v.includesEqual(val)) {
								match = true;
							}
						};

					};
					match
				};
			} {
				if (filter.isFunction) {
					fun = filter;
				} {
					true
				}
			};
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

		cell.friendProbability = prob;

		//Return a function filtering an array of cell objects according to metadata
		//or function
		{ |friend|
			[friend.metadata[\number], cell.metadata[\number]];
			friend.metadata[\number] != cell.metadata[\number] and: { filter.value(friend) };
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

		cell = try { path.load };


		if (cell.notNil) {

			if ((cell.settings[\disabled] == true).not) {

				if (cell.isKindOf(Cell)) {
					// Add metadata;
					// TODO merge with cell metadata?
					cell.metadata = metadata;
					cell.metadata[\tags] = cell.metadata[\tags].collect({ |t|
						t.toLower.asSymbol
					});
					#[tempo, rating].do { |k|
						cell.metadata[k] = cell.metadata[k] !? (_.asFloat)
					};
					cell.metadata[\path] = path;
					// If tempo is not set in cell, get tempo from metadata
					cell.settings[\tempo] = cell.settings[\tempo] ? metadata[\tempo];
					cell.name = metadata[\title];

					// Get number from directory name
					num = dir.basename.split(Char.space).first.asInteger;

					//Remove old instances from friends and transitions
					~friends.removeCellsByMetadata(\number, num);
					~transitions.removeCellsByMetadata(\number, num);

					cell.metadata[\number] = num;
					~template[\cells] !? { |cellTemplate|
						cellTemplate[num] = cell;
					};

					// If we're reloading an already existing cell,
					// we need to reassign
					if ((~cells !? (_[num])).notNil) {
						~cells[num].free;
						~cells[num] = cell;
					};

					//Check if cell is friend and/or transition material,
					//In that case add to respective collection
					~friends.checkAddCell(cell, \isFriend);
					~transitions.checkAddCell(cell);

					//Hack: If cell is filtering out a single friend by number,
					//add it to extra friends
					//(Extra friends are "hidden" friends which is only called out
					//by number)
					//TODO: refactor this, it's ugly
					if (cell.settings[\hasFriend].isKindOf(Dictionary)) {
						cell.settings[\hasFriend][\number] !? { |num|
							~extraFriendNumbers.add(num)
						}
					};



					cell.friendFilter = ~friendFilterFactory.(cell);

					cell
				} {
					// PathName(path).pathOnly.openOS;
					Error("Path at % should return a cell".format(path)).throw;
				}
			} {
				"Cell % disabled".format(cell.name).postln;
				~disabledCells.add(cell);
			};
		} {
			"Failed loading cell at %".format(path).warn;
			nil
		}
	};

	//I think we need to do this here, to be able to populate the
	//template before anything else
	//TODO see if this could be done in load instead
	"celler/*/cell.scd".resolveRelative.pathMatch.do { |path|
			// cell.scd should return a Cell instance
		~loadCellFromPath.(path);
	};

	~friends.extra.clear;

	~extraFriendNumbers.do { |num|
		~friends.addExtraFriend(~cells[num]);
	};

	//Some cell code sets tempo in various ways, let's reset that
	TempoClock.tempo = 1;

	~init = {

		//XXX Mother (currentEnvironment) doesn't know about these
		//children, which might be a problem.
		~friends.setMother(currentEnvironment);
		~transitions.setMother(currentEnvironment);

		~friends.init;
		~transitions.init;

		~updateTemplate.((
			group: #[main, fx, level, out],
			fx: [
				limiter: [\limiter, [\preamp, 9.dbamp]],
				reverb: [\hall],
			]
		));

	};


	//Use cell reverb settings to set the global reverb
	~setReverb = { |cell|
		var mom = currentEnvironment;
		if (cell.settings[\reverb].notNil) {
			mom.set("fx.reverb.amp", cell.settings[\reverb][\amp] ? 0);
			cell.settings[\reverb][\time] !? { |time|
				mom.set("fx.reverb.time", time);
			}
		} {
			mom.set("fx.reverb.amp", 0);
		};
	};

	~load = {
		//Override
	};

	~play = {
		//"no-op".postln;
	};

	//Return cell or nil
	~getFriendFor = { |cell|
		if ((cell.friendProbability ? 0).coin) {
			~friends.takeCell(cell[\friendFilter]);
		};
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


}, \cells).name_("cells");
