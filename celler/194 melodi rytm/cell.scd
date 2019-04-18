thisProcess.nowExecutingPath.debug("TODO");

"melodi-rytm.scd".resolveRelative.load;


Cell({

	~settings[\reverb] = (
		time: 0.2,
		amp: 1
	);

	~settings[\tempo] = 60;
	~load = {
		~settings[\duration] = 20.rrand(40);
	};
	~pattern = Pdef(\blippo);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
