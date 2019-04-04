var config = "../config.scd".loadRelative[0].postln;
var assetPath;

Fdef(\wavList, { |sub, path|

	var out = ();

	path = path ? PathName(thisProcess.nowExecutingPath).folderName;
	path = sub !? { path +/+ sub };

	assetPath = assetPath ?? { File.realpath(config.assetPath) };
	path = File.realpath(config.assetPath +/+ path);
	if (path.notNil) {

		PathName(path).filesDo { |file|
			if (file.extension.toLower == "wav") {
				var key = file.fileNameWithoutExtension.toLower.tr(Char.space, $_).asSymbol;
				out[key] = file.asRelativePath(assetPath)
			};
		}

	} {
		"Path doesn't exist at %".format(config.assetPath).warn;
	};

	out;


});


Fdef(\writeWavList, { |...args|
	var out = Fdef(\wavList).value(*args);
	Document.current.selectedString = out.asCompileString.replace("," ",\n");
});

Fdef(\resolveAssets, { |obj|
	var path;
	assetPath = assetPath ?? { File.realpath(config.assetPath) };
	obj.keysValuesChange { |k, v|
		path = File.realpath((config.assetPath +/+ v));
		if (path.isNil) {
			"Couldn't find file at %".format(v).warn;
		};
		path
	};

	obj
});