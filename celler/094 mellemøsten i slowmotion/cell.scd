
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				filter: (
					tags: #[ambience, noise],
					tempo: [60, 120]
				),
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
		 'mellemsten_i_slowmotion': "094 mellemsten i slowmotion/mellemsten i slowmotion.wav",
		// Use this one ^
		 //'mellemsten_i_slowmotion_arabiske_stemmer': "094 mellemsten i slowmotion/STEMS/mellemsten i slowmotion_arabiske stemmer.wav",
		 //'094_mellemosten_i_slowmotion': "094 mellemosten i slowmotion/094 mellemosten i slowmotion.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
