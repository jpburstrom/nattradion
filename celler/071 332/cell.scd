
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.75,
				filter: "atonal, ambience, noise",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '332': "071 332/332.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
