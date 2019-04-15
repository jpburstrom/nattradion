thisProcess.nowExecutingPath.debug("TODO");
"sang.scd".resolveRelative.load;


Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'sang_a2': "181 faellessang/samples/Sang A2.wav",
		 'sang_b': "181 faellessang/samples/Sang B.wav",
		 'sang_a': "181 faellessang/samples/Sang A.wav",
		 'sang_d#': "181 faellessang/samples/Sang D#.wav",

		'sang_e': "181 faellessang/samples/Sang E.wav",
		 'sang_c#': "181 faellessang/samples/Sang C#.wav",
		 'sang_g': "181 faellessang/samples/Sang G.wav"
	));

	~pattern = Pdef(\sang);

}, \buffer, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
