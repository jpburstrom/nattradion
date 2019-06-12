
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.3,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
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
		 'kort_loop_full': "072 kort loop 3 sek/kort loop FULL.wav",
         /*
		 'kort_loop_endast_perc': "072 kort loop 3 sek/kort loop endast perc.wav",
		 'kort_loop_minus_perc': "072 kort loop 3 sek/kort loop minus perc.wav" 
         */
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
