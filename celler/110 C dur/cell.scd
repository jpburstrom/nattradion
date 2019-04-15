thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '110_c_dur_casio_trumpet_stemme': "110 C dur/STEMS/110 C dur Casio trumpet stemme.wav",
		 '110_c_dur_tuba': "110 C dur/STEMS/110 C dur Tuba.wav",
		 '110_c_dur_a-littleplate': "110 C dur/STEMS/110 C dur A-LittlePlate.wav",
		 '110_c_dur_casio_trumpet_mel.': "110 C dur/STEMS/110 C dur Casio trumpet mel..wav",
		 
  '110_c_dur_synth_tuba': "110 C dur/STEMS/110 C dur Synth tuba.wav",
		 //'110_c_dur': "110 C dur/110 C dur.wav",
		 '110_c_dur_synth_trumpet_mel.': "110 C dur/STEMS/110 C dur Synth trumpet mel..wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
