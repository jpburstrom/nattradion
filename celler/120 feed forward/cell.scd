
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 2.0,
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

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '120_feed_forward': "120 feed forward/120 feed forward.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
