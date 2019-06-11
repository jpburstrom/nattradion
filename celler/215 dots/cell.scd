
"dots.scd".resolveRelative.load;


Cell({
~settings[\reverb] = (
		time: 2,
		amp: 0.1
	);

	~settings[\tempo] = 75;
	~load = {
		~settings[\duration] = 60.rrand(140);
	};
	~pattern = Pdef(\dots);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
