
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = (
		'osammanhangande_harmonik':  Fdef(\randomDurationTemplate).value("038 osammanhangande harmonik/osammanhangande harmonik.wav", 180)
	);
	~settings[\setDurationFromFile] = false;

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
