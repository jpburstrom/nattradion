
Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 4.0,
				modFunc: { |count|
				}
			),
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
		 '108_ugens_dyrelyd': "108 ugens dyrelyd/108 ugens dyrelyd.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);

