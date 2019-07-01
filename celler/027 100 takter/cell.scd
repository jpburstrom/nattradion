
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.7,
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		//Install custom friendFilter. 75% chance of being #187
		if (0.75.coin) {
			~friendFilter = { |cell|
				cell.metadata[\number] == 187;
			};
		} {
			~friendFilter = true;
		};
	};
	~settings[\setDurationFromFile] = false;
	~template[\buffer] = (
		file:  Fdef(\randomDurationTemplate).value("027 100 takter/100 takter.wav", 120);
	);

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
