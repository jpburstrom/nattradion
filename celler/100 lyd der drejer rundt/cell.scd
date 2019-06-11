
Cell({

    //TODO CHOose
	~template[\buffer] = Fdef(\resolveAssets).value((
		 //'100_lyd_der_drejer_rundt_oktav_ned': "100 lyd der drejer rundt/100 lyd der drejer rundt_oktav ned.wav",
		 '100_lyd_der_drejer_rundt': "100 lyd der drejer rundt/100 lyd der drejer rundt.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
