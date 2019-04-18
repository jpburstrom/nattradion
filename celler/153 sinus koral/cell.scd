thisProcess.nowExecutingPath.debug("TODO");

"sinus-koral.scd".resolveRelative.load;


Cell({
~settings[\reverb] = (
		time: 3.5,
		amp: 0.2
	);

	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~template[\main] = (
		main: [\sinus_koral, [\duration, { ~settings[\duration] }]]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)


