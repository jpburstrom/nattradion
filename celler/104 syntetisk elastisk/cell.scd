
Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'syntetisk': "104 syntetisk elastisk/104 syntetisk elastisk.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);
