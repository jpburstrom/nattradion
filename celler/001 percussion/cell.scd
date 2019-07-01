
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.2,
				modFunc: { |friend|
				}
			),
			isBridge: (
				count: 1.0,
				modFunc: { |count|
					~init = {
						var mul =
						~template[\ctl] = (

							shift: `{
								var range = { (1).exprand(10000).neg }.dup(2);
								 LFNoise2.kr(10).range(*range)
							}
						);
						~template[\fx] = (
							shift: [\freqshift, [freq: { ~ctlBus.(\shift).asMap }]]
						);
						Fdef(\setRandomBufferDuration).value(20.0, 50).debug("hohohO");
						~settings[\setDurationFromFile] = false;

					};
					~load = {
						~markers[\end] = nil;
						~settings[\fadeIn] = 5;
					};
					~play = {
						~settings.postln;
					};11
				};
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'percussion': "001 percussion/percussion.wav"
	));

	//TODO: Add as bridge w/ freqShift

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
