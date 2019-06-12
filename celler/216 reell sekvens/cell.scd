"reell sekvens.scd".loadRelative;

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

	~settings[\quant] = 1;
	~settings[\tempo] = 92;
	~settings[\reverb] = (
		time: 0.8,
		amp: 0.4
	);
	~pattern = Pdef(\reellsekvens);

	~load = {
		~settings[\duration] = 10;
		currentEnvironment.set("level.main.amp", 6.dbamp)
	};

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)

/*EOF*/

