
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: "minimalistic, rythmic",
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
		 '073_midiflute_katrine': "073 midiflute/073_midiflute_katrine.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
