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
			from.waitForPos(\end, (time + to.getMarkerTime(\start)).neg);
			from.fadeOut(time);
			to.play(nil, from.getQuant, from.clock);
		},

		xfade: { |self, from, to|
			var time = self.getFadeTime(from, to);
			from.waitForPos(\end, time.neg);
			from.fadeOut(time);
			to.fadeIn(time);
		},


		oneshot: { |self, from, to|

			var endTime;
			var oneshot = self.oneshots.takeCell;

			//Spawn oneshot separately
			self.spawn({
				from.waitForPos(\end, oneshot.getMarkerTime(\start).neg);
				oneshot.play;
			});

			//Calculate oneshot start->end duration, 0 by default
			endTime = (oneshot.getMarkerTime(\end, false) ? 0) - oneShot.getMarkerTime(\start);
			//And subtract start marker
			endTime = endTime - to.timeToPos(\start);

			//Now endTime is an offset, which is negative if to[\start] is
			//greater than oneshot duration. Use that as offset to the
			//waiting time.
			from.waitForPos(\end, endTime);
			to.play;
		},

		bridge: { |self, from, to|
			var bridge = self.bridges.takeCell;

			//See if we have a end marker in the bridge, otherwise
			var syncPoint = bridge.getMarkerTime(\end, false) ?? {
				bridge.settings[\duration] * 0.5;
			};

			//Spawn bridge separately
			self.spawn({
				from.waitForPos(\end, syncPoint.neg);
			});

			//Play syncing from.end with to.start
			self.transitions.cut.value(self, from, to);
		},

	)
);

transitions
