
Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'trumsolo_endast_trummor': "006 trumsolo/trumsolo stems/Trumsolo endast trummor.wav",
		 'trumsolo_kompband': "006 trumsolo/trumsolo stems/Trumsolo kompband.wav"
	));


}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)

