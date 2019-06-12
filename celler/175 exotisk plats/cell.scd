
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.3,
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

	~template[\buffer] = Fdef(\resolveAssets).value((
		sound: "175 exotisk plats/Exotisk plats oljud-20190207-1629.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
