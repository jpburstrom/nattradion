
Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'percussion': "001 percussion/percussion.wav"
	));

	//TODO: Add as bridge w/ freqShift

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);

