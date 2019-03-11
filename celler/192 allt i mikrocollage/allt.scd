~randomLength = {
	0.05.exprand(0.9)
};

~allFiles = List();
PathName("~/Dropbox/Delat/Nattradion/celler/").filesDo { |file|
	if (file.extension == "wav") {
		~allFiles.add(file.absolutePath)
	}
};

~getBuffers = {
	~allFiles.collect { |path|
		SoundFile.use(path, { |f|
			var len = ~randomLength.value * f.sampleRate;
			var start = 0.rrand(f.numFrames - len);
			Buffer.read(s, path, start, len);
		})
	};
}

~getSingleBuffer = { |index|
	var path = ~allFiles[index];
	SoundFile.use(path, { |f|
		var len = ~randomLength.value * f.sampleRate;
		var start = 0.rrand(f.numFrames - len);
		Buffer.read(s, path, start, len);
	})
};
~buffers = ~getBuffers.value;

(
SynthDef(\bufPlayerAllt, {
	var startPos = BufFrames.kr(\bufnum.kr) * \reverse.kr(1);
	var bufRate = ((\reverse.kr * -2) + 1) * \bufRate.kr(1);
	var snd = PlayBuf.ar(2, \bufnum.kr, BufRateScale.kr(\bufnum.kr) * bufRate, startPos: startPos);
	var fade = 0.002;
	var dur = \sustain.kr(0) - (fade * 2);
	snd = FreqShiftAA.ar(snd, \freqshift.kr);
	snd = HPF.ar(snd, 40);
	snd = Balance2.ar(snd[0], snd[1], \pan.kr(0), \amp.kr);
	//snd = snd + AllpassC.ar(snd, 0.2, LFNoise2.kr(4).exprange(0.01, 0.2), \allpassDecay.kr(0.2));
	snd = SoftClipAmp4.ar(snd, \dist.kr(1), \dist.kr.reciprocal * 2);
	snd = snd * Env.linen(fade, dur, fade).ar(2);
	Out.ar(\out.kr, snd);
}).add;
)
~buffers
(
Pdef(\allt, Pbind(
	\instrument, \bufPlayerAllt,
	\legato, 1,
	\hasGate, false,
	\amp, Pexprand(0.1, 1),
	\dist, Pwhite(1.0, 16),
	\allpassDecay, Pexprand(0.1, 5),
	\bufnum, p { |ev|
		//Loop through all buffers while reloading the previous one
		//(Getting a new random position in the file)
		loop {
			~buffers.do { |buf, i|
				var prev = (i - 1) % ~buffers.size;
				~buffers[prev].free;
				~buffers[prev] = ~getSingleBuffer.(prev);
				ev = buf.yield;
			};
		}
	},
	\pan, Pwhite(-0.5, 0.5),
	\bufRate, Pexprand(0.25, 4),
	\reverse, Pwhite(0, 1),
	\freqshift, Pwhite(-100, 100),
	\durMul, Pseg(Pwhite(0.01, 1), Pwhite(1.0, 7), \exp, inf),
	\dur, Pfunc { |ev| ev.bufnum.duration * ev.bufRate.reciprocal * ev.durMul }
)).play
)


(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("allt.wav".resolveRelative);
	s.sync;
	Pdef(\allt).play;
	180.wait;
	Pdef(\allt).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)