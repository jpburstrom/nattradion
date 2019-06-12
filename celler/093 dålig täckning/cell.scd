
Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 3.0,
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
		 '093_dalig_tackning_loop': "093 dalig tackning/093 dalig tackning_loop.wav",
		 '093_dalig_tackning_inferno_loop': "093 dalig tackning/093 dalig tackning_inferno loop.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
