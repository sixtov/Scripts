function S = genAircraftLocationStructure(ID,Lat,Lon,Alt,Vx,Vy,Vz,oFlag,type)
    S.hdr = uint8(97);
    S.msg_type = uint8(0);
    S.msg_length = uint16(64);
    S.ID = uint8(zeros(1,8));
    N = min(length(ID),8);
    S.ID(1:N) = uint8(ID(1:N));
    S.Latitude = Lat;     %Degrees
    S.Longitude = Lon;    %Degrees
    S.Elevation = Alt;    %Feet
    S.Vx = Vx;
    S.Vy = Vy;
    S.Vz = Vz;
    S.ownshipFlag = uint8(oFlag);
    S.aircraftType = uint8(type);
    S.chkSumHi = uint8(0);
    S.chkSumLo = uint8(0);
return
