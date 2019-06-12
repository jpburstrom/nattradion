
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '078_lindha': "078 lindha/078 lindha.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
