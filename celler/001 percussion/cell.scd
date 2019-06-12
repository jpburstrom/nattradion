
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
		 'percussion': "001 percussion/percussion.wav"
	));

	//TODO: Add as bridge w/ freqShift

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);

