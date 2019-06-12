
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: "ambience, noise, metronom",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'lang': "034 lang/lang.wav",
         /*
		 'lång_utan_rytmsektion': "034 lång/lång stems/lång utan rytmsektion.wav",
		 'lång_rytm': "034 lång/lång stems/lång rytm.wav"
         */
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
