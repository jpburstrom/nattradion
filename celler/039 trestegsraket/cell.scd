Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: (
					tags: #[ambience, noise],
				),
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
					~template[\buffer] = Fdef(\resolveAssets).value((
						'039_trestegsraket_marimba': "039 trestegsraket/039 trestegsraket marimba.wav"
	));
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		Fdef(\ifHasFriend).value({
			Fdef(\replaceBuffer).value(
				'039_trestegsraket',
				"039 trestegsraket/039 trestegsraket piano.wav"
			);
		})
	};

	~template[\buffer] = Fdef(\resolveAssets).value((
		 //'039_trestegsraket_piano': "039 trestegsraket/039 trestegsraket piano.wav",
		 '039_trestegsraket': "039 trestegsraket/039 trestegsraket.wav",
		 //'039_trestegsraket_marimba': "039 trestegsraket/039 trestegsraket marimba.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
