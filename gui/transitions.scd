{ |parent, transitions|
	var m = (
		transitions: transitions,
		current: nil,
		makeGui: { |self|
			var items = self.transitions.transitions.keys.asArray.sort;
			var view = View(parent).layout_(VLayout(
				StaticText().string_("Transitions"),
				ListView().items_(items).action_({ |v|
					self.current = items[v.value];
				}).valueAction_(0),
				nil
			).margins_(0, 5));

			view;
		};
	);
	transitions !? {
		m.makeGui
	};
}