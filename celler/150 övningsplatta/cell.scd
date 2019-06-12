
"ovningsplatta.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
				filter: "",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

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

