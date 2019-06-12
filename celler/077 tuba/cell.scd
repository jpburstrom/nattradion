
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '077_tuba': "077 tuba/077 tuba.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
