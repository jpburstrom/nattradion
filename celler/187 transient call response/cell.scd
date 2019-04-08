thisProcess.nowExecutingPath.debug("TODO");

"transient.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 70;

	~pattern = Pdef(\transient);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
