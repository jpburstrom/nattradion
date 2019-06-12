
Cell({

//tsv
	~init = {
		~updateSettings.((
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
		 'andetag': "080 cittra andetag/080 cittra andetag_andetag.wav",
		 'cittra_andetag': "080 cittra andetag/080 cittra andetag.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
