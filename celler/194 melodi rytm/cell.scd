
"melodi-rytm.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.6,
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
		time: 0.2,
		amp: 1
	);

	~settings[\tempo] = 60;
	~load = {
		~settings[\duration] = 20.rrand(40);
	};
	~pattern = Pdef(\blippo);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
