Cell({

	var cells;

	~init = {
		~routine = Routine({
			var i = 0, old;
			var prevDur=0, offset, endTime, prevCell;
			var cells, cellsCell = currentEnvironment.mother.cells;
			//filter out disabled cells
			//this is done already on load, but maybe we
			cells = cellsCell.cells.reject { |cell| cell.settings[\disabled] == true };
			inf.do {
				cells.do { |cell|
					var wait;
					cell.load;
					offset = ((cell.markers[\start] ? 0) / cell.server.sampleRate).max(0);
					wait = ((prevDur - offset) ).wait;

					if (cell.settings[\reverb].notNil) {
						cellsCell.set("fx.reverb.amp", cell.settings[\reverb][\amp] ? 0);
						cell.settings[\reverb][\time] !? { |time|
							cellsCell.set("fx.reverb.time", time);
						}
					} {
						cellsCell.set("fx.reverb.amp", 0);
					};
					cell.name.postln;

					//Ignore quant
					cell.settings[\quant] = 0;
					cell.play;

					prevDur = ((cell.markers[\end] !? { |x|
						x / cell.server.sampleRate
					}) ? cell.settings[\duration].value) - offset;

				};
			}
		}.inEnvir);
	};

	~load = {
		~routine.reset;
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


