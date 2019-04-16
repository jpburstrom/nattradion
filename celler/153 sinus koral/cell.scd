thisProcess.nowExecutingPath.debug("TODO");

"sinus-koral.scd".resolveRelative.load;


Cell({

	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~template[\main] = (
		main: [\sinus_koral]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)


