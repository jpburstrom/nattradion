thisProcess.nowExecutingPath.debug("TODO");

"alps.scd".resolveRelative.load;

v = Cell({

	~load = {
		~settings[\duration] = 1
	};
	~settings[\reverb] = (
		time: 4,
		amp: 0.2
	);


	~template[\main] = (
		main: [\alps, \duration, { ~settings[\duration] }]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)




