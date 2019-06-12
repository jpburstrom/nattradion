
"dots.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.25,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 2.0,
				modFunc: { |count|
				}
			),
			isOneshot: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv
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
