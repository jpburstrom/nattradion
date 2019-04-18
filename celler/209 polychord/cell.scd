thisProcess.nowExecutingPath.debug("TODO");

"polychord.scd".resolveRelative.load;


Cell({
~settings[\reverb] = (
		time: 1.2,
		amp: 0.05
	);

	~settings[\tempo] = 173;
	~load = {
		~settings[\duration] = 40.rrand(80);
	};
	~pattern = Pdef(\poly);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
