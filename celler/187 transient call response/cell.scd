thisProcess.nowExecutingPath.debug("TODO");

"transient.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 70;

	~load = {
		~settings[\duration] = 40.rrand(120);
	};
	~pattern = Pdef(\transient);


}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
