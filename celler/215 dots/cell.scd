thisProcess.nowExecutingPath.debug("TODO");

"dots.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 75;
	~pattern = Pdef(\dots);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
