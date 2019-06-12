
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.7,
				filter: "75% #187",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '100_takter': "027 100 takter/100 takter.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
