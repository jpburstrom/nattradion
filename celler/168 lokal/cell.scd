
Cell({

//tsv
	~init = {
		~updateSettings.((
			hasFriend: (
				prob: 1.0,
				filter: "Spela det som spelades för 10 minuter sedan svagt i bakgrund",
				modFunc: { |friend|
				}
			),
			isFriend: (
				count: 2.0,
				modFunc: { |count|
				}
			),
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

	~template[\buffer] = Fdef(\resolveAssets).value((
		lokal: "168 lokal/Lokal-20190208-1227.wav"
	));



}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName);
// .set("level.main.amp", 1.5)
