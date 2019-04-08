thisProcess.nowExecutingPath.debug("TODO");

"kvintcirkel.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 90;


	~pattern = Pdef(\kvint);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
