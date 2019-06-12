
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'melodi_fran_talad_text': "138 melodi fran talad text/Melodi fran talad text.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
