
"rockring.scd".resolveRelative.load;

Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
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

	~settings[\reverb] = (
		time: 1.2,
		amp: 0.04
	);

	~settings[\numChannels] = 2;
	~settings[\tempo] = 95; // TODO dynamic tempo

	~load = {
		~settings[\duration] = 60.rrand(180);
	};

	~template[\main] = (
		ringmod: [\rockring_ringmod, [
			\tempo, { ~settings[\tempo] },
			\baseFreq, 220,
			\duration, { ~settings[\duration] }
		]]
	);

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
