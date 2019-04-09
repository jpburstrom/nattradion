var parser = (
	state: \default,
	out: (loops: ()),
	run: { |ev, line|
		ev[ev.state].value(ev, line);
	},
	reset: { |ev|
		ev.out.clear;
	},
	default: { |ev, line|
		var sub = line.split(Char.space)[0].toLower.asSymbol;
		if ([\smpl, \cue, \list].includesEqual(sub)) {
			ev.state = sub;
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
			line.trim.findRegexp("[^:]+:\\s+\\S+\\s+").do { |item|
				var thing = item[1].split($:).collect(_.trim);
				if (thing[0] == "Pos") {
					ev.out.pos.add(thing[1].asInteger);
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
			ev.state = \loop;
		};
	},
	loop: { |ev, line|
		if (line[0].isSpace) {
			var loop = ();
			line.trim.findRegexp("[^:]+:\\s+\\S+\\s+").do { |item|
				var thing = item[1].split($:).collect(_.trim);
				if (thing[0] == "Cue ID") {
					ev.out.loops[thing[1].asInteger - 1] = loop;
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
			ev.out.lbl[data[1].asInt - 1] = data[2].asSymbol;
		};
	},

	getMarkers: { |ev|
		var loopKeys = ev.out.loops.keys;
		[ev.out.lbl, ev.out.pos].flop
		.reject({ |v, i| loopKeys.includes(i) })
		.flat
		.asDict
	},

	getRegions: { |ev|
		var out = IdentityDictionary();
		ev.out.loops.keysValuesDo { |index, v|
			var name = ev.out.lbl[index];
			out[name] = [v.start.asInteger, v.end.asInteger]
		};
		out
	},

	parse: { |ev, headerString|
		headerString.split(Char.nl).do { |line|
			ev.run(line)
		};
	};

);

Fdef(\readMarkers, { |file|
	SoundFile.use(file, { |f|
		parser.parse(f.readHeaderAsString);
	});
	parser.getMarkers;
});


