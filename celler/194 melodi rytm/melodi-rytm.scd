(
SynthDef(\blippo, {
	var snd = Blip.ar(\freq.kr(440).lag(0.1) * SinOsc.kr(Rand(6,8), 0,  XLine.kr(0.001, 1, 1)).range(0.99, 1.01), 7) ;
	snd = snd * Env.adsr(\atk.kr(0.002), 0.1, 0.7, \rel.kr(0.002)).ar(2, \gate.kr(1));
	snd = RHPF.ar(snd, \freq.kr * 3, 0.1) * 0.2;
	snd = snd.tanh;
	Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;

//Ndef(\weirdHall, { NHHall.ar(DelayC.ar((In.ar(0, 2) * 8), 0.125, 0.125), 0.8).tanh * 0.125 * 0.1  }).play;
);


(
Pdef(\blippo, {
	var dice = { (1..6).scramble.first };
	Ppar(
		1.collect { |i|
			Pbind(
				\instrument, \blippo,
				\atk, 0.02,
				\rel, 0.3,
				\legato, 0.1,
				// \legato, Pn(Pn(1, 11) ++ Pn(0.1,1)),
				\scale, Scale.mixolydian,
				\octave, 5,
				\degree, Pn(Pindex(
					[7, Pseq([0, 1]), Pseq([0,2,1]),
						Pseq([2,6]), Pseq([4,5]), Pseq([4,1])],

					Plazy { Pseq(3.collect({ dice.value })) }
				), 40),
				\dur, Pn(Pindex(
					[0.5, Pseq([0.25, 0.25]), Pseq([1/6, 1/6, 1/6]),
						Pseq([0.375, 0.125]), Pseq([0.125, 0.375]), Pseq([2/6, 1/6])],

					Plazy { Pseq(4.collect{ dice.value }) }
				), 30)
			);
	})
});
)

/*EOF*/

Pn(Pdef(\blippo), 1).scoreClockRender("melodi-rytm.wav".resolveRelative, 120, 10)
