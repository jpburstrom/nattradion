Fdef(\importFind, {
	"*.scd".resolveRelative.pathMatch.do { |path|
		if (path != thisProcess.nowExecutingPath) {
			Document.current.selectedString_("\"%\".resolveRelative.load;\n".format(path.basename));
			Document.open(path)
		}
	}
})
