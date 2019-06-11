Cell({

	var cells;



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
			var friend;
			//filter out disabled cells
			//this is done already on load, but maybe we

			Cell.debug = true;
			inf.do {
				~cells.scramble.do { |cell|
					cell.load;

					if (prevCell.notNil) {
						//Wait and transit
						~transitions.chooseTransition(prevCell, cell);

					} {
						// Pick a friend from current list of friends,
						// According to cell's friendFilter
						if (friend.isPlaying.not) {
							friend = ~friends.takeCell(cell[\friendFilter]);
							friend !? {
								// Pass a reference to cell
								// If we want any metadata (tempo etc)
								friend.friend = cell;
								friend.play;
							}
						};
						// Pass a reference to cell
						// If we want any metadata (tempo etc)
						cell.friend = friend; //can be nil
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

		//Convert dict of cells to an array
		currentEnvironment.mother !? { |m|
			var cells = m[\cells];
			~cells = cells[\cells].values.asArray;
			~transitions = cells.transitions;
			~friends = cells.friends;
		};



	};

	~play = {
		~routine.play(SystemClock);
	};

	~stop = {
		~routine.stop;
	};


}).name_("playlist")


