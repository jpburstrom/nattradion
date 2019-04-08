thisProcess.nowExecutingPath.debug("TODO");

"orgel.scd".resolveRelative.load;

Cell({

	~settings[\tempo] = 60;
	~pattern = Pdef(\orgel);

}, \pattern)
