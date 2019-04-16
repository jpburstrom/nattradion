thisProcess.nowExecutingPath.debug("TODO");

"dteht.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 120;
	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~pattern = Pdef(\dteht);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
