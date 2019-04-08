thisProcess.nowExecutingPath.debug("TODO");

"alps.scd".resolveRelative.load;


Cell({

	~template[\main] = (
		main: [\alps]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)
