
//TODO stems

Cell({

	~template[\buffer] = Fdef(\resolveAssets).value((
        /*
		 'fur_elise_piano': "062 für elise baklänges/stems/fur elise piano.wav",
		 'fur_elise_bas': "062 für elise baklänges/stems/fur elise bas.wav",
		 'fur_elise_drum': "062 für elise baklänges/stems/fur elise drum.wav",
         */
		 'fur_elise': "062 fur elise baklanges/fur elise.wav" 
	));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
