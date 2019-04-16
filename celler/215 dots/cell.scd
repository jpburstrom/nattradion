thisProcess.nowExecutingPath.debug("TODO");

"dots.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 75;
	~load = {
		~settings[\duration] = 60.rrand(140);
	};
	~pattern = Pdef(\dots);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
