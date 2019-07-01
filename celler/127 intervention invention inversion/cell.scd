
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				filter: (
					number: 190
				),
				modFunc: { |friend|
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '127_intervention_invention_inversion': "127 intervention invention inversion/127 intervention invention inversion.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
