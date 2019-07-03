
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.35,
				filter: "",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 1.0,
				modFunc: { |count|
					~template[\buffer] = Fdef(\resolveAssets).value((
						'svarta_tangenter-vita_tangenter_melody': "032 svarta tangenter vita tangenter/svarta tangenter stems/svarta tangenter-vita tangenter melody.wav"
					));
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~load = {
		Fdef(\ifHasFriend).value({
			Fdef(\replaceBuffer).value(
				'svarta_tangenter-vita_tangenter',
				"032 svarta tangenter vita tangenter/svarta tangenter stems/svarta tangenter-vita tangenter bas.wav"
			);
		})
	};

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 'svarta_tangenter-vita_tangenter_trummor': "032 svarta tangenter vita tangenter/svarta tangenter stems/svarta tangenter-vita tangenter trummor.wav",
		 'svarta_tangenter-vita_tangenter_melody': "032 svarta tangenter vita tangenter/svarta tangenter stems/svarta tangenter-vita tangenter melody.wav",
		 'svarta_tangenter-vita_tangenter_bas': "032 svarta tangenter vita tangenter/svarta tangenter stems/svarta tangenter-vita tangenter bas.wav"
         */
		 'svarta_tangenter-vita_tangenter': "032 svarta tangenter vita tangenter/svarta tangenter-vita tangenter.wav",
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
