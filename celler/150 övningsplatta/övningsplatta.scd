(
SynthDef(\pad, {
	var snd = Env.perc(0, 0.001).ar;


	snd = SoftClipAmp.ar(snd, 2) * \amp.kr(0.1);
	snd = Formlet.ar(snd, ExpRand(80, 120), 0.001, 0.02) * 0.1;

	snd = HPF.ar(snd, 100);

	Env.perc.ar(2);

	OffsetOut.ar(\out.kr(0), Pan2.ar(snd, \pan.kr(0)));
}).add;
);

//Ndef(\hall, { NHHall.ar(In.ar(0, 2), 0.4) * 0.05  }).play;

(
Pdef(\padder, { |dur|

	Pbind(
		\tempo, 70/60,
		\instrument, \pad,
		\amp, Pexprand(0.1, 0.7),
		\pan, Pwrand([-0.3, 0.3, [-0.3, 0.3]], [0.4, 0.4, 0.2], inf),
		\strum, Plprand(0.001, 0.05),
		\dur, Pshuf([0.125, 0.125, 0.25, 0.125, 0.125, 0.5].normalizeSum) * dur.value,
	);
});

Pdef(\padPlayer, Pbind(\type, \phrase, \instrument, \padder, \dur, 12, \legato, 4, \recursionLevel, 1));
)

/*EOF*/
(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("ovningsplatta.wav".resolveRelative);
	s.sync;
	Pdef(\padPlayer).play;
	60.wait;
	Pdef(\padPlayer).stop;
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)