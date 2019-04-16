thisProcess.nowExecutingPath.debug("TODO");

"övningsplatta.scd".resolveRelative.load;


Cell({

	~settings[\tempo] = 70;
	~load = {
		~settings[\duration] = 40.rrand(80);
	};
	~pattern = Pdef(\padPlayer);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)

