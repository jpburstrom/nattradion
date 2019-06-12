
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'sma_intervall': "026 sma intervall 170 bpm/sma intervall.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
