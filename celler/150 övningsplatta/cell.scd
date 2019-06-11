
"ovningsplatta.scd".resolveRelative.load;


Cell({

	~settings[\reverb] = (
		time: 0.05,
		amp: 0.3
	);


	~settings[\tempo] = 70;
	~load = {
		~settings[\duration] = 40.rrand(80);
	};
	~pattern = Pdef(\padPlayer);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)

