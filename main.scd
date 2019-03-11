~main = Cell({

	~loadCells = {
	};

	//Define routing template
	~template = (
		~group = #[main, send, out],
		~bus = (
		),
		~fx = (
		)
	);

	~cells = ~loadCells.value;
	~playlist = "playlist.scd".resolveRelative.load;

	// Do all playing on load instead
	~load = ~beforePlay;
	// And remove default play action
	~beforePlay = nil;

	~play {
		~playlist.play;
	};


}, \synth); //FIXME: Add blank/something player type