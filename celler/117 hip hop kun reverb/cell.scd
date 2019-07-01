
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
		 '117_hip_hop_kun_reverb': "117 hip hop kun reverb/117 hip hop kun reverb.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
