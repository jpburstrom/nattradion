thisProcess.nowExecutingPath.debug("TODO");

"16-delar.scd".resolveRelative.load;


Cell({
~settings[\reverb] = (
		time: 1.2,
		amp: 0.2
	);

	~settings[\tempo] = 110; //TODO dynamic
	~load = {
		~settings[\duration] = 80.rrand(120);
	};
	~pattern = Pdef(\s16);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
