~vst = VstPlugin.new;
~vst.open("/Library/Audio/Plug-Ins/VST/Pianoteq 5 STAGE.vst", info:true)
~vst.showGui
~vst.setProgram(0)
~vst.readProgram("/tmp/reaktor.FXP")
(
Event.addEventType(\vstPlugin, { |server|
    var notes = [
        ~midinote.value,  // 0
        ~ctranspose.value,  // 1
        ~velocity.value, // 2
        ~sustain.value, // 3
        ~lag.value, // 4
        ~timingOffset.value, //5
        ~instrument, // 6
        ~midiChannel.value, // 7
    ].flop;
    var timeNoteOn, timeNoteOff;

	{ ~instrument.setParameter(0, ~susPedal); }.inEnvir.defer;
	{ ~instrument.setParameter(64, ~condition); }.inEnvir.defer;

    notes.do { |note|
        // sustain and timingOffset are in beats, lag is in seconds
        timeNoteOn = (thisThread.clock.tempo.reciprocal*note[5])+note[4];
        timeNoteOff = (thisThread.clock.tempo.reciprocal*(note[3]+note[5]))+note[4];

        SystemClock.sched(timeNoteOn, {
            note[6].midiNoteOn(chan: note[7] ? 0, note: (note[0]+note[1]).asInteger, veloc: note[2].asInteger.clip(0,127));
        });
        SystemClock.sched(timeNoteOff, {
            note[6].midiNoteOff(chan: note[7] ? 0, note: (note[0]+note[1]).asInteger, veloc: note[2].asInteger.clip(0,127));
        });
    }
});
)
TempoClock.tempo = 92/60
(
Pdef(\vst, Pbind(*[
    type: \vstPlugin,
    instrument: ~vst,
	octave: Pstep([3,5,4], Prand([0.25, 0.5, 1], inf), inf) ,
	dur: Pwrand([2, Pwrand([0.75, 0.25, Pseq(0.5.dup(3) / 3), Pseq(0.125.dup(2))] * 2, [4,3,2,1].normalizeSum, 1)], [0.1, 0.9], inf),
	scale: Scale.hungarianMinor,
	root: 4,
	mtranspose: Pstep(Pwhite(0, 3), 16, inf),
	degree: Pseq([0,2,5],inf) + Pshufn([0, Pwrand([4,5], [0.2, 0.8], 1), 3], inf).stutter(5),
	degree: Pfunc({
		var prev=[];
		{ |ev|
			ev.degree = ev.degree.asArray.collect { |deg|
				if (prev.includes(deg)) {
					deg = deg + 1;
				};
				deg
			};

			 prev = ev.degree;

		}
	}.value),
	legato: Pkey(\octave) - 2,
	susPedal: Pkey(\octave) - 3,
	condition: Pseg(Plprand(0.3, 0.75), Pwhite(5,10)),
	velocity: Pbrown(26, 62, 20)
])).play;
)



Pdef(\vst).stop

(
Ndef(\out, {
	var snd = In.ar(0, 2);

	snd = SoftClipAmp8.ar(snd, 1.2, 1);
	snd = (NHHall.ar(snd, 0.5) * 0.1) + (snd * 0.9);

	ReplaceOut.ar(0, snd);

}).play
)
