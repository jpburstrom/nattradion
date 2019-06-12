
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

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'osammanhangande_harmonik': "038 osammanhangande harmonik/osammanhangande harmonik.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
