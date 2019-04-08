(
SynthDef(\sin, {

	var snd = SinOsc.ar(\freq.kr(440, 0.1));
	snd = snd * Env.asr(0.01, 1.0, 0.01).ar(2, \gate.kr(1));
	Out.ar(\bus.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add;
);


(
Pdef(\canon, Ptpar(4.collect({ |i|


	var ptn = Pmono(
		\sin,
		\legato, 1,
		\root, 9,
		\octave, 2,
		\pan, i.linlin(0,3,-0.4, 0.4),
		\dur, Pseq([1, 0.5, 0.5], inf),
		\harmonic, Pseq([1,2,3,5,4,6,5,7,8,7,6,5,4,6,3,5,8,6,9,8,3,4,2,1], inf) + Pstep([0,3], (i+1) * 8, inf),
		\amp, Pkey(\harmonic).reciprocal * 0.25,
	);

	[i*(2.5+(i-1)), ptn]

}).flatten))

)

/*EOF*/
Pn(Pdef(\canon), 1).scoreClockRender("canon.wav".resolveRelative, 120 * 90/60, 10)