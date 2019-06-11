//updateme <-- Remove this line when editing

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'combat': "036 combat/combat.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
