thisProcess.nowExecutingPath.debug("TODO");

"grazon.scd".resolveRelative.load;


Cell({

	~template[\main] = (
		//TODO: tempo
		main: #[grazon]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)
