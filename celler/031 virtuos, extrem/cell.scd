//updateme <-- Remove this line when editing
thisProcess.nowExecutingPath.debug("TODO");

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
		 'virtuos_extrem_gtr': "031 virtuos,
		 extrem/virtuos stems/virtuos extrem gtr.wav",
		 'virtuos_extrem_drums': "031 virtuos,
		 extrem/virtuos stems/virtuos extrem drums.wav",
		 'virtuos_extrem_bas': "031 virtuos,
		 extrem/virtuos stems/virtuos extrem bas.wav",
		 'virtuos_extrem': "031 virtuos,
		 extrem/virtuos extrem.wav",
		 
  'virtuos_extrem_keys': "031 virtuos,
		 extrem/virtuos stems/virtuos extrem keys.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
