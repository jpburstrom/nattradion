thisProcess.nowExecutingPath.debug("TODO");

"alps.scd".resolveRelative.load;


Cell({

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~template[\main] = (
		main: [\alps]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)
