
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

	~template[\buffer] = (
		'lang':  Fdef(\randomDurationTemplate).value("034 lang/lang.wav", 300)
	);


}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
