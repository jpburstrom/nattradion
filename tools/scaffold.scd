var src = "../config.scd".loadRelative[0].assetPath;
var dest = "../celler".resolveRelative;
var template = File.readAllString("../mall/cell.scd".resolveRelative);

var copyFile = { |src, dest|
	var out = template.replace("%bufferTemplate%", wavList.(src));
	File.use(dest, "w", { |f|
		f.write(out);
	});
};

var updateme = { |dest|
	var str = File.readAllString(dest);
	(str.find("//updateme") == 0);
};

var wavList = { |path|

	var out = ();

	path = File.realpath(path);
	if (path.notNil) {

		PathName(path).filesDo { |file|
			if (file.extension.toLower == "wav") {
				var key = file.fileNameWithoutExtension.toLower.tr(Char.space, $_).asSymbol;
				out[key] = file.postln.asRelativePath(src.postln)
			};
		}

	} {
		"Path doesn't exist at %".format(src).warn;
	};

	out = out.asCompileString.replace(",", ",\n\t\t")
	.replace("(", "(\n\t\t")
	.replace(")", "\n\t)");

	out;

};

PathName(src).entries.do { |entry|
	if (entry.isFolder) {
		var folderName = entry.folderName;
		var destFolder = dest +/+ folderName;
		var destFile = destFolder +/+ "cell.scd";
		var dirCreated = File.mkdir(destFolder);


		if (dirCreated or: { File.exists(destFile).not }) {
			copyFile.(entry.fullPath, destFile);
		} {
			if (updateme.(destFile)) {
				File.delete(destFile);
				copyFile.(entry.fullPath, destFile);
			};
		}


	};
};