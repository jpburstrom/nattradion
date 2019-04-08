(
SynthDef(\pluck, {
	var decay = \sustain.kr(0.25) * 2;
	var snd = Pluck.ar(PinkNoise.ar, 1, 0.2, \freq.kr(440).reciprocal * [0.999, 1.001], decay, \freq.kr.explin(800, 100, 0.7, 0.9)).sum * 0.606;
	snd = snd - DelayC.ar(snd, 0.01, \freq.kr.reciprocal * SinOsc.ar(\freq.kr * \mod.kr(1.0), pi).range(0, 0.2));
	snd = RLPF.ar(snd, \freq.kr * \ffreqMul.kr(7), 0.05);
	snd = snd.tanh;
	snd = snd * Env.asr(\atk.kr(0), 1, \rel.kr(1), [-8, 4]).ar(2, \gate.kr(1));
	Out.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0), \amp.kr(0.1)));
}).add
);
//Ndef(\hall, { NHHall.ar(In.ar(0, 2), 0.8) *  0.4  }).play;
(
//TempoClock.tempo = 92/60;
Pdef(\reellsekvens, {
	var numNotes = 7;
	Ppar([
		Pbind(
			\instrument, \pluck,
			\octave, Pstep([8, 7, 6], [0.5, 4, 1.5], inf),
			\legato, 0.3,
			\pan, Pseq([-0.5, 0.5], inf),
			\rel, Pwhite(0.01, 1),
			\mod, Pwhite(1.0, 9),
			\dur, Prand([0.25, 0.5, 1], inf),
			\ffreqMul, 2,
			\amp, Pbrown(0.1, 0.6),
		),
		Pbind(
			\instrument, \pluck,
			\ffreqMul, Pshuf([(2..8)], inf).stutter(7),
			\mod, p { |ev|
				var str = Prand([1, 1.25, 1.5, 2, 3, 5, 7, 11], inf).asStream;
				loop {
					var seq = str.nextN(numNotes);
					var add = 0;
					2.do {
						seq.do { |i|
							ev = (i + add).yield;
						};
						add = add + 1;
					};
					2.do {
						add = add - 1;
						seq.reverseDo { |i|
							ev = (i + add).yield;
						};
					}
				};
			},
			\rel, Pbrown(0.1, 0.7),
			\atk, Pbrown(0.0, 0.23),
			\amp, Pkey(\amp) * 2,
			\note, Pfunc({
				var prev = -1;
				{ |ev|
					if (ev.dur < 0.5 and: { prev == ev.note }) {
						Rest().postln;
					} {
						ev.note
					}
				}
			}.value)
		) <>
		Pbind(
			\ctranspose, -15,
			\legato, p { |ev|
				var str = Pwrand([0.9, 0.8, 0.1], [8,5,2].normalizeSum, inf).asStream;
				loop {
					var seq = str.nextN(numNotes);
					var add = 0;
					2.do {
						seq.do { |i|
							ev = (i + add).yield;
						};
						add = add + 0.1;
					};
					2.do {
						add = add - 0.125;
						seq.reverseDo { |i|
							ev = (i + add).yield;
						};
					}
				};
			},
			\dur, p { |ev|
				var str = Pwrand([0.25, 0.5, 1], [8,5,2].normalizeSum, inf).asStream;
				loop {
					var seq = str.nextN(numNotes);
					var add = 0;
					2.do {
						seq.do { |i|
							ev = (i + add).yield;
						};
						add = add + 0.25;
					};
					2.do {
						add = add - 0.25;
						seq.reverseDo { |i|
							ev = (i + add).yield;
						};
					}
				};
			},
			\note, p { |ev|
				var dir = 3;
				loop {
					var transp = 0;
					var seq = (0..11).scramble.drop(numNotes); // 7 notes
					2.do {
						seq.do { |i|
							ev = (i + transp).yield
						};
						transp = transp + dir;
					};
					dir = dir.neg;
					2.do {
						seq.reverseDo { |i|
							ev = (i + transp).yield
						};
						transp = transp + dir;
					};
					dir = dir.neg;
				}
			}

		)
	])
})
);

/*EOF*/

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("reell-sekvens.wav".resolveRelative);
	Ndef(\hall).play;
	s.sync;
	Pdef(\reellsekvens).play;
	180.wait;
	Pdef(\reellsekvens).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)