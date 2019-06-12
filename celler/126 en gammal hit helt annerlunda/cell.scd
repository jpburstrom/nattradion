
Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 '126_en_gammal_hit_helt_annerlunda': "126 en gammal hit helt annerlunda/126 en gammal hit helt annerlunda.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
