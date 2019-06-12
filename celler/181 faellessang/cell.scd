"sang.scd".resolveRelative.load;

Cell({

//tsv
	~init = {
		~updateSettings.((
			isFriend: (
				count: 1.0,
				modFunc: { |count|
				}
			),
			isBridge: (
				count: 1.0,
				modFunc: { |count|
				};
			),
			isOneshot: (
				count: 2.0,
				modFunc: { |count|
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~settings[\reverb] = (
		time: 4.5,
		amp: 0.4
	);


	~load = {
		~settings[\duration] = 80.rrand(140);
	};

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'sang_a2': "181 faellessang/samples/Sang A2.wav",
		 'sang_b': "181 faellessang/samples/Sang B.wav",
		 'sang_a': "181 faellessang/samples/Sang A.wav",
		 'sang_d#': "181 faellessang/samples/Sang D.wav",
		'sang_e': "181 faellessang/samples/Sang E.wav",
		 'sang_c#': "181 faellessang/samples/Sang C.wav",
		 'sang_g': "181 faellessang/samples/Sang G.wav"
	));

	~pattern = Pdef(\sang);

}, \bufferPattern).name_(PathName(thisProcess.nowExecutingPath).folderName);
