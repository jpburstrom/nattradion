
"sinus-koral.scd".resolveRelative.load;


Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.3,
				filter: "",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv
~settings[\reverb] = (
		time: 3.5,
		amp: 0.2
	);

	~load = {
		~settings[\duration] = 60.rrand(120);
	};
	~template[\main] = (
		main: [\sinus_koral, [\duration, { ~settings[\duration] }]]
	);

}, \synth).name_(PathName(thisProcess.nowExecutingPath).folderName)


