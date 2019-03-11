Ndef(\grazon, {
	var snd;
	snd = [
		LFPulse.ar(1).range(2,3) * LFPulse.ar(0.5).range(0.5,1),
		LFPulse.ar(0.5).range(12,6) * LFPulse.ar(0.1).range(0.5,1),
		LFPulse.ar(3).range(6, 3) * LFPulse.ar(0.25).range(0.5,1),
		LFPulse.ar(1.5).range(3, 12) * LFPulse.ar(0.05).range(0.5,1),
	].collect { |num|
		GrayNoise.ar * LFPulse.ar(num, 0.0, LFNoise2.kr(0.5).range(0.1, 0.3), 0.25, 0.005);
	};

	Splay.ar(snd, 0.6)

}).play;

(
//Play it
fork {
	CmdPeriod.run;
	s.sync;
	s.recorder.recHeaderFormat = "wav";
	s.recorder.recSampleFormat = "int24";
	s.record("grazon.wav".resolveRelative);
	s.sync;
	Ndef(\grazon).play;
	120.wait;
	Ndef(\grazon).end;
	0.2.wait;
	s.stopRecording;
	"Done".postln;
}
)