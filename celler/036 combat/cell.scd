//updateme <-- Remove this line when editing

Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'combat': "036 combat/combat.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
