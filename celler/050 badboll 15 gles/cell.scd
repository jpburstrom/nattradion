
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'badboll_gles': "050 badboll 15 gles/badboll gles.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
