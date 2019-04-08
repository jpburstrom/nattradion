(
SynthDef(\sinus_koral, {

	var voices = [
		{ Drand([1, 1.25, 1.5], inf) },
		{ Drand([1/1.125, 1.125, 4/3], inf) },
	];

	var notes, snd;
	var hip, lop;

	voices = voices ++ (voices * 2) ++ (voices * 4);
	voices.scramble;
	notes = Demand.kr(Impulse.kr(0) + Dust.kr(0.25), 0, voices);
	notes = notes + { SinOsc.kr(Rand(3,4), Rand(0, 2pi), Rand(0.01, 0.02)) }.dup(4);
	notes = LFNoise2.kr(0.01).exprange(200, 350)* notes.lag2(LFNoise1.kr(0.1).range(0.1, 0.5));

	snd = { SinOsc.ar(notes * LFNoise1.kr(0.1).range(0.999, 1.001), Rand(0, 2pi)) * LFNoise2.kr(0.1).exprange(0.25, 1)  }.dup(48);
	snd = snd.flatten;
	snd.size.postln;



	snd = Splay.ar(snd);
	snd = SoftClipAmp8.ar(snd, 0.5, 0.5.reciprocal) * 0.1;

	hip = HPF.ar(snd, 1000);
	lop = snd - hip;

	hip = FreqShiftAA.ar(hip, -1000);


	snd = lop + hip;


	snd = snd * Env.asr(\atk.kr(1), 1, \rel.kr(1), [-4, 4]).ar(2, \gate.kr(1));
	Out.ar(\out.kr(0), snd);

}).add
)
/*EOF*/
TempoClock.tempo = 1
Ndef(\sinus_koral).end(10);

(
fork {
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("sinus_koral.wav".resolveRelative);
	Ndef(\hall, {
		var snd = In.ar(0, 2);
		snd = (NHHall.ar(snd, 4) * 0.1) + (snd * 0.9);
		ReplaceOut.ar(0, snd);
	}).play;
	Ndef(\sinus_koral).play(addAction:\addToHead);

	150.wait;
	Ndef(\sinus_koral).end(10);
	10.wait;
	s.stopRecording;
}
)