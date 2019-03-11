


~data = (
	//Tempo, run from its own clock
	tempo: 140,
	//Various times of cell
	times: (
		//Total duration of cell
		duration: {
			[
				//A random value
				50.rrand(120),
				//A fixed value
				60,
				//dependant on soundfile
				~soundFile.duration,
			].choose
		},
		//intro duration
		//useful for fades etc
		head: { |ev
			//ev.duration * 0.1
			10
		},
		//outro duration
		//useful for fades
		tail: {
			0
		}
	),

	//different markers useful for splitting up etc
	markers: (
		phrases: [0, 10, 22, 34]
	)
);
