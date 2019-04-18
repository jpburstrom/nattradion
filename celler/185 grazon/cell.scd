thisProcess.nowExecutingPath.debug("TODO");

"grazon.scd".resolveRelative.load;


Cell({

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~template[\main] = (
		//TODO: tempo
		main: [\grazon,
			[\duration, { ~settings[\duration] }];
		]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)

