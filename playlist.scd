Cell({

	var cells;

	~transitions = "lib/transitions.scd".resolveRelative.load;

	//cellBag is a bag-like data structure
	~friends = "lib/cellBag.scd".loadRelative[0];

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

	~load = {
		~routine.reset;

		//Convert dict of cells to an array
		~cells = currentEnvironment.mother !? { |m| m[\cells].cells.values.asArray };

		~cells.do { |cell|
			~friends.checkAddCell(cell, \isFriend);
			~transitions.checkAddCell(cell);
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


