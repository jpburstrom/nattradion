
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 //'orgelpunkt_no_b-d': "067 orgelpunkt/orgelpunkt no b-d.wav",
		 'orgelpunkt': "067 orgelpunkt/orgelpunkt.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
