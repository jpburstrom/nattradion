// Temporary radio

s.waitForBoot {
    
    {
        SinOsc.ar({ LFNoise2.kr(1).exprange(200, 800) }.dup) * 0.1
    }.play

};
