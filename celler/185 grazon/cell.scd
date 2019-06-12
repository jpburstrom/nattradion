
"grazon.scd".resolveRelative.load;


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
				count: 1.0,
				modFunc: { |count|
				}
			),
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~template[\main] = (
		//TODO: tempo
		main: [\grazon,
			[\duration, { ~settings[\duration] }];
		]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)
