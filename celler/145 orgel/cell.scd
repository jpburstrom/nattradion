
"orgel.scd".resolveRelative.load;

Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
				filter: "+ #121",
				modFunc: { |friend|
				}
			),
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
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
		time: 4,
		amp: 1
	);
	~settings[\tempo] = 60;
	~load = {
		//TODO: This cuts off pmono
		~settings[\duration] = 10;
		currentEnvironment.set("level.main.amp", 6.dbamp)
	};
	~pattern = Pdef(\orgel);

}, \pattern)
