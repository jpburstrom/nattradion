var stream = Pn(Pgeom(1, 1.5, 64).wrap(1, 2)).asStream;
var radius = 250;
var ofs = 25;
var view = UserView(nil, Rect(0, 0, (radius * 2) + (ofs * 2), (radius * 2) + (ofs * 2)));
view.drawFunc = {
	10000.do { |i|
		var p = stream.next.postln;
		var deg = (p * 2pi);
		// var deg = 180;
		var r = radius - i;
		var w = 10;
		var x = (r * sin(deg)) + radius + ofs;
		var y = radius - (r * cos(deg)) + ofs;
		Pen.fillOval(Rect(x, y, w, w));
	}
};
view.front
