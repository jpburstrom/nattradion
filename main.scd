"lib/*".resolveRelative.pathMatch.do(_.load);
~main = Cell({

	~init = { |self|
		//This is a temporary fix, call super
		self.parent[\init].value;

		~cells = "cells.scd".resolveRelative.load;
		~playlist = "playlist.scd".resolveRelative.load;
		self.addChildren(\cells, ~cells, \playlist, ~playlist);
	};

	~load = {
		~cells.play; //Set up routing
	};

	~play = {
		~playlist.play;
	};

}).name_("Main"); //FIXME: Add blank/something player type


~main.play
