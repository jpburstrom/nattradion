thisProcess.nowExecutingPath.debug("TODO");

"kvintcirkel.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 90;

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~pattern = Pdef(\kvint);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
