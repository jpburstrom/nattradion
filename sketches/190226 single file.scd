(
g = Cell({

	//Single file, should also work with array of paths
	~files = "/tmp/click.wav";

	//Shouldn't need to change this
	~server = Server.default;

	// Snap offset = position in file equal to 1.0.0
	~snapOffset = 0;
	//Start frame = where to start playback
	~startFrame = 0;
	~sampleRate = 48000; //TODO get from file
	//TODO calculate after getting sampleRate
	//Maybe this should be in ms or s instead
	~timingOffset = (~snapOffset - ~startFrame) / ~sampleRate;

	//buffer counter
	~counter = 0;
	//temporary fadeout
	~fadetime = 0.01;

	//
	~beatsPerBar = 4;
	//
	~tempo = 120;

	~loop = true;

	//Clock
	~clock = TempoClock.default;

	//Duration (beats or seconds?)
	~duration = 8;

	~load = {
		// Convert to array of paths
		~files = [].add(~files);

		// This could probably be somewhere else
		SynthDef(\cellDiskIn_2, {
			var snd = DiskIn.ar(2, \bufnum.kr(0), \loop.kr(0));
			FreeSelf.kr(Done.kr(snd));
			snd = snd * Env.asr(0.002, 1, 0.002).ar(Done.freeSelf, \gate.kr(1));
			Out.ar(\out.kr(0), snd * \amp.kr(0.3));
		}).add;

		// Load buffers before play
		~buffers = ~files.collect { |path|
			Buffer.cueSoundFile(~server, path, ~startFrame, 2, 65536);
		};

		// Reset counter, just in case
		~counter = 0;
	};

	~play = {
		// This happens exactly at next bar
		// This would also be a part of a pattern player
		~clock.playNextBar({
			~clock.tempo = ~tempo / 60;
			~clock.beatsPerBar = ~beatsPerBar;
			// A sketch for something that schedules to happen on ~duration
			// after play start
			~timer = fork({
				~duration.wait;
				"Duration end".postln;
				(instrument:\click).play
			}.inEnvir);
		}.inEnvir);
		// This happens at next bar
		// minus timing offset calculated from cell snapOffset (see above)
		~clock.schedAbs(Quant(~clock.beatsPerBar, 0, ~timingOffset).nextTimeOnGrid(~clock), {
			// s.bind adds another `s.latency` amount of latency
			~server.bind {
				~synths = ~buffers.collect { |buf|
					var syn = Synth(\cellDiskIn_2, [\bufnum, buf, \loop, ~loop], ~group)
					.onFree({
						// When synth is freed, subtract one for each synth
						~counter = ~counter - 1;
						if (~counter == 0) {
							// Free everything when no synths are playing
							// TODO: free on cmd+period
							~freeAll.value;
						};
					}.inEnvir);
					// Add one for each synth
					~counter = ~counter + 1;
					// Return synth instance
					syn;
				}
			}
		}.inEnvir)
	};

	~stop = {
		~timer.stop;
		~synths.do { |x| x.release(~fadetime) };
	};

	~freeAll = {
		~buffers.free;
		~group.free;
	};

});
UnitTest
g.play
)
g.stop
Buffer.cachedBuffersDo(s, { |x, i| z = i }); z
Collapse
