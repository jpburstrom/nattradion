
Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 15.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value(( 
        1: "099 valsang vals va/Clips/099 valsang vals va 1.wav", 
        10: "099 valsang vals va/Clips/099 valsang vals va 10.wav" ,
        11: "099 valsang vals va/Clips/099 valsang vals va 11.wav" ,
        13: "099 valsang vals va/Clips/099 valsang vals va 13.wav",
        5: "099 valsang vals va/Clips/099 valsang vals va 5.wav" ,
        0: "099 valsang vals va/099 valsang vals va.wav" ,
        7: "099 valsang vals va/Clips/099 valsang vals va 7.wav" ,
        3: "099 valsang vals va/Clips/099 valsang vals va 3.wav" ,
        2: "099 valsang vals va/Clips/099 valsang vals va 2.wav",
        8: "099 valsang vals va/Clips/099 valsang vals va 8.wav" ,
        9: "099 valsang vals va/Clips/099 valsang vals va 9.wav" ,
        15: "099 valsang vals va/Clips/099 valsang vals va 15.wav" ,
        4: "099 valsang vals va/Clips/099 valsang vals va 4.wav" ,
        14: "099 valsang vals va/Clips/099 valsang vals va 14.wav",
        6: "099 valsang vals va/Clips/099 valsang vals va 6.wav" ,
        12: "099 valsang vals va/Clips/099 valsang vals va 12.wav" 
    ));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);
