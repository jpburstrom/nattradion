
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: (
					tags: #[ambience, noise],
				),
				modFunc: { |friend|
				}
			),
			isOneshot: (
				count: 3.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'liters_ters_kvint': "056 kvint liten ters oktav/liters ters kvint.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
