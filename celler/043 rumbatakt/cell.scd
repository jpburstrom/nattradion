Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~settings[\disabled] = true;

	~template[\buffer] = Fdef(\resolveAssets).value((

	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
