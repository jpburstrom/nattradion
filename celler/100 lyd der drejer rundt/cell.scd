
Cell({

//tsv
	~init = {
		~updateSettings.((
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
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

    //TODO CHOose
	~template[\buffer] = Fdef(\resolveAssets).value((
		 //'100_lyd_der_drejer_rundt_oktav_ned': "100 lyd der drejer rundt/100 lyd der drejer rundt_oktav ned.wav",
		 '100_lyd_der_drejer_rundt': "100 lyd der drejer rundt/100 lyd der drejer rundt.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
