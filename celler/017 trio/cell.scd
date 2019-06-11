
/*
(
Ndef(\filter, {
	ReplaceOut.ar(0, SoftClipAmp.ar(HPF.ar(In.ar(0, 2), LFNoise2.kr(0.1).exprange(1500, 12000)), 4, 0.25))
}).play;
Ndef(\rev, { NHHall.ar(In.ar(0, 2), 1.5) * 0.2 }).play
)
*/


Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'trio': "017 trio/trio.wav"
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
