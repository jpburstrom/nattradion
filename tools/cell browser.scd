~basedir = "/Users/johannes/htdocs/nattradion.test/src/posts/";
~cells = ();

(
PathName(~basedir).folders.do { |folder|
	var key = folder.folderName.asSymbol;
	var path = folder.absolutePath;
	folder.filesDo { |file|
		if (file.fileName == "info.txt") {
			var json = File.readAllString(file.absolutePath.postln);
			//json = json.split(Char.nl);
			//json.pop;
			//json = json[1..].join(Char.nl);
			var out = ();
			json = json.parseYAML.keysValuesDo({ |k, v|
				out[k.asSymbol] = v;
			});
			out['path'] = path;
			~cells[key] = out;
		};
	};
};
)

(
var win = Window.new.front.layout_(HLayout());
var list = ListView(win);
var info = TextView(win);

list.items = ~cells.keys.asArray.sort;
list.action = { |view|
	var index = view.value;
	var key = view.items[index].asSymbol;
	var out = List();
	~cells[key].keysValuesDo { |k, v|
		out.add("%: %".format(k, v));
	};
	info.string = out.join(Char.nl);
};
)