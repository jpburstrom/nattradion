
"tolvstammigt.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.75,
				//filter: "fiol #100, ambience, noise",
				filter: (
					number: 100,
					tags: #[ambience, noise]
				),
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
	~settings[\tempo] = 110;
	~load = {
		~settings[\duration] = 30.rrand(60);
	};

	~settings[\reverb] = (
		time: 4,
		amp: 0.05
	);


	~pattern = Pdef(\tolv);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
