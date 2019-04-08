thisProcess.nowExecutingPath.debug("TODO");

"inte en skala.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 60;
	~pattern = Pdef(\enSkala);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
