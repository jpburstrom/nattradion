Cell({

	var cells;



	//Create the playlist routine on init
	~init = {
		~routine = Routine({
			var i = 0, old;
			var prevCell;
			var friend;
			var list = ~cells[\cells].values.asArray;
			var count = 0;
			//filter out disabled cells
			//this is done already on load, but maybe we

			Cell.debug = false;
			inf.do {
				list.scramble.do { |cell|

					if (friend.isNil || prevCell.isNil
						or: {
							(friend.timeToPos(\playEnd) ? 0) <
							(prevCell.timeToPos(\playEnd) ? inf)
						}
					) {
						friend = ~pickNewFriend.value(cell);
					};

					//Some things depend on cell needing to know
					//if they have a friend.
					//We set the friend variable before loading,
					//So loading can be affected if needed
					cell.friend = friend; //can be nil.

					//This is a possibility, but we try to not use it
					//It's more complicated, since friends' cells can change
					//during play
					//friend !? { |f| f.friend = cell };

					cell.load;

					if (prevCell.notNil) {
						//Wait and transit
						~transitions.chooseTransition(prevCell, cell);

					} {
						cell.play;
					};

					count = 0;

					if (friend.notNil and: { friend.isPlaying.not }) {
						~playFriend.(friend, cell);
					};

					~cells.setReverb(cell);

					~postDebugOutput.(cell);

					prevCell = cell;

				};
			}
		}.inEnvir);
	};

	~pickNewFriend = { |cell|
		var friend = ~cells.getFriendFor(cell);
		friend.debug("New friend");
		friend !? (_.load);
		friend;
	};

	~playFriend = { |friend, cell|
		var rest;
		// Pass a reference to cell
		// If we want any metadata (tempo etc)
		friend.set("level.main.amp", -12.dbamp);

		rest = (cell.settings.duration - friend.settings.duration).max(0);

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


