
Cell({

	~settings[\disabled] = true;

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'd_eb_bb_x_x': "143 D Eb Bb X X/D Eb Bb X X.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
