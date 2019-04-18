thisProcess.nowExecutingPath.debug("TODO");

"orgel.scd".resolveRelative.load;

Cell({
	~settings[\reverb] = (
		time: 4,
		amp: 1
	);
	~settings[\tempo] = 60;
	~load = {
		//TODO: This cuts off pmono
		~settings[\duration] = 10;
		currentEnvironment.set("level.main.amp", 6.dbamp)
	};
	~pattern = Pdef(\orgel);

}, \pattern)
