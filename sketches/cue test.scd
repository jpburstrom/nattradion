c = Cue({

	~numChannels = 2;
	~startFrame = 0;
	~path = "/Users/johannes/Dropbox/Delat/Nattradion/celler/078 lindha/078 lindha.wav";
	~server = Server.default;

	~load = {
		SynthDef(\sfPlayer, {
			// var snd = VDiskIn.ar(~numChannels, \bufnum.kr(0), \rate.kr(1), \loop.kr(0));
			var phase = Phasor.ar(0,( SampleRate.ir * BufDur.kr(\bufnum.kr(0))).reciprocal.poll) ;
			var snd = Warp1.ar(~numChannels, \bufnum.kr(0), phase * 2, 1, 0.05, overlaps: 2);
			// snd = snd + BufRd.ar(~numChannels, \bufnum.kr(0), phase * BufFrames.kr(\bufnum.kr(0)));
			snd = snd * Env.asr(\atk.kr(0.002), 1, \rel.kr(1), [4, -4]).ar(2, \gate.kr(1));
			Out.ar(\out.kr(0), snd * \amp.kr(1));
		}).add;
		// ~buf = Buffer.cueSoundFile(~server, ~path, ~startFrame, ~numChannels);
		~buf = Buffer.read(~server, ~path , ~startFrame);
		~server.sync;
		~buf.postln;
	};

	~play = { |self|
		~synth = Synth(\sfPlayer, [\bufnum, ~buf]).onFree {
			self.freeAll;
		};
	};

	~stop = {
		~synth.release;
	};

	~freeAll = {
		"free".postln;
		~buf.free;
	};

	~set = { |k, v|
		~synth.set(k, v);
	};

});


c.play;

/*
c[\buf]
c.stop
c.state
*/

1 / 48000
