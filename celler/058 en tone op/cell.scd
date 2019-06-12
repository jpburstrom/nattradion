
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.7,
				filter: "",
				modFunc: { |friend|
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'en_tone_op': "058 en tone op/en tone op.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
