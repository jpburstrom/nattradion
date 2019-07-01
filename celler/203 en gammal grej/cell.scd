
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.25,
				filter: (
					tags: #[ambience, noise],
				),
				modFunc: { |friend|
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
		  alfredo: "203 en gammal grej/203 en gammal grej-20190408-1432.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
