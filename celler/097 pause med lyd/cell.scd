
Cell({

//tsv
	~init = {
		~updateSettings.((
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
        /*
		 'qarin_2.stemme': "097 pause med lyd/Qarin 2.stemme.wav",
		 'qarin_1.stemme': "097 pause med lyd/Qarin 1.stemme.wav",
		 '097_pause_med_lyd_q_choir': "097 pause med lyd/097 pause med lyd Q choir.wav",
         */
		 '097_pause_med_lyd': "097 pause med lyd/097 pause med lyd.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
