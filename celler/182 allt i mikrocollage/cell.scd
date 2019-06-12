
Cell({

//tsv
	~init = {
		~updateSettings.((
			isBridge: (
				count: 2.0,
				modFunc: { |count|
				};
			),
			isOneshot: (
				count: 2.0,
				modFunc: { |count|
				};
			),
			transitions: [\cut, \bridge, \oneshot]
		));
	};
//end tsv


	~load = {
		~settings[\duration] = 25.rrand(120);
		"allt.scd".resolveRelative.load;
	};

	~freeAll = {
		~buffers.do(_.free);
	};

	~pattern = Pdef(\allt);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
