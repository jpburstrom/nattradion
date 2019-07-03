var config = "../config.scd".loadRelative[0];
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

Fdef(\allSoundFiles, { |subdir=""|
	var files = List();
	PathName(config.assetPath +/+ subdir).filesDo { |file|
		if (file.extension == "wav") {
			files.add(file.absolutePath)
		};
	};
	files
});


Fdef(\resolveAssets, { |obj|
	var path;
	//TODO: move from Fdef, or find a way to throw error from within
	assetPath = assetPath ?? { File.realpath(config.assetPath) } ?? {
		warn("Couldn't resolve assetPath at %".format(config.assetPath));
		nil
	};
	obj.keysValuesChange { |k, v|
		Fdef(\resolveAssetPath).value(v);
	};

	obj
});

Fdef(\resolveAssetPath, { |v|
	var path = File.realpath((config.assetPath +/+ v));
	if (path.isNil) {
		Error("Couldn't find file at %".format(v)).throw;
	};
	path
});

Fdef(\randomDurationTemplate, { |path, minDur=0, maxDur, offset|
	var dur, rest=0;
	if (PathName(path).isRelativePath) {
		path = Fdef(\resolveAssetPath).value(path);
	};
	(
		path: path,
		startTime: {
			rest.rand;
		},
		duration: { |sf|
			if (maxDur.isNil) {
				maxDur =  sf.duration ;
			};
			dur = minDur.rrand(maxDur);
			rest = sf.duration - dur.value;
			//BIG HACK
			currentEnvironment.settings[\duration] = dur;
			dur;
		}
	);
});

Fdef(\setRandomBufferDuration, { |minDur, maxDur, offset|

	~template[\buffer].keysValuesChange({ |k, v|
		Fdef(\randomDurationTemplate).value(v, minDur, maxDur, offset);
	});

});

Fdef(\replaceBuffer, { |key, path|
	~addBuffer.(key, Fdef(\resolveAssetPath).value(path));
});