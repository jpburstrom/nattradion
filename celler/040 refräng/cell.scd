
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.75,
				filter: "",
				modFunc: { |friend|
				}
			),
			isOneshot: (
				count: 2.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 '040_refräng_percussion': "040 refräng/refräng stems/040 refräng percussion.wav",
		 '040_refräng_fiddle': "040 refräng/refräng stems/040 refräng fiddle.wav",
		 '040_refräng_break_fills': "040 refräng/refräng stems/040 refräng break fills.wav" 
         */
		 '040_refrang': "040 refrang/040 refrang.wav",
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
