SynthDef(\hall, {
	Out.ar(\out.kr(0), NHHall.ar(In.ar(\out.kr, 2) * \amp.kr(0.1), \time.kr(2.1, 5)))
}).add;


SynthDef(\limiter, {
	var snd = In.ar(\out.kr(0), 2);
	snd = snd * \preamp.kr(1);
	snd = Limiter.ar(snd, 0.99);
	ReplaceOut.ar(\out.kr, snd);
}).add