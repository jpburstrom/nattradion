
Cell({

//tsv
	~init = {
		~updateSettings.((
			transitions: [\fade, \xfade, \cut, \bridge, \oneshot]
		));
	};
//end tsv

    //TODO: Choose

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'tretakt_treklang_sam_version': "023 tretakt treklang/tretakt treklang SAM version.wav",
		 '023_tretakt_treklang_kat_edition_loop': "023 tretakt treklang/023 tretakt treklang_KAT edition_loop.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
