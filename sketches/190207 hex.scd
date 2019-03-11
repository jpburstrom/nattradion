~radius = 7;
~cells = ((1..~radius) * 6).sum + 1;

//
~cell = (
	//Hex coordinate
	hex: (
		x: -4,
		y: 2
	),
	// Internal cell id
	id: 172,
	name: "Cell name",
	//more metadata...
);

MHexPad

//Walk in forward direction, not turning more than 120 degrees
~walk = Routine({
	var angle = 30;
	loop {
		angle = angle + [-60, 0, 60].choose;
		angle.yield;
	}
});

(
//Visualize walker
//TODO: grid-based walking
UserView(nil, Rect(0, 0, 800, 800)).drawFunc_({ |w|
	var max = w.bounds.extent;
	var pos = w.bounds.center;
	w.background = Color.white;
	Pen.moveTo(pos);
	10.do {
		pos = (pos + Point(0, 1).rotate(~walk.value.degrad)) % max;
		pos.postln;
		Pen.addRect(Rect(pos.x, pos.y, 7, 7));
	};
	Pen.fill;
}).front
)
Point(0, 20).rotate(0.785)

Point(0, -20) % Point(400, 400)