(
SynthDef(\enSkala, {
	var trig = Decay.ar(Impulse.ar(0), 0.04) * PinkNoise.ar;
	var snd = DynKlank.ar(`[[1,2.02,3.01, 5], [0.6, 0.2, 0.15, 0.1], [1,3,2]], trig, \freq.kr(440) * SinOsc.ar(Rand(2,6)).range(0.995, 1.005));
	snd = snd * Env([0,1, 1, 0], [0.002, 1, 0.1]).ar(2);
	snd = snd.dup * 0.1;
	snd = snd.softclip * 0.5  * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add;
);

(
Pdef(\enSkala, Pbind(
	\instrument, \enSkala,
	\octClump, Pstep([2,3,4], 16, inf),
	\octave, Pclump(Pkey(\octClump), Place([[4, 5, 6].reverse, [4,5], 3], inf)),
	\notScale, Pclutch(
		Pstep([Scale.harmonicMinor, Scale.mixolydian], 12, inf),
		Pfunc { |ev| ev.octave.includes(3) }
	),
	\scale, Pfunc { |ev|
		Scale((0..11).reject({ |x| ev.notScale.semitones.includes(x.asFloat) }), 12, Tuning.just)
	},
	\root, Pif(Pbinop('==', Pkey(\notScale), Scale.harmonicMinor), 0, 3),
	\test, Pfunc { |ev| ev.notScale.name; ev.root + ev.scale.degrees },
	\degClump, Pstep([2,1], 7, inf),
	\degree, Pclump(Pkey(\degClump), Place([(0..3).reverse, (1..4), (3..8)].reverse, inf)),
	\amp, Place([0.3, [0.05, 0.1], [0.3, 0.05]], inf),
	\dur, Place([[0.25, 0.5], [0.375, 0.125], [0.125, 0.375, 0.5]], inf)
))
)
/*EOF*/

(
Pdef(\enSkala).scoreClockRender("inte-en-skala.wav".resolveRelative, 120, 10, 44100, "WAV");
)

