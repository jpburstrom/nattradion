
Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'mellemsten_i_slowmotion': "094 mellemsten i slowmotion/STEMS/mellemsten i slowmotion.wav",
		 'mellemsten_i_slowmotion_arabiske_stemmer': "094 mellemsten i slowmotion/STEMS/mellemsten i slowmotion_arabiske stemmer.wav",
		 //'094_mellemosten_i_slowmotion': "094 mellemosten i slowmotion/094 mellemosten i slowmotion.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
