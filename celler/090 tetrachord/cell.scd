
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 3.0,
				modFunc: { |count|
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

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'tetrachord': "090 tetrachord/Tetrachord.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
