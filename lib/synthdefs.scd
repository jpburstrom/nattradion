SynthDef(\hall, {
	Out.ar(\out.kr(0), NHHall.ar(In.ar(\out.kr, 2) * \amp.kr(0.1), \time.kr(2.1, 5)))
}).add;

SynthDef(\freqshift, { |freq|
	var snd = In.ar(\out.kr(0), 2);
	snd = BLowCut.ar(snd, freq.neg.max(5));
	snd = FreqShift.ar(snd, freq);
	ReplaceOut.ar(\out.kr, snd);
}).add;

SynthDef(\limiter, {
	var snd = In.ar(\out.kr(0), 2);
	snd = snd * \preamp.kr(1);
	snd = Limiter.ar(snd, 0.99);
	ReplaceOut.ar(\out.kr, snd);
}).add;

SynthDef(\test, { ReplaceOut.ar(\out.kr, In.ar(\out.kr, 2) * LFPulse.ar(1).range(0, 1)) } ).add