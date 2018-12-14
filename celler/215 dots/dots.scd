// 215 dots

(

SynthDef(\dots, {

	var snd = Env.asr(\atk.kr(0.002), 1, \rel.kr(0.002), \sin).ar(2, \gate.kr(1));

	snd = snd * DynKlank.ar(
		`[[1,1.99,3.03,5.52], [0.5, 0.25, 0.1, 0.05], 0.3],
		Env.perc(0.002, \sustain.kr, curve:-8).ar * RHPF.ar(WhiteNoise.ar, \freq.kr * XLine.kr(2, 0.667, 0.02), 0.1),
		(\freq.kr * 1).lag3(3) * Rand(0.99, 1.01)
	);

	snd = SoftClipAmp8.ar(snd, 0.05, 1);

	Out.ar(\out.kr, Pan2.ar(snd, \pan.kr(0), \amp.kr(0)));

}).add;



)


~string = ". .
.   .
  .
  . .
. . . ";

~string = ~string.split(Char.nl);



(
TempoClock.tempo = 75/60;
Pdef(\dots, Ppar(
	~string.collect{ |ptn, i|
		Pbind(
			\instrument, \dots,
			\lag, Pwhite(-0.01, 0.01),
			\atk, 0.01,
			\rel, 1,
			\root, -2,
			\stretch, 1 + (i * 0.5),
			\dot, Pseq(ptn, inf),
			\pan, -0.5 + (i / (~string.size - 1)),
			\amp, Pif(Pbinop('==', Pkey(\dot), $.), 0.25, 0.05),
			\degree, Pclutch(Pseq([0, 3, 4], inf) + i, Pbinop('==', Pkey(\dot), $.)),
			\dur, Pclutch(Pseq([0.5, 0.25], inf), Pbinop('==', Pkey(\dot), $.)),
			\scale, Scale.mixolydian,
			\tuning, Tuning.sept1,
			\octave, 4 + (i % 3),
			\legato, Pwhite(0.5, 1.6),
		)
	}.postln
)).play;
)

{ NHHall.ar(DelayC.ar(In.ar(0, 2), 0.1, 0.1), 2) * 0.1 }.play


(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("dots.wav".resolveRelative);
	{ NHHall.ar(DelayC.ar(In.ar(0, 2), 0.1, 0.1), 2) * 0.1 }.play;
	s.sync;
	Pdef(\dots).play;
	120.wait;
	Pdef(\dots).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)