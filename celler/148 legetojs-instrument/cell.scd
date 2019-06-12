
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
				count: 3.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		instrument: "148 legetojs-instrument/Legetojs-instrument.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)

