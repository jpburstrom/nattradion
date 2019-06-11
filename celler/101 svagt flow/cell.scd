
Cell({

    //TODO choose
	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 '101_svagt_flow_variation_1': "101 svagt flow/101 svagt flow variation 1.wav",
		 '101_svagt_flow_variation_2': "101 svagt flow/101 svagt flow variation 2.wav",
         */
		 '101_svagt_flow': "101 svagt flow/101 svagt flow.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
