thisProcess.nowExecutingPath.debug("TODO");

"polychord.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 173;
	~pattern = Pdef(\poly);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
