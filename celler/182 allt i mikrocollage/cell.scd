
Cell({


	~load = {
		~settings[\duration] = 25.rrand(120);
		"allt.scd".resolveRelative.load;
	};

	~freeAll = {
		~buffers.do(_.free);
	};

	~pattern = Pdef(\allt);

}, \pattern).name_(PathName(thisProcess.nowExecutingPath).folderName)
.play