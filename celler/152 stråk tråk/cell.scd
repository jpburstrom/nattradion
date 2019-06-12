
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
			isFriend: (
				count: 1.0,
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
~settings[\reverb] = (
		time: 0.1,
		amp: 0.6
	);

	~template[\buffer] = Fdef(\resolveAssets).value((
		  strak: "152 strak trak/Strak trak-20190208-1245.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
