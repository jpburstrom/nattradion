thisProcess.nowExecutingPath.debug("TODO");

"alps.scd".resolveRelative.load;

v = Cell({

	~load = {
		~settings[\duration] = 1
	};


	~template[\main] = (
		main: [\alps, \duration, { ~settings[\duration] }]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)




