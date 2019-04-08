thisProcess.nowExecutingPath.debug("TODO");

"16-delar.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 100; //TODO dynamic
	~pattern = Pdef(\s16);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
