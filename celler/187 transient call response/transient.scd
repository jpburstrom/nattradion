(
SynthDef(\transient, {

	var snd = Decay.ar(Impulse.ar(0), 0.05);

	snd = Formlet.ar(snd, \freq.kr(300) * [1, 2.25], ExpRand(0.002, 0.01), ExpRand(0.01, 0.2)).sum * 0.5;

	snd = SoftClipAmp4.ar(snd, 0.25, 4);

	//Slapback
	snd = snd - DelayC.ar(snd, 0.1, 0.1, 0.05);

	Env.cutoff.ar(2, \gate.kr(1));



	Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;
);

(
Pdef(\transient, Ppar(
	[
		Pbind(
			\instrument, \transient,
			\dur, Pn(Rest(0.375), 1) ++ Pstep(Pseq([1, 2, 1.5], inf), 6, inf),
			\octave, 8,
			\scale, Scale.majorPentatonic,
			\tuning, Tuning.sept2,
			\amp, 0.09,
		),
		Pbind(
			\instrument, \transient,
			\dur, Pseq([0.5, 1.0] * 0.5, inf),
			\octave, 7,
			\scale, Scale.majorPentatonic,
			\tuning, Tuning.sept2,
			\amp, Pseq([0.07, 0.1], inf)
		),
		Pbind(
			\instrument, \transient,
			\tuning, Tuning.sept2,
			\scale, Scale.majorPentatonic,
			\amp, Pwhite(0.08, 0.2),
			\dur, p { |ev|
				var arr, note, pan = 0.6;
				loop {
					arr = 2.rrand(8).collect({
						1.0.rand
					}).normalizeSum.round(0.125) + 0.125;

					note = 0.rrand(2);

					[2,4,6].choose.do {
						pan = pan.neg;
						arr.do { |t|
							ev.degree = note;
							ev.pan = pan;
							ev = t.yield;
						};
						note = 7 - note;
					}
				}
			}

		)
	]
))
)
/*EOF*/

Pn(Pdef(\transient), 1).scoreClockRender("transient.wav".resolveRelative, 120, 10);