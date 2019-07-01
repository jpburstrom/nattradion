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

	~template[\buffer] = (
		'combat':  Fdef(\randomDurationTemplate).value("036 combat/combat.wav", 105)
	);


}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
