Server.remote("bela", NetAddr("bela.local", 57110));
~bela = Server.named[\bela]
Server.default = ~bela
~bela.initTree
CmdPeriod.freeRemote = true

(
Ndef(\test, {
	var trig = Impulse.ar(6);
	var freq = Demand.ar(trig, 0, Drand(["E0", "A0", "D1", "A1"].namecps ++ 0, inf)).lag2(0.01);
	var oct = Demand.ar(Impulse.ar(1), 0, Dseq([1,2,3], inf));
	var snd = SinOsc.ar(freq * oct) * 0.8;
	snd
}).play

)
