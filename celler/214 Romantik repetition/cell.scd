


Cell({
	~settings[\reverb] = (
		time: 3,
		amp: 0.1
	);

	~template[\buffer] = Fdef(\resolveAssets).value((
		romantik: "214 Romantik repetition/Romantik repetition.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
