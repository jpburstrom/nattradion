//Library of transitions
var transitions = (

	oneshots: "cellBag.scd".loadRelative[0],
	bridges: "cellBag.scd".loadRelative[0],

	// Keep track of spawned processes
	forks: Set(),

	settings: (
		fadeBounds: [5.0, 20]
	),

	checkAddCell: { |self, cell|
		self.oneshots.checkAddCell(cell, \isOneshot);
		self.bridges.checkAddCell(cell, \isBridge);
	},

	clearAll: { |self|
		self.oneshots.clearAll;
		self.bridges.clearAll;
	},

	freeAll: { |self|
		self.forks.do(_.stop);
		self.forks.clear;
	},

	getFadeBounds: { |self, from, to|
		//Set max fade duration to 1/3 of either cell
		// var fadeMax = from.getDuration.min(to.getDuration) * 0.33;
		var fadeMax = 10;
		//Scale fadeBounds so that max bounds value == fadeMax
		var bounds = self.settings.fadeBounds * (fadeMax / self.settings.fadeBounds[1]).min(1);
		//Return fadeBounds
		to.getDuration.debug("to duration");
		bounds
	},

	getFadeTime: { |self, from, to|
		var bounds = self.getFadeBounds(from, to);
		bounds[0].rrand(bounds[1])
	},

	chooseTransition: { |self, from, to|
		var transit = #[cut, fadeIn, fadeOut, xfade].choose;
		self.spawn({
			self.transitions[transit].value(self, from, to)
		});
	},

	spawn: { |func|
		var routine = fork {
			func.value;
			self.forks.remove(routine);
		}
	}

	transitions: (

		cut: { |self, from, to|
			//FIXME: calculate time until end marker
			//Maybe let this be a part of cell
			from.waitForPos(\end, to.getMarkerTime(\start).neg);
			to.play;
		},

		fadeIn: { |self, from, to|
			var time = self.getFadeTime(from, to);
			from.waitForPos(\end, time.neg);
			to.fadeIn(time);
			//from stops automatically
		},

		fadeOut: { |self, from, to|
			var time = self.getFadeTime(from, to);
			//FIXME: calculate time until end marker
			from.waitForPos(\end, (time + to.getMarkerTime(\start)).neg);
			from.fadeOut(time);
			to.play(nil, from.getQuant, from.clock);
		},

		xfade: { |self, from, to|
			var time = self.getFadeTime(from, to);
			//FIXME: calculate time until end marker
			from.waitForPos(\end, time.neg);
			from.fadeOut(time);
			to.fadeIn(time);
		},


		oneshot: { |self, from, to|

			//TODO: How does cell know it's a oneshot?
			//TODO: Don't pick oneshot derived from (from|to)
			var oneshot = self.pick(\oneshot);
			from.settings[\duration].wait;
			oneshot.play;
			//Oneshot may have a duration, ie time until 'end' marker,
			oneshot.settings[\duration].wait;
			to.play;
		},

		bridge: { |self, from, to|
			//TODO: How does cell know it's a bridge?
			//TODO: Don't pick bridge derived from (from|to)
			var bridge = self.pick(\bridge);
			//TODO: here we're calculating transition point based on bridgeDuration / 2.
			//Maybe it should be handled by bridge instead?
			var halftime = bridge.settings[\duration] * 0.5;
			(from.settings[\duration] - halftime).wait;
			bridge.play;
			halftime.wait;
			self.cut(from, to);
		},

	),
);

transitions
