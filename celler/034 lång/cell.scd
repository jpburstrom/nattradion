
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.5,
				filter: (
					tags: #[ambience, noise],
					//Metronom
					number: 149
				),
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
	~settings[\setDurationFromFile] = false;


}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
