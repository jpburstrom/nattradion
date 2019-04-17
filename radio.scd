// Temporary radio

s.waitForBoot {
	var main = "main.scd".loadRelative[0];

	// { EnvGen.kr(Env.perc, Impulse.kr(0.2), 0.1) * SinOsc.ar.dup }.play;

	if (main.isStopped) {
		main.play
	};

}
