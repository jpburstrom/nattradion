
Cell({

//tsv
	~init = {
		~updateSettings.((
			isOneshot: (
				count: 14.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 '107_frontalkrock_10': "107 frontalkrock/Clips/107 frontalkrock 10.wav",
		 '107_frontalkrock_7': "107 frontalkrock/Clips/107 frontalkrock 7.wav",
		 '107_frontalkrock_2': "107 frontalkrock/Clips/107 frontalkrock 2.wav",
		 '107_frontalkrock_5': "107 frontalkrock/Clips/107 frontalkrock 5.wav",
		 
  '107_frontalkrock_3': "107 frontalkrock/Clips/107 frontalkrock 3.wav",
		 '107_frontalkrock_11': "107 frontalkrock/Clips/107 frontalkrock 11.wav",
		 '107_frontalkrock_4': "107 frontalkrock/Clips/107 frontalkrock 4.wav",
		 '107_frontalkrock_9': "107 frontalkrock/Clips/107 frontalkrock 9.wav",
		 '107_frontalkrock_14': "107 frontalkrock/Clips/107 frontalkrock 14.wav",
		 
  '107_frontalkrock_13': "107 frontalkrock/Clips/107 frontalkrock 13.wav",
		 '107_frontalkrock_1': "107 frontalkrock/Clips/107 frontalkrock 1.wav",
		 '107_frontalkrock_6': "107 frontalkrock/Clips/107 frontalkrock 6.wav",
		 '107_frontalkrock_12': "107 frontalkrock/Clips/107 frontalkrock 12.wav",
		 
  '107_frontalkrock_8': "107 frontalkrock/Clips/107 frontalkrock 8.wav" 
  */
		 '107_frontalkrock': "107 frontalkrock/107 frontalkrock.wav",
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
