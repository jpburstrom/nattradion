SynthDef(\rockring_ringmod, { |tempo, baseFreq|

	var snd,
	freqs = baseFreq / [ 11.0, 4.0, 2.75, 2.0, 1.375 ],
	trig1 = Impulse.ar((tempo * Demand.ar(Impulse.ar(0.25), 0, Diwhite(3, 8, inf)))/60),
	trig2 = Impulse.ar((tempo * 2)/60),
	rockring = Demand.ar(trig1, Dust.ar(10), Dgeom(1, 1.25)),
	ringmod = Demand.ar(trig2, Dust.ar(5), Dgeom(1, 1.25));


	rockring = SinOsc.ar(rockring * baseFreq) * Decay.ar(trig1, LFNoise1.kr(1).range(0.1, 4)).lag(0.002);
	ringmod = SinOsc.ar(ringmod * Demand.ar(trig1, 0, Dseq(freqs, inf))
	) * Decay.ar(trig2).lag(0.002);

	snd = rockring * ringmod * 0.25;
	snd = Pan2.ar(snd, LFNoise1.kr(0.2)) +
	Pan2.ar(FreqShift.ar(snd, Demand.ar(Stepper.ar(trig1), 0, Dseq(freqs, inf)).neg), LFNoise1.kr(0.3));

	snd = RLPF.ar(snd, LFDNoise3.kr(LFNoise1.kr(1).range(0.1, 10)).exprange(800, 18000), 0.1);
	snd = HPF.ar(snd, 50);

	snd = SoftClipper4.ar(snd);

	Out.ar(\out.kr(0), snd);

}).add;

/*EOF*/

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("rockring_ringmod.wav".resolveRelative);
	s.sync;
	Ndef(\rockring_ringmod).play;
	60.wait;
	Ndef(\rockring_ringmod).end(5);
	10.wait;
	s.stopRecording;
	"Done".postln;
}
)