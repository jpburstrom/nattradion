
Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '130_matematik': "130 matematik/130 matematik.wav",
		 //'130_matematik_drums': "130 matematik/STEMS og MIDI/130 matematik_drums.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
