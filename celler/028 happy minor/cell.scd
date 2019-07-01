
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
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'happy_minor': "028 happy minor/happy minor.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
