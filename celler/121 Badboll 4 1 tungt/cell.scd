
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				filter: "Nummer #145",
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

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'badboll': "121 Badboll 4 1 tungt/121 badboll 41 tungt.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
