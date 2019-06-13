var path = "allt.scd".resolveRelative;
Cell({

	path.load;


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
		~loadAllBuffers.value;
	};

	~afterLoad = nil;

	~freeAll = {
		"freeall".postln;
		~buffers.do(_.free);
		~groups.do(_.free).postln;
	};

	~pattern = Pdef(\allt);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
