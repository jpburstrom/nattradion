
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: (
					tags: #[minimalistic, rhythmic],
				),
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
		 '074_fm': "074 fm/074 fm.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
