
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '109_mellanrum': "109 mellanrum/109 mellanrum.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
