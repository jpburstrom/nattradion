(
c = Cell({
	~template[\buffer] = (
		asd: "/Volumes/Mega/Nattradion masters/090 tetrachord/Tetrachord.wav"
	)
}, \disk);

d = Cell({
	~template[\buffer] = (
				path: "/Volumes/Mega/Nattradion masters/_renamed/017 trio/trio.wav"
			)
}, \disk);

x = Cell({
	~template[\buffer] = (
				path: "/Volumes/Mega/Nattradion masters/099 valsång, vals, va/Clips/099 valsång, vals, va 14.wav"
	)
}, \disk).name_("x");

y = Cell({
	~template[\buffer] = (
				path: "/Volumes/Mega/Nattradion masters/099 valsång, vals, va/Clips/099 valsång, vals, va 15.wav"
	);

	~markers = (
		end: 9 * 44100
	);

}, \disk).name_("y");


)
d.play
c.load
x.play
c.play(160)
c.clock.beats
c.timeToPos(\end)
x.isPlaying
~transitions.testTransition(c, d, \cut)
~transitions.testTransition(c, d, \bridge, x)
~transitions.testTransition(c, d, \oneshot, y)
y.timeToPos(\end)
~transitions.transitions.cut.forks