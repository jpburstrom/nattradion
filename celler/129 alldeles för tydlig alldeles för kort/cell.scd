
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
		 'alldeles': "129 alldeles for tydlig alldeles for kort/129 alldeles for tydlig alldeles for kort.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);
