thisProcess.nowExecutingPath.debug("TODO");

"dteht.scd".resolveRelative.load;


Cell({
~settings[\reverb] = (
		time: 4.8,
		amp: 0.1
	);

	~settings[\tempo] = 120;
	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~pattern = Pdef(\dteht);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
