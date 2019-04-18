thisProcess.nowExecutingPath.debug("TODO");

"tolvstammigt.scd".resolveRelative.load;


Cell({
	~settings[\tempo] = 110;
	~load = {
		~settings[\duration] = 30.rrand(60);
	};

	~settings[\reverb] = (
		time: 4,
		amp: 0.05
	);


	~pattern = Pdef(\tolv);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
