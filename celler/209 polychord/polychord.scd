(
SynthDef(\poly, {

	var snd = Klank.ar(`[[1,4,8], [1, 0.5, 0.1], [0.5, 0.4, 1]], Decay.ar(Impulse.ar(0), 0.01), \freq.kr(440) * [1, 1.5, 1.25]) * 0.2;

	snd = Splay.ar(snd, 0.4).tanh;

	snd = snd * Env.asr(\atk.kr(0.01), 1, \rel.kr(0.01), -5).ar(2, \gate.kr(1));

	Out.ar(\out.kr(0), snd * \amp.kr);
}).add;
)

(
TempoClock.tempo = 173/60;
Pdef(\poly, Pn(Pbind(
	\instrument, \poly,
	\dur, Pseq([1.6, 2.4, 2.6, 1.4, 1, 0.6, 2.4, 0.6, 1, 2.4, 1.6, 2.4, 1.6, 2.4]),
	\legato, 1,
	\atk, 0,
	\rel, 1,
	\ctranspose, 0,
	\note, Pseq([0,3,13,9, 6], inf).clump(2),
	\octave, Pseq([[4,5], [6,4]], inf)
))).play
)
(instrument:\poly).play

(
fork {
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("poly.wav".resolveRelative);
	Ndef(\hall, {
		var snd = In.ar(0, 2);
		snd = DelayC.ar(NHHall.ar(snd, 1.2) * 0.05, 0.1, 0.1) + (snd * 0.9);

		ReplaceOut.ar(0, snd);
	}).play;
	Pdef(\poly).play;
	90.wait;
	Pdef(\poly).stop;
	10.wait;
	s.stopRecording;
}
)