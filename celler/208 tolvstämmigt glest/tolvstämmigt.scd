(
SynthDef(\tolv, {

	var snd = SinOsc.ar(Array.geom(12, \freq.kr(440), \freqMul.kr(2)), pi);


	snd = Splay.ar(snd, 0.2, levelComp:true);

	snd = snd.tanh;

	snd = snd * Env.asr(\atk.kr(0.01), 1, \rel.kr(0.01), -5).ar(2, \gate.kr(1));

	Out.ar(\out.kr(0), snd * \amp.kr);
}).add;
)


(
TempoClock.tempo = 110/60;
Pdef(\tolv, Pbind(
	\instrument, \tolv,
	\octave, 2,
	\note, Pwhite(0, 12).repeat(12),
	\freqMul, Pseg(Pwhite(1.1, 1.12), 12, \exp, inf),
	\legato, 1,
	\atk, Pwhite(0.01, 0.25),
	\sustain, 0.1,
	\dur, Pwhite(5.0, 20),
	\rel, Pkey(\dur) * 0.7,
	\amp, Pn(0.3, 12),
)
).play
)

(
s.recorder.recHeaderFormat = "wav";
s.recorder.recSampleFormat = "int24";
s.record("tolv.wav".resolveRelative);
Pdef(\tolv).play;
)


s.stopRecording;
