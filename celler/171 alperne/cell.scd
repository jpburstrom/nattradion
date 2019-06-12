
"alps.scd".resolveRelative.load;

Cell({

	~load = {
		~settings[\duration] = 60.rrand(130);
	};
	~settings[\reverb] = (
		time: 4,
		amp: 0.2
	);


	~template[\main] = (
		main: [\alps, \duration, { ~settings[\duration] }]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)




