


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: "",
				modFunc: { |friend|
				}
			),
			isBridge: (
				count: 2.0,
				modFunc: { |count|
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
	~settings[\reverb] = (
		time: 3,
		amp: 0.1
	);

	~template[\buffer] = Fdef(\resolveAssets).value((
		romantik: "214 Romantik repetition/Romantik repetition.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
