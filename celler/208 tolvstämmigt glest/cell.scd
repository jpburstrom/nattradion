thisProcess.nowExecutingPath.debug("TODO");

"tolvstämmigt.scd".resolveRelative.load;


Cell({
	~settings[\tempo] = 110;
	~load = {
		~settings[\duration] = 30.rrand(60);
	};

	~pattern = Pdef(\tolv);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)