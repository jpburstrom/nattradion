
Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 'omstart_drums': "060 omstart/omstart stems/omstart drums.wav",
		 'omstart_keys': "060 omstart/omstart stems/omstart keys.wav",
		 'omstart_bas': "060 omstart/omstart stems/omstart bas.wav",
         */
		 'omstart': "060 omstart/omstart.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
