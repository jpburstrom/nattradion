//updateme <-- Remove this line when editing
thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'lång': "040 lång/lång.wav",
		 'lång_utan_rytmsektion': "040 lång/lång stems/lång utan rytmsektion.wav",
		 'lång_rytm': "040 lång/lång stems/lång rytm.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
