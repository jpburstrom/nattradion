thisProcess.nowExecutingPath.debug("TODO");

"melodi-rytm.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 60;

	~pattern = Pdef(\blippo);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
