thisProcess.nowExecutingPath.debug("TODO");

"gravitationspunkt.scd".resolveRelative.load;


Cell({
	~settings[\reverb] = (
		time: 8,
		amp: 0.05
	);

	~settings[\tempo] = 120;
	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~pattern = Pdef(\gravity);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
