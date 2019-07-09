(
SynthDef(\flute, {

	var snd, noise = { Latch.ar(GrayNoise.ar, Impulse.ar(\latch.kr(800))) }.dup(2) * 0.1;

	snd = CombC.ar(noise, 0.05, \freq.kr(440).reciprocal * [1, 0.501] * SinOsc.ar(3.5).range(0.999, 1.001), 0.5).reduce('*');

	snd = RLPF.ar(snd, 2000, 0.5);
	snd = RHPF.ar(snd, \freq.kr * 0.25, 0.2);
	snd = snd + RHPF.ar((noise * Env.perc(0.00, 0.01, 0.1).ar), \freq.kr * 0.5, 0.01);
	snd = snd + DelayC.ar(snd, 0.05, {LFNoise1.kr(0.5).range(0, 0.05)}.dup);
	snd = snd * Env.adsr(\atk.kr(0.0), \decay.kr(0.1), \susLevel.kr(0.05), \rel.kr(0.2)).ar(2, \gate.kr(1));
	snd = snd.tanh;
	snd = (snd * 0.7) + (snd.reverse * 0.3);

	Out.ar(\out.kr(0), Balance2.ar(snd[0], snd[1], \pan.kr(0), \amp.kr(0.1)));
}).add;
);


(
Pdef(\gravity, Pbind(
	\octave, Prand([4,6], inf).clump(3),

	\dur, Pseg([16, 0.25, 0.5, 16], [32, 3, 16], \lin, inf).round(0.25),
	\legato, 1,
	\strum, Pkey(\dur) * 0.33,
	\latch, Pseg(Pexprand(800, 16000), Pwhite(10, 20.0), \exp),
	\instrument, \flute,
	\atk, Pwhite(0.0, 0.01),
	\decay,Pbrown(0.001, 0.01, 0.002),
	\susLevel, Plprand(0.001, 0.05) * Pkey(\dur).linlin(0.25, 16, 0.1, 1),
	\pan, Pwhite(-0.5, 0.5).clump(3),
	\amp, 6,
	\rel, 5,
	\root, -4,
	\scale, Scale.harmonicMinor,
	\degree, Pstep([[0,1,4], [2,4,5], [2,5,7]], 2, inf) * Pwhite(1,2)
));
)
/*EOF*/

Pn(Pdef(\gravity), 1).scoreClockRender("gravity.wav".resolveRelative, 120, 10)