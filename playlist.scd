Cell({

	~init = {
		~routine = Routine({
			var i = 0, old;
			~cells.postln.do { |cell|
				var dur;
				cell.name.postln;
				cell.load;
				if (dur != 0 and: { dur != inf }) {
					cell.fadeIn(5);
					old !? (_.fadeOut(5));
					15.wait;
					old = cell;
				} {
					cell.freeAll;
				};
			};
		}.inEnvir);
	};

	~load = {
		~routine.reset;
		~cells = currentEnvironment.mother.cells.cells;
		//Do something here, sort etc;
		~cells = ~cells.values.asArray.scramble;
	};

	~play = {
		~routine.play;
	};

	~stop = {
		~routine.stop;
	};


}).name_("playlist");

