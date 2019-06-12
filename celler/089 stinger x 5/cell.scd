
Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			isOneshot: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '089_stinger_x_5': "089 stinger x 5/089 stinger x 5.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
