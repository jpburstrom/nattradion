
"polychord.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: "",
				modFunc: { |friend|
				}
			),
			isOneshot: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
~settings[\reverb] = (
		time: 1.2,
		amp: 0.05
	);

	~settings[\tempo] = 173;
	~load = {
		~settings[\duration] = 40.rrand(80);
	};
	~pattern = Pdef(\poly);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
