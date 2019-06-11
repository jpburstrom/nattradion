//Library of transitions
var transitions = (

	oneshots: "cellBag.scd".loadRelative[0],
	bridges: "cellBag.scd".loadRelative[0],


	checkAddCell: { |self, cell|
		self.oneshots.checkAddCell(cell, \isOneshot);
		self.bridges.checkAddCell(cell, \isBridge);
	},

	removeCell: { |self, cell|
		self.oneshots.removeCell(cell);
		self.bridges.removeCell(cell);
	},

	clearAll: { |self|
		self.oneshots.clearAll;
		self.bridges.clearAll;
	},

	freeAll: { |self|
		self.transitions.forks.do(_.stop);
		self.transitions.forks.clear;
	},


	chooseTransition: { |self, from, to|
		var transit = #[cut, fadeIn, fadeOut, xfade].choose;
		self.spawn({
			self.transitions[transit].value(self.transitions, from, to)
		});
	},

	testTransition: { |self, from, to, type, mask|
		var transition = self.transitions[type];

		// If oneshot or bridge, get the mask instance
		type.switch(
			\oneshot, {
				mask = mask ?? { mask = self.oneshots.takeCell };
			},
			\bridge, {
				mask = mask ?? { mask = self.bridges.takeCell };
			}
		);


		fork {
			from.load;
			to.load;
			mask !? (_.load);
			transition.calc(from, to, mask).postln;
			from.play((from.getMarkerTime(\end) + transition.startOffset.min(0) - 5).postln);
			transition.func(from, to, mask);
		}
	},


	//This is a library of transitions.
	transitions: ().make({

		//Proto holds functions common to all transition envirs.
		var proto = (
			settings: (
				fadeBounds: [5.0, 20]
			),
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
				from.timeToPos(\end, self.startOffset).postln;
				from.waitForPos(\end, self.startOffset);
				"okok".postln;
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
				self.startOffset = self.fadeTime.neg;
			}
		));

		~fadeOut = make.((
			func: { |self, from, to|
				var time;
				time = self.fadeTime;
				from.waitForPos(\end, self.startOffset);
				from.fadeOut(time);
				"FIXME: Time for next cell start".warn;
				time.wait; //FIXME: Find a good timing for when to start `to`
				to.play(nil, from.getQuant, from.clock);
			},
			calc: { |self, from, to|
				self.calcFadeTime(from, to);
				self.startOffset = self.fadeTime - to.getMarkerTime(\start)
			}
		));

		~xfade = make.((
			func: { |self, from, to|
				var time = self.calc;
				from.waitForPos(\end, self.startOffset);
				from.fadeOut(time);
				to.fadeIn(time);
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
