
//TODO stems

Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 0.8,
				filter: "",
				modFunc: { |friend|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = (
		'fur_elise':  Fdef(\randomDurationTemplate).value("062 fur elise baklanges/fur elise.wav", 60)
	);
	~settings[\setDurationFromFile] = false;

	~load = {
		Fdef(\ifHasFriend).value({
			var path = [
				"062 fur elise baklanges/stems/fur elise bas.wav",
				"062 fur elise baklanges/stems/fur elise drum.wav"
			].choose;
			Fdef(\replaceBuffer).value(
				'fur_elise', path
			);
		})
	};

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
