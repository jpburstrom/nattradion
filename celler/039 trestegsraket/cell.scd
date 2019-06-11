
Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 //'039_trestegsraket_piano': "039 trestegsraket/039 trestegsraket piano.wav",
		 '039_trestegsraket': "039 trestegsraket/039 trestegsraket.wav",
		 //'039_trestegsraket_marimba': "039 trestegsraket/039 trestegsraket marimba.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
