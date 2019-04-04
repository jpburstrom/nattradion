//updateme <-- Remove this line when editing
thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'trumsolo_endast_trummor': "006 trumsolo/trumsolo stems/Trumsolo endast trummor.wav",
		 'trumsolo_kompband': "006 trumsolo/trumsolo stems/Trumsolo kompband.wav"
	));


}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName).play

