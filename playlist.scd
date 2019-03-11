c = Cell({

	~routine = Routine({
		var i = 0;
		loop {
			i.postln;
			1.yield;
			i = i + 1;
		};
	});

	~load = {
		~routine.reset;
	};

	~play = {
		~routine.play;
	};

	~stop = {
		~routine.stop;
	};
}).name_("playlist");
