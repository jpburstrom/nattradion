
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: "",
				modFunc: { |friend|
				}
			),
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
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '079_hjemmebyggede_instrument_lyd': "079 hjemmebyggede instrumenter lyd/079 hjemmebyggede instrument lyd.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
