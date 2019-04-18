
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
			\instrument, \bufPlayerSang,
			\index, Plazy { Pwhite(0, ~buffers.keys.size - 1) },
			\key, Plazy { Pindex(~buffers.keys.asArray, Pkey(\index), inf) },
			\freq, p { |ev|
				var map = (
					sang_a: 110.0,
					sang_a2: 220.0,
					sang_e: 164.81377845643,
					sang_b: 246.94165062806,
					'sang_c#': 277.18263097687,
					'sang_d#': 311.12698372208,
					sang_g: 195.99771799087
				);
				loop {
					ev = map[ev.key].yield;
				}
			},
			\bufnum, Pfunc { |ev| ~buffers[ev.key].postln },
			\dur, Pfunc { |ev| ev.bufnum.duration },
			\pan, Pfuncn({ |ev|
				[-0.5, 0.5].interpolate(4.5).scramble[ev.index]
			}, inf),
			\delta, Pkey(\dur) * 0.8,
			\amp, 0.4,
		)
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