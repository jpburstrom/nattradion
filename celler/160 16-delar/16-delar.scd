(
SynthDef(\s16, {
	var snd, lfo;

	lfo = SinOsc.kr(4, pi * 0.5);

	snd = SinOsc.ar(\freq.kr(440).lag2(0.1) * [0.99, 1.01] * 5) * LFSaw.ar(\freq.kr(440).lag2(0.2) * 1);
	snd = Splay.ar(snd, \width.kr(0.5));
	snd = SoftClipAmp8.ar(snd, lfo.exprange(1,8));
	snd = RLPF.ar(snd,
		Env.adsr(\fatk.kr(0.01), \fdecay.kr(0.01), \fsusLevel.kr(0.8), \frel.kr(1.0)).kr(
			levelScale: 5200, levelBias: 2600), 0.2);
	snd = snd * Env.adsr(\atk.kr(0.01), \decay.kr(0.3), \susLevel.kr(0.67), \rel.kr(0.1)).ar(2, \gate.kr(1));
	Out.ar(0, Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;

);
(
Pdef(\s16, PmonoArtic(
	 \s16,
	\octave, 4,
	\dur, 1/4,
	\width, Pseries(0, 0.3, 3).repeat(inf),
	\scale, Scale.harmonicMinor,
	\pan, Pwhite(-0.1, 0.1),
	\atk, Pseq([0, 0.001], inf),
	\amp, Pseq([0.15, 0.08], inf),
	\decay, 0.1,
	\legato, Pseq(Array.geom(5, 1, 2).pyramid(5).reciprocal, inf) * 2,
	\susLevel, 0.98,
	\rel, 0.01,
	\fatk, Ppatlace([Pwhite(0.001, 0.8), 0.4, Pwrand([0.0, 0.9], [0.1, 0.9], inf)], inf),
	\frel, 0.1,
	\degree, Pstep(Pseq(Array.geom(5, 1, 2).pyramid(5), inf), PdurStutter(Pseq(Array.geom(5, 1, 2), inf), 1)) - 1 * 0.5
));
)

/*EOF*/
Pdef(\s16).stop

(
fork {
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("16-delar.wav".resolveRelative);
	Ndef(\hall, {
		var snd = In.ar(0, 2);
		snd = DelayC.ar(NHHall.ar(snd, 1.2) * 0.15, 0.15, 0.15) + (snd * 0.9);

		ReplaceOut.ar(0, snd);
	}).play;
	Pdef(\s16).play;
	90.wait;
	Pdef(\s16).stop;
	10.wait;
	s.stopRecording;
}
)

Pdef(\s16)