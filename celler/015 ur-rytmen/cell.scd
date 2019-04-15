thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 '015_ur-rytmen_bass-perc': "015 ur-rytmen/ur-rytmen stems/015 ur-rytmen bass-perc.wav",
		 '015_ur-rytmen_bagpipe': "015 ur-rytmen/ur-rytmen stems/015 ur-rytmen bagpipe.wav",
		 '015_ur-rytmen_shaker-ljud': "015 ur-rytmen/ur-rytmen stems/015 ur-rytmen shaker-ljud.wav" 
         */
		 '015_ur-rytmen': "015 ur-rytmen/015 ur-rytmen.wav",
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
