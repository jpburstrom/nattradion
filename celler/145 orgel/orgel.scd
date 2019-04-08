(
SynthDef(\orgel, {
	var gate = \gate.kr(1);
	var numPartials = 8;
	var partials = Array.series(numPartials, 1).scramble;
	var inAmps = \amps.kr(Array.exprand(numPartials, 0.25, 1));
	var amps = partials.collect { |p, i|
		Env.asr(0.01.exprand(0.2), inAmps[i] * numPartials.reciprocal, 0.01.exprand(0.05)
		).ar(0, gate) * LFNoise1.kr(1).range(0.98, 1.02);
	};
	var snd = DynKlang.ar(`[
		partials,
		amps,
		Array.rand(numPartials, 0, 1)
	], \freq.kr(440), \freqOffset.kr(0));

	snd = snd * AmpCompA.kr(\freq.kr);

	Env.asr(releaseTime:0.05).ar(2, gate);

	snd = snd * -32.dbamp;

	Out.ar(\out.kr(0), Pan2.ar(snd));

}).add
);
(
Pdef(\orgel, Pbind(
	\instrument, \orgel,
	\dur, Pwhite(2,4),
	\legato, 1,
	\numPartials, 8,
	\amps, Pfunc({ |ev|
		var numAmps = 3;
		var r = 0 ! (ev.numPartials - numAmps);
		`((r ++ 3.collect{ 0.25.exprand(1) }).scramble)
	}).stutter(3),
	\scale, Scale((0..12), 13),
	\degree, Pxrand([0,3,6,9,12], inf).clump(3),
	\octave, Pwhite(5,7)
))
);

/*EOF*/

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.record("orgel.wav".resolveRelative);
	s.sync;
	Ndef(\hall, { NHHall.ar(In.ar(0, 2), 4)  }).play;
	Pdef(\orgel).play;
	60.wait;
	Pdef(\orgel).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)

