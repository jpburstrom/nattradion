
"kvintcirkel.scd".resolveRelative.load;


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
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~settings[\reverb] = (
		time: 2.8,
		amp: 0.125
	);

	~settings[\tempo] = 90;

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~pattern = Pdef(\kvint);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
