
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: "ambience, noise",
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
		 //'098_spelglädje_för_ostämd_gitarr_loop': "098 spelglädje för ostämd gitarr/098 spelglädje för ostämd gitarr_loop.wav",
		 '098_spelgladje_for_ostamd_gitarr': "098 spelgladje for ostamd gitarr/098 spelgladje for ostamd gitarr.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
