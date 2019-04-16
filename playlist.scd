Cell({

	var cells;

	~init = {
		~routine = Routine({
			var i = 0, old;
			var waitStream = Pexprand(2, 30).asStream;
			cells
			//filter out disabled cells
			//this is done already on load, but maybe we
			.reject { |cell| cell.settings[\disabled] == true }
			.do { |cell|
				var dur;
				cell.load;
				cell.name.postln;
				dur = cell.settings[\duration];
				if (dur != 0 and: { dur != inf }) {
					old !?  { |oc|
						var clock = oc.settings[\clock] ? TempoClock.default;
						clock.schedAbs(
							oc.quant.nextTimeOnGrid(clock), {
								oc.stop;
								cell.play;
						});
					} ?? { cell.play };
					dur.wait;
					old = cell;
				} {
					"Freeing synth -- things are bad".postln;
					cell.freeAll;
				};
			};
		}.inEnvir);
	};

	~load = {
		~routine.reset;
		cells = currentEnvironment.mother.cells.cells;
		//Do something here, sort etc;
		cells = cells.values.asArray.scramble;
	};

	~play = {
		~routine.play;
	};

	~stop = {
		~routine.stop;
	};

	//Things free themselves in other ways
	~freeAll = {
		"free".postln;
	};


}).name_("playlist")


