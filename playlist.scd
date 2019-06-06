Cell({

	var cells;

	~transitions = "lib/transitions.scd".resolveRelative.load;

	//cellBag is a bag-like data structure
	~friends = "lib/cellBag.scd".loadRelative[0];

	//Returns a filter function for a given cell.
	//Every time cell is played, we use that function
	//to determine whether or not the cell should play together with a
	//friend.
	~friendFilterFactory = { |cell, debug=false|
		var filter = true, prob;
		var hasFriend = cell.settings[\hasFriend] ? 0;

		var validateProbability = { |prob|
			prob.postln;
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
			prob = validateProbability(hasFriend[\prob] ? 1);
			filter = setupFilter(hasFriend[\filter]);
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

	//Use cell reverb settings to set the global reverb
	~setReverb = { |cell|
		var mom = cell.mother;
		if (cell.settings[\reverb].notNil) {
			mom.set("fx.reverb.amp", cell.settings[\reverb][\amp] ? 0);
			cell.settings[\reverb][\time] !? { |time|
				mom.set("fx.reverb.time", time);
			}
		} {
			mom.set("fx.reverb.amp", 0);
		};
	};

	//Create the playlist routine on init
	~init = {
		~routine = Routine({
			var i = 0, old;
			var prevDur=0.2, offset, endTime, prevCell;
			//filter out disabled cells
			//this is done already on load, but maybe we

			Cell.debug = true;
			inf.do {
				~cells.scramble.do { |cell|
					cell.load;

					if (prevCell.notNil) {
						//Wait and transit
						~transitions.chooseTransition(prevCell, cell);
						//TODO: transitions should maybe
					} {
						cell.play;
					};

					~setReverb.(cell);

					~postDebugOutput.(cell);

					prevCell = cell;

				};
			}
		}.inEnvir);
	};

	~postDebugOutput = { |cell|
		cell.getDuration.debug(cell.name);
		fork {
			var i = 10;
			i.do {
				".".post;
				(cell.getDuration / i).wait;
			};
			" Done.".postln;
		};
	};

	//Load cells
	~load = {
		~routine.reset;
		~friends.clearAll;
		~transitions.clearAll;

		//Convert dict of cells to an array
		~cells = currentEnvironment.mother !? { |m| m[\cells].cells.values.asArray };

		~cells.do { |cell|
			~friends.checkAddCell(cell, \isFriend);
			~transitions.checkAddCell(cell);

			cell.friendFilter = currentEnvironment.friendFilterFactory(cell);
		};


	};

	~play = {
		~routine.play(SystemClock);
	};

	~stop = {
		~routine.stop;
	};

	//Things free themselves in other ways
	~freeAll = {
		"free".postln;
	};


}).name_("playlist")


