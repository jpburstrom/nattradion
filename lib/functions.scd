var config = "../config.scd".loadRelative[0].postln;
var assetPath;

// Interpreter preprocessor, allowing an "/*EOF*/" string in a document
// to stop loading (useful for keeping test code etc, while still being able to load it as external file)
this.preProcessor = { arg str;
    var split = str.findRegexp("/\\*EOF\\*/\\s*$");
    if (split.size > 0) {
        str = str.keep(split[0][0])
    };
    str
};
//

Fdef.verbose = true;

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
	//TODO: move from Fdef, or find a way to throw error from within
	assetPath = assetPath ?? { File.realpath(config.assetPath) } ?? {
		warn("Couldn't resolve assetPath at %".format(config.assetPath));
		nil
	};
	obj.keysValuesChange { |k, v|
		path = File.realpath((config.assetPath +/+ v));
		if (path.isNil) {
			Error("Couldn't find file at %".format(v)).throw;
		};
		path
	};

	obj
});