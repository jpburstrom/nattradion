
"kvintcirkel.scd".resolveRelative.load;


Cell({

	~settings[\reverb] = (
		time: 2.8,
		amp: 0.125
	);

	~settings[\tempo] = 90;

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~pattern = Pdef(\kvint);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
