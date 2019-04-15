thisProcess.nowExecutingPath.debug("TODO");

"spektral kanon.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 90;

	~pattern = Pdef(\canon);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
