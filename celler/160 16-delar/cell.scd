
"16-delar.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.75,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 2.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
~settings[\reverb] = (
		time: 1.2,
		amp: 0.2
	);

	~settings[\tempo] = 110; //TODO dynamic
	~load = {
		~settings[\duration] = 80.rrand(120);
	};
	~pattern = Pdef(\s16);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
