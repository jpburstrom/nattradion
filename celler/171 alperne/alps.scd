SynthDef(\alps, {

	var base = 311.12698372208; //"Eb3".namecps;
	var freqs = [0.75, 1, 1.5];

	var trig = Trig.kr(Dust.kr(0.1) + Impulse.kr(0), 8);
	var freq = (base * Demand.kr(trig, 0, Dxrand([1,2], inf)));
	// var freq = 220 ;
	var cookedFreq = freq * freqs * Env([0.98, 0.98, 1], [0, 0.2], \exp).kr(0, trig);
	var snd = Saw.ar(cookedFreq) *  Env([0.1, 32, 3, 0.01], [1, 3, 16], \exp).ar(0, trig);
	snd = snd * [0.5, 1, 0.5];
	snd = DelayC.ar(NHHall.ar(Splay.ar(snd), 8), 0.02, LFNoise2.kr(0.1).exprange(0.001, 0.02), 0.25) + snd;

	snd = SoftClipper8.ar(snd);
	snd = RLPF.ar(snd, freq * freqs * 0.5, 0.1);

	snd = (LPF.ar(snd, 100) * 0.2) + Latch.ar(snd, Impulse.ar(LFDNoise3.kr(0.1).exprange(5000, 10000))).lagud(2, 0.1) * 8;
	snd = Splay.ar(snd);
	snd = (snd * 0.8) + BPF.ar(snd, 2000, 0.01);
	snd = HPF.ar(snd, base * 2);
	snd = snd * AmpCompA.kr(freq, base, 0.32).lag(0.01);

	snd = Limiter.ar(snd, 0.95, 0.1);



	snd = snd * Env.cutoff(20, 1, 4).ar(2, \gate.kr(1));

	Out.ar(\out.kr(0), snd);

}).add;
/*EOF*/

(
fork {
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("alps.wav".resolveRelative);
	Ndef(\modHall, {
		var snd = In.ar(0, 2);
		snd = (NHHall.ar(DelayC.ar(snd, 0.2, LFNoise1.kr(0.2).exprange(0.01, 0.1)), 24, 1, hiFreq:1000, hiRatio:0.1, modDepth:0.8) * 0.1) + (snd * 0.1);
		ReplaceOut.ar(0, snd);
	}).play;

	Ndef(\alps).play(addAction:\addToHead);
	150.wait;
	Ndef(\alps).end;
	20.wait;
	s.stopRecording;
}
)