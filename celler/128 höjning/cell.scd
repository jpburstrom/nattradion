
Cell({

//tsv
	~init = {
		~updateSettings.((
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
		 '128_hojning': "128 hojning/128 hojning.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
