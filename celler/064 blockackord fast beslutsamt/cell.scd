thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'blockackord_fast_beslutsamt_endast_bas': "064 blockackord fast beslutsamt/blockackord fast beslutsamt ENDAST BAS.wav",
		 'blockackord_fast_beslutsamt_full': "064 blockackord fast beslutsamt/blockackord fast beslutsamt FULL.wav",
		 'blockackord_fast_beslutsamt_minus_bas': "064 blockackord fast beslutsamt/blockackord fast beslutsamt MINUS BAS.wav"
	));

	~load = {
		currentEnvironment.set("level.main.amp", -9.dbamp);
	};

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)

