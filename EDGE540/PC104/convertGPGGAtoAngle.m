function angle = convertGPGGAtoAngle(gpgga)
    ang_Degrees = floor(gpgga/100);
    ang_Minutes = gpgga-ang_Degrees*100;
    angle = ang_Degrees+ang_Minutes/60;
return
