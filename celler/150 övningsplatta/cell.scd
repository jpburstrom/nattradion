thisProcess.nowExecutingPath.debug("TODO");

"övningsplatta.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 70;

	~pattern = Pdef(\padPlayer);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)

