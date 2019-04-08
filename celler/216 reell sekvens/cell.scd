"reell sekvens.scd".loadRelative;

Cell({

	~settings[\quant] = 1;
	~settings[\tempo] = 92;
	~pattern = Pdef(\reellsekvens);

	~load = {
		currentEnvironment.set("level.main.amp", 6.dbamp)
	};

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)

/*EOF*/
