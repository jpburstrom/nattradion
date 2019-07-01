
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: (
					tags: #[ambience, noise],
				),
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'rytmebox_x2': "011 rytmebox x2/rytmebox x2.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)


