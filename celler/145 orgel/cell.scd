thisProcess.nowExecutingPath.debug("TODO");

"orgel.scd".resolveRelative.load;

Cell({

	~settings[\tempo] = 60;
	~load = {
		//TODO: This cuts off pmono
		~settings[\duration] = 70.rrand(140);
		//currentEnvironment.set("level.main.amp", 6.dbamp)
	};
	~pattern = Pdef(\orgel);

}, \pattern)

