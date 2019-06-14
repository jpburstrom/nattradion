Cell({

	var cells;



	//Create the playlist routine on init
	~init = {
		~routine = Routine({
			var i = 0, old;
			var prevDur=0.2, offset, endTime, prevCell;
			var friend;
			var list = ~cells[\cells].values.asArray;
			var count = 0;
			//filter out disabled cells
			//this is done already on load, but maybe we

			Cell.debug = false;
			inf.do {
				list.scramble.do { |cell|
					cell.load;

					if (prevCell.notNil) {
						//Wait and transit
						~transitions.chooseTransition(prevCell, cell);

					} {
						cell.play;
					};
					cell.settings.tempo.debug("TEMPO");
					count = 0;
					// Pick a friend from current list of friends,
					// According to cell's friendFilter
					if (friend.isPlaying.not) {
						friend = ~cells.getFriendFor(cell);
						cell.friend = friend; //can be nil. NB cell is already playing
						friend !? {
							var rest;
							// Pass a reference to cell
							// If we want any metadata (tempo etc)
							friend.load;
							friend.set("level.main.amp", -12.dbamp);

							rest = (cell.settings.duration - friend.settings.duration).max(0);

							// If we want any metadata (tempo etc)
							//
							friend.friend = cell;

							fork {
								var ft;
								rest.rand.wait;
								TempoClock.timeToNextBeat(Quant(1, 0, friend.timeToPos(\start))).wait;
								friend.name.debug("Friend");
								if (0.3.coin) {
									friend.fadeIn(5.rrand(15))
								} {
									friend.play;
								};
								ft = 5.rrand(15).min(friend.timeToPos(\end));
								friend.waitForPos(\end, ft.neg);
								friend.fadeOut(ft);
							};

						} ?? {
							"Didn't want a new friend".postln
						}
					} {
						"Friend already playing, won't pick new one".postln
					};

					~cells.setReverb.(cell);

					~postDebugOutput.(cell);

					prevCell = cell;

				};
			}
		}.inEnvir);
	};

	~postDebugOutput = { |cell|
		cell.getDuration.debug(cell.name);
	};

	//Load cells
	~load = {
		~routine.reset;

		//Convert dict of cells to an array
		currentEnvironment.mother !? { |m|
			~cells = m[\cells];
			~transitions = ~cells.transitions;
			~friends = ~cells.friends;
		};



	};

	~play = {
		~routine.play;
	};

	~stop = {
		~routine.stop;
	};


}).name_("playlist")


