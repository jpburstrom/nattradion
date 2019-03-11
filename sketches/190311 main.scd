Cell.addMethod {
	~timeUntilNextCellPlay = { |cell, prev|
		// If duration is even multiple of quant,
		// time = (duration - timePlayed)
		// Otherwise
		// time = (quant * (duration / quantInSeconds).floor) - timePlayed
	};
}
CellDef(\main, {

	load {
		~loadCells.value;
	};

	play {

		~routine = fork {
			var order = ~randomizeOrder.value;

			order.do { |cell|
				~next = cell;
				~current.timeUntilNextCellLoad(cell).wait;
				~next.load;
				~current.timeUntilNextCellPlay(cell).wait;
				~next.play;
				// Schedule a stop at quant/stopQuant
				~current.scheduleStop;
				~current = ~next;
				currentEnvironment.changed(\current, cell);
				// If cannotStopItself, stop please
			};
		};
	};


	stop {
		~current.stop;
		~previous.stop;
		~routine.stop;
	};

};