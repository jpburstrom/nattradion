
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		bas: "151 brus med bas/Brus med bas.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)


