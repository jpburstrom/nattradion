Cell({

	var files = Fdef(\resolveAssets).value((
		'003_vokal_kat_mix_2': "003 vokal/003 vokal_KAT mix 2.wav",
		//'003_vokal_kat_mix': "003 vokal/003 vokal_KAT mix.wav"
	));
//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade],
		));
	};
//end tsv

	~load = {

	};
	~template[\buffer] = (
		file:  Fdef(\randomDurationTemplate).value(files.choose, 60);
	)




}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)