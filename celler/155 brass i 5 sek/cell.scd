
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.6,
				filter: "mås från #091",
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
		brass: "155 brass i 5 sek/brass.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
