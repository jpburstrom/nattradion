//Library of transitions
var transitions = (

	oneshots: "cellBag.scd".loadRelative[0],
	bridges: "cellBag.scd".loadRelative[0],


	checkAddCell: { |self, cell|
		self.oneshots.checkAddCell(cell, \isOneshot);
		self.bridges.checkAddCell(cell, \isBridge);
	},

	setMother: { |self, mom|
		self.oneshots.setMother(mom);
		self.bridges.setMother(mom);
	},

	removeCell: { |self, cell|
		self.oneshots.removeCell(cell);
		self.bridges.removeCell(cell);
	},

	removeCellsByMetadata: { |self, key, value|
		self.oneshots.removeCellsByMetadata(key, value);
		self.bridges.removeCellsByMetadata(key, value);
	},

	clearAll: { |self|
		self.oneshots.clearAll;
		self.bridges.clearAll;
	},

	freeAll: { |self|
		self.transitions.forks.do(_.stop);
		self.transitions.forks.clear;
	},

	init: { |self|
		self.oneshots.init;
		self.bridges.init;
	},

	makeFilter: { |self, from, to|
		{ |cell|
			[from, to].collect({ |c|
				c.metadata[\number]
			}).includes(cell.metadata[\number].not);
		};
	},
	chooseTransition: { |self, from, to, type, mask|
		var filter = self.makeFilter(from, to);
		type = type ?? { self.transitions.keys.choose };
		type = #[cut, fadeIn, fadeOut, xfade].choose; //TMP
		fork {
			5.wait;
			from.timeToPos(\end).debug("Time to transition");
		};
		type.switch(
			\oneshot, {
				mask = mask ?? { mask = self.oneshots.takeCell(filter) };
			},
			\bridge, {
				mask = mask ?? { mask = self.bridges.takeCell(filter) };
			}
		);
		self.transitions[type].run(from, to, mask);
	},

	testTransition: { |self, from, to, type, mask, fork=true|
		var filter = self.makeFilter(from, to);
		var transition = self.transitions[type];
		var func;

		// If oneshot or bridge, get the mask instance
		type.switch(
			\oneshot, {
				mask = mask ?? { mask = self.oneshots.takeCell(filter) };
			},
			\bridge, {
				mask = mask ?? { mask = self.bridges.takeCell(filter) };
			}
		);



		func = {
			from.load;
			to.load;
			from.duration.debug("From duration");
			mask !? (_.load);
			transition.calc(from, to, mask);
			from.getMarkerTime(\end).debug("end marker time");
			transition.fadeTime.debug("Fade time");
			transition.startOffset.debug("Start offset");
			from.play((from.getMarkerTime(\end) + transition.startOffset.min(0) - 5).debug("ffwd"));
			transition.func(from, to, mask);
			(transition.fadeTime ? 0).debug.wait;
		};

		if (fork) {
			self.testRoutine = func.fork;
			self.testCleanup = {
				from.free;
				to.free;
				mask.free;
			};
		} {
			func.forkIfNeeded;
		};

	},

	stopTransitionTest: { |self|
		self.testRoutine.stop;
		self.testCleanup;
	},

	types: { |self|
		self.transitions.keys.asArray.sort;
	},

	//This is a library of transitions.
	transitions: ().make({

		//Proto holds functions common to all transition envirs.
		var proto = (
			settings: (
				fadeBounds: [10.0, 25]
			),
			getFadeBounds: { |self, from, to|
				//Set max fade duration to 1/3 of either cell
				var fadeMax = from.getDuration.min(to.getDuration) * 0.33;
				//Scale fadeBounds so that max bounds value == fadeMax
				var bounds = self.settings.fadeBounds * (fadeMax / self.settings.fadeBounds[1]).min(1);
				//Return fadeBounds
				bounds
			},

			calcFadeTime: { |self, from, to|
				var bounds = self.getFadeBounds(from, to);
				self.fadeTime = bounds[0].rrand(bounds[1]);
				self.fadeTime
			},

			run: { |self ...args|
				self.calc(*args);
				self.func(*args);
			},

			forks: Set(),

			spawn: { |self, func|
				var routine = fork {
					func.value;
					1e-06.wait;
					self.forks.remove(routine);
				};
				self.forks.add(routine);
				routine;
			}
		);


		var make = { |env|
			env.proto_(proto);
		};

		// Too complicated, should be rethought/refactored at some point:
		// Each transitions has a `func` function, which plays the transition,
		// and a `calc` function, which calculates the `startOffset` and `fadeTime` variables.
		// This way, we can calculate values for a particular transition before it happens
		// for tests and stuff
		// For regular use, use the `run` wrapper method above
		// aargh
		~cut = make.((
			func: { |self, from, to|
				//FIXME: calculate time until end marker
				//Maybe let this be a part of cell
				from.timeToPos(\end, self.startOffset);
				from.waitForPos(\end, self.startOffset);
				to.play;
			},
			calc: { |self, from, to|
				self.startOffset = to.getMarkerTime(\start).neg
			}
		));

		~fadeIn = make.((
			func: { |self, from, to|
				from.waitForPos(\end, self.startOffset);
				to.fadeIn(self.fadeTime);
			},
			calc: { |self, from, to|
				self.calcFadeTime(from, to);
				self.startOffset = to.getMarkerTime(\start).neg
			}
		));

		~fadeOut = make.((
			func: { |self, from, to|
				from.waitForPos(\end, self.startOffset);
				from.fadeOut(self.fadeTime);
				to.play(nil, from.getQuant, from.clock);
			},
			calc: { |self, from, to|
				self.calcFadeTime(from, to);
				//Wait for entire fade until starting. This should be adjusted?
				self.startOffset = (self.fadeTime + to.getMarkerTime(\start)).neg
			}
		));

		~xfade = make.((
			func: { |self, from, to|
				from.waitForPos(\end, self.startOffset);
				from.fadeOut(self.fadeTime, -2);
				to.fadeIn(self.fadeTime, 2);
			},
			calc: { |self, from, to|
				self.calcFadeTime(from, to);
				self.startOffset = self.fadeTime.neg;
			}
		));

		~oneshot = make.((
			func: { |self, from, to, oneshot|
				var endTime;

				oneshot ?? { oneshot = self.oneshots.takeCell };

				//Spawn oneshot separately
				self.spawn({
					from.waitForPos(\end, oneshot.getMarkerTime(\start).neg);
					oneshot.play;
				});

				from.waitForPos(\end, self.startOffset);
				to.play;
			},
			calc: { |self, from, to, oneshot|
				//Calculate oneshot start->end duration, 0 by default
				self.startOffset = (oneshot.getMarkerTime(\end, false) ? 0) - oneshot.getMarkerTime(\start);
				//And subtract start marker
				self.startOffset = self.startOffset - to.timeToPos(\start);
				//Now endTime is an offset, which is negative if to[\start] is
				//greater than oneshot duration. Use that as offset to the
				//waiting time.
			}
		));

		~bridge = make.((
			func: { |self, from, to, bridge|

				bridge ?? { bridge = self.bridges.takeCell };
				//Spawn bridge separately
				self.spawn({
					from.waitForPos(\end, self.startOffset);
					bridge.play;
				});

				//Next cell always plays in sync with previous end
				from.waitForPos(\end);
				to.play;
				3.wait;
				bridge.fadeOut(bridge.timeToPos(\playEnd));

			},
			calc: { |self, from, to, bridge|
				self.startOffset = (bridge.getMarkerTime(\end, false) ?? {
					bridge.settings[\duration] * 0.5;
				}).neg;
			}
		));
	})
);

transitions;
