(
fork {
	~buffers = "samples/*".resolveRelative.pathMatch.collect { |path|
		var b = Buffer.read(s, path);
		s.sync;
		b.normalize
	};
}
)

(
(
SynthDef(\bufPlayerE, {
	var snd = PlayBuf.ar(2, \bufnum.kr, BufRateScale.kr(\bufnum.kr), doneAction:Done.freeSelf);
	snd = FreqShiftAA.ar(snd, \freq.kr);
	snd = snd * Env.cutoff(1, 1, \sin).ar(2, \gate.kr(1));
	Out.ar(\out.kr, Balance2.ar(snd[0], snd[1], \pan.kr(0), \amp.kr(0.1)));
}).add;


(
Ndef(\hall, {
	var snd = In.ar(0, 2);
	snd = (NHHall.ar(snd, 2) * 0.05)
}).play
)
)
)
Tempo.bpm = 150;
(
Pdef(\estrang, Pbind(
	\instrument, \bufPlayerE,
	\bufnum, Plazy { Pxrand(~buffers, inf) },
	\pan, Pseq([-0.25, 0.25, -0.5, 0.5], inf),
	\freq, Plprand(0, 10000) * -1,
	\amp, Pkey(\freq).linlin(-10000, 0, 2, 0.1),
	\legato, 2,
	\dur, (Pseg(Pwhite(0.01, 1), Pwhite(1.0, 4.0), \exp, inf) * 4).ceil * 0.25,
	\dur, 0.125 * 20
)).play
)

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("e-strangar.wav".resolveRelative);
	s.sync;
	Pdef(\estrang).play;
	180.wait;
	Pdef(\estrang).stop;
	20.wait;
	s.stopRecording;
	"Done".postln;
}
)