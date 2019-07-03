
Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 1.0,
				modFunc: { |count|
					~template[\buffer] = Fdef(\resolveAssets).value((
						'badboll_snabb': "051 badboll 1 snabb/STEMS/badboll snabb sax.wav"
					));
				}
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
	//end tsv

	//TODO: use sax 20% of the time
	~template[\buffer] =
	Fdef(\resolveAssets).value((
		'badboll_snabb': "051 badboll 1 snabb/badboll snabb.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
