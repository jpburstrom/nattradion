(
SynthDef(\vibra, {
	var snd = DynKlank.ar(`[[1,2,4,7], [0.8, 0.3, 0.15, 0.06], [0.5, 0.2, 0.09,0.04]],
		PinkNoise.ar *
		SinOsc.ar(XLine.ar(1220, 20, 0.01), pi * 0.5) * Env.perc(0, 0.1, curve:-12).ar,
		\freq.kr(440) + XLine.ar(1, 0.9, 0.5) * SinOsc.ar(XLine.kr(0.01, 5, 0.01), pi*0.5).range(0.99, 1.005), decayscale: \decay.kr(1)) * 0.05;
	snd = snd * Env.asr(\atk.kr(0.002), 1, \rel.kr(0.002)).ar(2, \gate.kr(1));
	snd = RHPF.ar(snd, \freq.kr * 1.5, 0.1);
	snd = snd.tanh;
	Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;

Ndef(\weirdHall, { NHHall.ar(DelayC.ar((In.ar(0, 2) * 8), 0.125, 0.125), 0.8).tanh * 0.125 * 0.1  }).play;
)

(
TempoClock.tempo = 90/60;
Pdef(\kvint, Ptpar(
	//Three voices
	Array.geom(3, 110, 1.5).collect({ |baseFreq, i|
		[i * 0.5,
			Pbind(
				\instrument, \vibra,
				//Duration follows based on [1, 1.5] pattern
				// 1 beat pause every (5 * i) times
				\dur, Pn(Pseq([Pseq([1, 1.5] * 0.5, (i + 1) * 5), 1])),

				\legato, Pwhite(0.6, 1.1),
				\series, Pn(Pgeom(1, 1.5, 64 - i).wrap(1, 4)),
				\rel, 0.5,
				\decay, Pkey(\series) * 2,
				\atk, Pexprand(0.0001, 0.1) * Pkey(\decay),
				\pan, (i * 0.5) - 0.5,
				\amp, Pseq([0.3, 0.1, 0.09, 0.2, 0.05], inf),
				\timingOffset, i * Pwhite(-0.01, 0.01),
				\freq, Pkey(\series) * baseFreq
			)
		]
	}).flatten
)).play
)

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("kvint.wav".resolveRelative);
	s.sync;
	Ndef(\weirdHall).play;
	Pdef(\kvint).play;
	150.wait;
	Pdef(\kvint).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)
