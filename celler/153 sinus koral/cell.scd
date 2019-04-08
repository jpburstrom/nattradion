thisProcess.nowExecutingPath.debug("TODO");

"sinus-koral.scd".resolveRelative.load;


Cell({

	~template[\main] = (
		main: [\sinus_koral]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)
