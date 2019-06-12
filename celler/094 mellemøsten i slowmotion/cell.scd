
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				filter: "bpm 120 bpm 60 eller ambience, noise",
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
			transitions: [\fade, \xfade]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'mellemsten_i_slowmotion': "094 mellemsten i slowmotion/STEMS/mellemsten i slowmotion.wav",
		 'mellemsten_i_slowmotion_arabiske_stemmer': "094 mellemsten i slowmotion/STEMS/mellemsten i slowmotion_arabiske stemmer.wav",
		 //'094_mellemosten_i_slowmotion': "094 mellemosten i slowmotion/094 mellemosten i slowmotion.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
