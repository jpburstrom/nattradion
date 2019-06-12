
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: "atonal, ambience, noise",
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
		 '091_musik_for_et_2_toner_g_og_et_andet_g': "091 musik for 2 toner et G og et andet G/091 Musik for et 2 toner G og et andet G.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
