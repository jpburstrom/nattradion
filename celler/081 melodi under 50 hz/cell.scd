
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
				count: 5.0,
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
		 'melodi_under_50_hz_cats_only': "081 melodi under 50 hz/melodi under 50 hz_cats only.wav",
		 '081_melodi_under_50_hz_katrine': "081 melodi under 50 hz/081_melodi under 50 hz_katrine.wav",
		 '081_melodi_under_50_hz': "081 melodi under 50 hz/081_melodi under 50 hz.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
