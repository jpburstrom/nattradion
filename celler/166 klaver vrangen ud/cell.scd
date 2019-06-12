
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		klaver: "166 klaver vrangen ud/Klaver vrangen ud.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
