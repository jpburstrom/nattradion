
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.7,
				filter: "",
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		Fdef(\ifHasFriend).value({
			Fdef(\replaceBuffer).value(
				'en_tone_op', "058 en tone op/STEMS/en tone op piano.wav"
			);
		})
	};

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'en_tone_op': "058 en tone op/en tone op.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
