
Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'badboll_snabb': "051 badboll 1 snabb/badboll snabb.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
