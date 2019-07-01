
"dteht.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.3,
				filter: (number:127),
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
~settings[\reverb] = (
		time: 4.8,
		amp: 0.1
	);

	~settings[\tempo] = 120;
	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~pattern = Pdef(\dteht);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
