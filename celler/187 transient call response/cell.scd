
"transient.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
				filter: "#027",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~settings[\tempo] = 70;

	~load = {
		~settings[\duration] = 40.rrand(120);
	};
	~pattern = Pdef(\transient);


}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
