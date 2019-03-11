var map = "c-d-ef-g-a-h";
var notes = "dance,techno,edm,house,trance".split(Char.comma).collect { |word|
	var out = [];
	word.do { |char|
		out = out.add(map.indexOf(char) ? Rest());

	};
	out = out.replace("-", Rest());
	out
};
(
SynthDef(\dteht, {
	var trig = HPF.ar(Decay.ar(Impulse.ar(0), 0.008).lag(0.02), ExpRand(500, 1500));
	var snd = Klank.ar(`[[1,2.02,5.01, 9.2], [0.6, 0.2, 0.15, 0.1], [0.8,1,0.1, 0.7]], trig, \freq.kr(440), decayscale: \decay.kr(1) );
	snd = snd * Env([0,1, 1, 0], [0.002, \decay.kr, 0.1]).ar(2);
	1.do {
		snd = snd - DelayC.ar(snd, 0.05, SinOsc.ar(Rand(1,4), Rand(0, pi)).range(0, 0.001));
	};
	snd = snd.dup * 0.4;
	snd = snd.tanh * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add
);

Ndef(\weirdHall, { NHHall.ar(DelayC.ar((In.ar(0, 2) ), 0.125, 0.125), 1.8) * 0.1  }).play;

(
Tempo.bpm = 120;
Pdef(\dteht, Pbind(
	\instrument, \dteht,
	\dur, Pseq([0.5, 1], inf),
	\legatos, 1,
	\root, -2,
	\decay, Plprand(1.0, 3),
	\noteAdd, Pstep(Prand([0,3,-6-3], inf), Pwhite(15,30)),
	\degree, p { |ev|
		var transp;
		loop {
			transp = [0,4].wchoose([0.9, 0.1]);
			notes.do { |word|
				word.do { |num, i|
					ev.mtranspose = transp;
					if (i == 0) {
						ev.octave = (4.rrand(5));
					} {
						ev.octave = 6;
					};
					if ((i + 1) == word.size) {
						ev.dur = [1, 2, 4].wchoose([3,2,1].normalizeSum);
					};
					ev.amp = (i + 1).reciprocal * 0.5;
					num = ((num + ev.noteAdd) % 12);
					ev = num.yield;
				}
			};
			notes = notes.rotate(-1);

		}
	},
	\scale, Scale.chromatic(\sept1)
)).play;

)

(
(
fork {
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("dteht.wav".resolveRelative);
	s.sync;
	Ndef(\weirdHall).play;

	Pdef(\dteht).play(addAction:\addToHead);
	150.wait;
	Pdef(\dteht).stop;
	20.wait;
	s.stopRecording;
}
)
)