
"inte en skala.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.25,
				filter: "melodic, rubato",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
~settings[\reverb] = (
		time: 2,
		amp: 0.1
	);

	~settings[\tempo] = 60;
	~load = {
		~settings[\duration] = 90.rrand(180);
	};
	~pattern = Pdef(\enSkala);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
