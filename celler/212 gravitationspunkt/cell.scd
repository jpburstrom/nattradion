
"gravitationspunkt.scd".resolveRelative.load;


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
		time: 8,
		amp: 0.05
	);

	~settings[\tempo] = 120;
	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~pattern = Pdef(\gravity);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
