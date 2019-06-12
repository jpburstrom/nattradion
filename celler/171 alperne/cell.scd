
"alps.scd".resolveRelative.load;

Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.1,
				filter: "",
				modFunc: { |friend|
				}
			),
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		~settings[\duration] = 60.rrand(130);
	};
	~settings[\reverb] = (
		time: 4,
		amp: 0.2
	);


	~template[\main] = (
		main: [\alps, \duration, { ~settings[\duration] }]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)




