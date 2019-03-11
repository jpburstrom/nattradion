(
z = Cue({

	~stemFiles = "/tmp/STEMS/*.wav".pathMatch;

	~server = Server.default;
	//Snap offset = position in file equal to 1.0.0
	~snapOffset = 103748;
	//Start frame = where to start playback
	~startFrame = 97297;
	~sampleRate = 48000; //TODO get from file
	//TODO calculate after getting sampleRate
	~timingOffset = (~snapOffset - ~startFrame) / ~sampleRate;

	//buffer counter
	~counter = 0;
	//temporary fadeout
	~fadetime = 0.01;

	//
	~beatsPerBar = 4;
	//
	~tempo = 111;

	~loop = true;

	//Clock
	~clock = TempoClock.default;

	//Duration (beats or seconds?)
	~duration = 6;

	~load = {
		SynthDef(\cellDiskIn_2, {
			var snd = DiskIn.ar(2, \bufnum.kr(0), \loop.kr(0));
			FreeSelf.kr(Done.kr(snd));
			snd = snd * Env.asr(0.002, 1, 0.002).ar(Done.freeSelf, \gate.kr(1));
			Out.ar(\out.kr(0), snd * \amp.kr(0.3));
		}).add;
		~buffers = ~stemFiles.collect { |path|
			Buffer.cueSoundFile(~server, path, ~startFrame, 2, 65536);
		};
		// Reset counter, just in case
		~counter = 0;
	};

	~play = {
		//This happens exactly at next bar
		~clock.playNextBar({
			~clock.tempo = ~tempo / 60;
			~clock.beatsPerBar = ~beatsPerBar;
			~clock.sched(~duration, {
				"Duration end".postln;
			}.inEnvir);
		}.inEnvir);
		// This happens at next bar
		// minus timing offset calculated from cell snapOffset (see above)
		~clock.schedAbs(Quant(~clock.beatsPerBar, 0, ~timingOffset).nextTimeOnGrid(~clock), {

			// s.bind adds another `s.latency` amount of latency
			~server.bind {
				~synths = ~buffers.collect { |buf|
					var syn = Synth(\cellDiskIn_2, [\bufnum, buf], ~group)
					.onFree({
						// When synth is freed, subtract one for each synth
						~counter = ~counter - 1;
						if (~counter == 0) {
							// Free everything when no synths are playing
							~buffers.free;
							~group.free;
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
		~synths.do { |x| x.release(~fadetime) };
	};



});
z.play
)

SynthDef(\click, {
	Line.ar(dur:0.05, doneAction:2);
	Out.ar(0, Decay.ar(Impulse.ar(0), \decay.kr(0.1)).dup.tanh)
}).add

z.stop
(z[\startFrame] - z[\snapOffset]) / 48000
Tempo.bpm = 60;
Pbind(\instrument, \click, \decay, Pseq([0.2, 0.1, 0.1, 0.1], inf)).play(quant:4)
