thisProcess.nowExecutingPath.debug("TODO");

"rockring.scd".resolveRelative.load;

Cell({

	~settings[\numChannels] = 2;
	~settings[\tempo] = 95; // TODO dynamic tempo

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~template[\main] = (
		ringmod: [\rockring_ringmod, [\tempo, { ~settings[\tempo] }, \baseFreq, 220]]
	);

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
