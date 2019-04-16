thisProcess.nowExecutingPath.debug("TODO");

"polychord.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 173;
	~load = {
		~settings[\duration] = 40.rrand(80);
	};
	~pattern = Pdef(\poly);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
