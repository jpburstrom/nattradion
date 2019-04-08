
(
SynthDef(\bufPlayerSang, {
	var snd = PlayBuf.ar(2, \bufnum.kr, BufRateScale.kr(\bufnum.kr), doneAction:Done.freeSelf);
	snd = SelectX.ar(LFNoise2.ar(1).range(0, 1), [snd, FreqShiftAA.ar(snd, \freq.kr)]);
	Out.ar(\out.kr, Balance2.ar(snd[0], snd[1], \pan.kr(0), \amp.kr(0.1)));
}).add;

);

(
Pdef(\sang,
	Ppar(9.collect { |i|
		Pbind(
			\instrument, \bufPlayer,
			\index, Pfunc { ~buffers.size.rand; },
			\freq, Pfunc { |ev|  (i - 4) * (["A1", "A2", "B2", "C#3", "D#3", "E2", "G2"].namecps[ev.index]) },
			\bufnum, Pfunc { |ev| ~buffers.postln[ev.index] },
			\dur, Pfunc { |ev| ev.bufnum.duration },
			\pan, Pfuncn({ |ev|
				[-0.5, 0.5].interpolate(4.5).scramble[ev.index]
			}, inf),
			\delta, Pkey(\dur) * 0.8,
			\amp, 0.05,
		).trace
	})
);
);
/*EOF*/


(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("sang.wav".resolveRelative);
	Ndef(\hall).play;
	s.sync;
	Pdef(\sang).play;
	180.wait;
	Pdef(\sang).stop;
	20.wait;
	s.stopRecording;
	"Done".postln;
}
)