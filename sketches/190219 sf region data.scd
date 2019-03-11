a = SoundFile.openRead("/tmp/untitled.wav");
z = a.readHeaderAsString

(
var check = (
	state: \default,
	out: (),
	run: { |ev, line|
		ev[ev.state].value(ev, line);
	},
	reset: { |ev|
		ev.out.clear;
	},
	default: { |ev, line|
		var sub = line.split(Char.space)[0].toLower.asSymbol;
		if ([\smpl, \cue, \list].includesEqual(sub)) {
			ev.state = sub.debug("SUB");
		};
	},
	getSubData: { |ev, line|
		line.split($:).collect(_.trim)
	},
	//Check sub command
	cue: { |ev, line|
		var data = ev.getSubData(line);
		if (data[0] == "Count") {
			ev.out[\count] = data[1].asInt;
			ev.out[\pos] = Array(ev.out[\count]);
			ev.out[\lbl] = nil ! ev.out[\count];
			ev.state = \marker;
		};
	},
	marker: { |ev, line|
		if (line[0].isSpace) {
			line.trim.findRegexp("[^:]+:\\s{1,2}\\S+\\s+").do { |item|
				var thing = item[1].split($:).collect(_.trim);
				if (thing[0] == "Pos") {
					ev.out.pos.add(thing[1]);
				};
			}
			// line.split(Char.space).postcs;
		} {
			ev.state = \default;
			ev[ev.state].value(ev, line);
		}
	},
	smpl: { |ev, line|
		var data = ev.getSubData(line);
		if (data[0] == "Loop Count") {
			ev.out[\loopCount] = data[1].asInt;
			ev.out[\loops] = ();
			ev.state = \loop;
		};
	},
	loop: { |ev, line|
		if (line[0].isSpace) {
			var loop = ();
			line.trim.findRegexp("[^:]+:\\s{1,2}\\S+\\s+").do { |item|
				var thing = item[1].split($:).collect(_.trim);
				if (thing[0] == "Cue ID") {
					ev.out.loops[thing[1].asSymbol] = loop;
				} {
					loop[thing[0].toLower.asSymbol] = thing[1];
				}
			}
			// line.split(Char.space).postcs;
		} {
			ev.state = \default;
			ev[ev.state].value(ev, line);
		}
	},
	list: { |ev, line|
		var data = ev.getSubData(line);
		if (data[0] == "labl") {
			ev.out.lbl[data[1].asInt - 1] = data[2];
		};
	};

);
// z.postln;
z.split(Char.nl).do { |line|

	check.run(line);

};
check.out
)
regex