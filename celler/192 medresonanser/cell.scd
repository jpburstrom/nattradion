
Cell({

~settings[\reverb] = (
		time: 2,
		amp: 0.1
	);

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'medresonanser-20190208-1512': "192 medresonanser/medresonanser-20190208-1512.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
