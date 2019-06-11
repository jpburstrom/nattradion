
Cell({

    ~template[\buffer] = Fdef(\resolveAssets).value((
        'blues_deconstructed_harmony': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed harmony.wav",
        //'blues_deconstructed': "055 blues deconstructed/blues deconstructed.wav",
        'blues_deconstructed_annoying_guy': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed annoying guy.wav",
        'blues_deconstructed_that_linn_drum_beat': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed THAT linn drum beat.wav",
        'blues_deconstructed_random_shuffling': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed random shuffling.wav",
        'blues_deconstructed_synthist_at_wrong_gig': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed synthist at wrong gig.wav",
        'blues_deconstructed_drum_theme': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed drum theme.wav",
        'blues_deconstructed_organ_freely_interpret': "055 blues deconstructed/BLUES DECONSTRUCTED/blues deconstructed organ freely interpret.wav" 
    ));

}, \disk).name_(PathName(thisProcess.nowExecutingPath).folderName)
