
"spektral kanon.scd".resolveRelative.load;


Cell({

	~settings[\reverb] = (
		time: 1,
		amp: 0.2
	);

	~settings[\tempo] = 90;

	~load = {
		//TODO: This cuts off pmono
		~settings[\duration] = 70.rrand(140);
		//currentEnvironment.set("level.main.amp", 6.dbamp)
	};
	~pattern = Pdef(\canon);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
