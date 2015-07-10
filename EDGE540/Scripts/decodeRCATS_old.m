function RCATS = decodeRCATS(RCATSlog)
session = 1;
oPacket = 0;
froot = RCATSlog(1:find(RCATSlog=='.')-1);
fid=fopen(RCATSlog);
if fid == -1
    disp(sprintf('Could not open ''%s''',RCATSlog))
    return
end
RCATS = [];
idx = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    if ~isempty(tline)
        %disp(tline)
        if tline(1) == 'T'
            ldata = sscanf(tline,'TSP%dA%fB%fC%dD%dE%fF%fG%fH%fI%fJ%fK%dL%f')';
            if length(ldata) == 13
                nPacket = ldata(1);
                if nPacket < oPacket
                    saveSession(froot,session,RCATS);
                    session = session+1;
                    RCATS = [];
                    idx = 0;
                end
                oPacket = nPacket;
                idx = idx+1;
                RCATS.packet(idx,1)      = ldata(1);
                RCATS.temp1(idx,1)       = ldata(2);
                RCATS.temp2(idx,1)       = ldata(3);
                RCATS.rpm(idx,1)         = ldata(4);
                RCATS.altitude(idx,1)    = ldata(5);
                RCATS.ias(idx,1)         = ldata(6);
                RCATS.voltage(idx,1)     = ldata(7);
                RCATS.cgLoad(idx,1)      = ldata(8);
                RCATS.current(idx,1)     = ldata(9);
                RCATS.sync(idx,1)        = ldata(10);
                RCATS.io2(idx,1)         = ldata(11);
                RCATS.alt_off(idx,1)     = ldata(12);
                RCATS.ambient(idx,1)     = ldata(13);
                RCATS.hour(idx,1)        = 0;
                RCATS.min(idx,1)         = 0;
                RCATS.sec(idx,1)         = 0;
                RCATS.lat(idx,1)         = 0;
                RCATS.latDir(idx,1)      = 'N';
                RCATS.lon(idx,1)         = 0;
                RCATS.lonDir(idx,1)      = 'W';
                RCATS.q(idx,1)           = 0;
                RCATS.numSat(idx,1)      = 0;
                RCATS.hzDil(idx,1)       = 0;
                RCATS.alt(idx,1)         = 0;
                RCATS.altUnits(idx,1)    = 'M';
                RCATS.geodHeight(idx,1)  = 0;
                RCATS.geodUnits(idx,1)   = 'M';
                RCATS.diffDataAge(idx,1) = 0;
                RCATS.stationID(idx,1)   = 0;
                RCATS.trueCourse(idx,1)  = 0;
                RCATS.trueCourseL(idx,1) = 'T';
                RCATS.magCourse(idx,1)   = 0;
                RCATS.magCourseL(idx,1)  = 'M';
                RCATS.gSpeedKnots(idx,1) = 0;
                RCATS.gSpeedKnotsU(idx,1)= 'N';
                RCATS.gSpeedKPH(idx,1)   = 0;
                RCATS.gSpeedKPHU(idx,1)  = 'K';
                RCATS.mode(idx,1)        = 'E';
            end
        else
            if tline(1) == '$'
                disp(tline)
                NMEA_Code = tline(1:6);
                switch(NMEA_Code)
                    case '$GPGGA'
                        GPS = parseGPGGA(tline);
                        if idx>0
                            if GPS.q == 1
                                RCATS.hour(idx,1)        = GPS.hour;
                                RCATS.min(idx,1)         = GPS.min;
                                RCATS.sec(idx,1)         = GPS.sec;
                                RCATS.lat(idx,1)         = GPS.lat;
                                RCATS.latDir(idx,1)      = GPS.latDir;
                                RCATS.lon(idx,1)         = GPS.lon;
                                RCATS.lonDir(idx,1)      = GPS.lonDir;
                                RCATS.q(idx,1)           = GPS.q;
                                RCATS.numSat(idx,1)      = GPS.numSat;
                                RCATS.hzDil(idx,1)       = GPS.hzDil;
                                RCATS.alt(idx,1)         = GPS.alt;
                                RCATS.altUnits(idx,1)    = GPS.altUnits;
                                RCATS.geodHeight(idx,1)  = GPS.geodHeight;
                                RCATS.geodUnits(idx,1)   = GPS.geodUnits;
                                RCATS.diffDataAge(idx,1) = GPS.diffDataAge;
                                RCATS.stationID(idx,1)   = GPS.stationID;
                            end
                        end
                        
                    case '$GPVTG'
                        GPS = parseGPVTG(tline);
                        if idx>0
                            if RCATS.q(idx,1) == 1
                                RCATS.trueCourse(idx,1)  = GPS.trueCourse;
                                RCATS.trueCourseL(idx,1) = GPS.trueCourseL;
                                RCATS.magCourse(idx,1)   = GPS.magCourse;
                                RCATS.magCourseL(idx,1)  = GPS.magCourseL;
                                RCATS.gSpeedKnots(idx,1) = GPS.gSpeedKnots;
                                RCATS.gSpeedKnotsU(idx,1)= GPS.gSpeedKnotsU;
                                RCATS.gSpeedKPH(idx,1)   = GPS.gSpeedKPH;
                                RCATS.gSpeedKPHU(idx,1)  = GPS.gSpeedKPHU;
                                RCATS.mode(idx,1)        = GPS.mode;
                            end
                        end
                        
                    otherwise
                        disp('Unparsed command')
                end
            end
        end
    end
end
RCATS = saveSession(froot,session,RCATS);
fclose(fid);
return

function RCATS = saveSession(froot,session,RCATS)
    idx = find(RCATS.q);
    if ~isempty(idx)
        RCATS = genTime(RCATS,idx);
        RCATS = genLatLon(RCATS,idx);
    end
    save(sprintf('%s_Session%d.mat',froot,session),'RCATS');
return


function RCATS = genTime(RCATS,idx)
    RCATS.time = zeros(size(RCATS.q));
    M = length(RCATS.time);
    RCATS.time(idx) = ((RCATS.hour(idx)*60)+RCATS.min(idx))*60+RCATS.sec(idx);
    for i=idx(1)-1:-1:1
        RCATS.time(i) = RCATS.time(idx(1))-0.1*(RCATS.packet(idx(1))-RCATS.packet(i));
    end
    N = length(idx);
    for i=idx(N)+1:M
        RCATS.time(i) = RCATS.time(idx(N))-0.1*(RCATS.packet(idx(N))-RCATS.packet(i));
    end
    for j=1:N-1
        for i=idx(j)+1:idx(j+1)-1
            RCATS.time(i) = RCATS.time(idx(j))-0.1*(RCATS.packet(idx(j))-RCATS.packet(i));
        end
    end
return
        
        
function RCATS = genLatLon(RCATS,idx)
    HOLD_GPS_DATA = 1;
    M = length(RCATS.lat);
    %% Back fill first part of data with first known valid GPS data
    for i=idx(1)-1:-1:1
        RCATS.lat(i)         = RCATS.lat(idx(1));
        RCATS.lon(i)         = RCATS.lon(idx(1));
        RCATS.alt(i)         = RCATS.alt(idx(1));
        RCATS.gSpeedKPH(i)   = RCATS.gSpeedKPH(idx(1));
        RCATS.hzDil(i)       = RCATS.hzDil(idx(1));
        RCATS.geodHeight(i)  = RCATS.geodHeight(idx(1));
        RCATS.diffDataAge(i) = RCATS.diffDataAge(idx(1));
        RCATS.trueCourse(i)  = RCATS.trueCourse(idx(1));
        RCATS.magCourse(i)   = RCATS.magCourse(idx(1));
        RCATS.gSpeedKnots(i) = RCATS.gSpeedKnots(idx(1));
        RCATS.latDir(i)      = 'N';
        RCATS.lonDir(i)      = 'W';
        RCATS.altUnits(i)    = 'M';
        RCATS.geodUnits(i)   = 'M';
        RCATS.trueCourseL(i) = 'T';
        RCATS.magCourseL(i)  = 'M';
        RCATS.gSpeedKnotsU(i)= 'N';
        RCATS.gSpeedKPHU(i)  = 'K';
        RCATS.mode(i)        = 'E';
        RCATS.numSat(i)      = RCATS.numSat(idx(1));
        RCATS.stationID(i)   = RCATS.stationID(idx(1));
    end
    N = length(idx);
    %% Back fill last part of data with last known valid GPS data
    for i=idx(N)+1:M
        RCATS.lat(i)         = RCATS.lat(idx(N));
        RCATS.lon(i)         = RCATS.lon(idx(N));
        RCATS.alt(i)         = RCATS.alt(idx(N));
        RCATS.gSpeedKPH(i)   = RCATS.gSpeedKPH(idx(N));
        RCATS.hzDil(i)       = RCATS.hzDil(idx(N));
        RCATS.geodHeight(i)  = RCATS.geodHeight(idx(N));
        RCATS.diffDataAge(i) = RCATS.diffDataAge(idx(N));
        RCATS.trueCourse(i)  = RCATS.trueCourse(idx(N));
        RCATS.magCourse(i)   = RCATS.magCourse(idx(N));
        RCATS.gSpeedKnots(i) = RCATS.gSpeedKnots(idx(N));
        RCATS.latDir(i)      = 'N';
        RCATS.lonDir(i)      = 'W';
        RCATS.altUnits(i)    = 'M';
        RCATS.geodUnits(i)   = 'M';
        RCATS.trueCourseL(i) = 'T';
        RCATS.magCourseL(i)  = 'M';
        RCATS.gSpeedKnotsU(i)= 'N';
        RCATS.gSpeedKPHU(i)  = 'K';
        RCATS.mode(i)        = 'E';
        RCATS.numSat(i)      = RCATS.numSat(idx(N));
        RCATS.stationID(i)   = RCATS.stationID(idx(N));
    end
    for j=1:N-1
        if ~HOLD_GPS_DATA  %% Hold last GPS point
            %% Used for interpolating GPS data
            latSlope = (RCATS.lat(idx(j+1))-RCATS.lat(idx(j)))             / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            lonSlope = (RCATS.lon(idx(j+1))-RCATS.lon(idx(j)))             / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            altSlope = (RCATS.alt(idx(j+1))-RCATS.alt(idx(j)))             / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            gSpSlope = (RCATS.gSpeedKPH(idx(j+1))-RCATS.gSpeedKPH(idx(j))) / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            hzDSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            geoSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            difSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            truSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            magSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
            gNsSlope = (RCATS.(idx(j+1))-RCATS.(idx(j)))                   / (RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
        end
        for i=idx(j)+1:idx(j+1)-1
            if HOLD_GPS_DATA  %% Hold last GPS point
                RCATS.q(i)           = 3;
                RCATS.lat(i)         = RCATS.lat(idx(j))         ; %%+ latSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.lon(i)         = RCATS.lon(idx(j))         ; %%+ lonSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.alt(i)         = RCATS.alt(idx(j))         ; %%+ altSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.gSpeedKPH(i)   = RCATS.gSpeedKPH(idx(j))   ; %%+ gSpSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.hzDil(i)       = RCATS.hzDil(idx(j))       ; %%+ hzDSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.geodHeight(i)  = RCATS.geodHeight(idx(j))  ; %%+ geoSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.diffDataAge(i) = RCATS.diffDataAge(idx(j)) ; %%+ difSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.trueCourse(i)  = RCATS.trueCourse(idx(j))  ; %%+ truSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.magCourse(i)   = RCATS.magCourse(idx(j))   ; %%+ magSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.gSpeedKnots(i) = RCATS.gSpeedKnots(idx(j)) ; %%+ gNsSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.latDir(i)      = 'N';
                RCATS.lonDir(i)      = 'W';
                RCATS.altUnits(i)    = 'M';
                RCATS.geodUnits(i)   = 'M';
                RCATS.trueCourseL(i) = 'T';
                RCATS.magCourseL(i)  = 'M';
                RCATS.gSpeedKnotsU(i)= 'N';
                RCATS.gSpeedKPHU(i)  = 'K';
                RCATS.mode(i)        = 'E';
                RCATS.numSat(i)      = RCATS.numSat(idx(j));
                RCATS.stationID(i)   = RCATS.stationID(idx(j));
            else  %% Interpolate
                RCATS.q(i)           = 3;
                RCATS.lat(i)         = RCATS.lat(idx(j))         + latSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.lon(i)         = RCATS.lon(idx(j))         + lonSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.alt(i)         = RCATS.alt(idx(j))         + altSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.gSpeedKPH(i)   = RCATS.gSpeedKPH(idx(j))   + gSpSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.hzDil(i)       = RCATS.hzDil(idx(j))       + hzDSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.geodHeight(i)  = RCATS.geodHeight(idx(j))  + geoSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.diffDataAge(i) = RCATS.diffDataAge(idx(j)) + difSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.trueCourse(i)  = RCATS.trueCourse(idx(j))  + truSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.magCourse(i)   = RCATS.magCourse(idx(j))   + magSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.gSpeedKnots(i) = RCATS.gSpeedKnots(idx(j)) + gNsSlope*(RCATS.packet(i)-RCATS.packet(idx(j)));
                RCATS.latDir(i)      = 'N';
                RCATS.lonDir(i)      = 'W';
                RCATS.altUnits(i)    = 'M';
                RCATS.geodUnits(i)   = 'M';
                RCATS.trueCourseL(i) = 'T';
                RCATS.magCourseL(i)  = 'M';
                RCATS.gSpeedKnotsU(i)= 'N';
                RCATS.gSpeedKPHU(i)  = 'K';
                RCATS.mode(i)        = 'E';
                RCATS.numSat(i)      = RCATS.(idx(j));
                RCATS.stationID(i)   = RCATS.(idx(j));
            end
        end
    end
return
        
        
function GPS = parseGPGGA(tline)
    GPS = [];
    GPS.q = 0;
    GPS.diffDataAge = 0;
    GPS.stationID   = 0;
    GPS.numSat = 0;
    GPS.hzDil = 0;
    GPS.alt = 0;
    GPS.altUnits = 'M';
    GPS.geodHeight = 0;
    GPS.geodUnits = 'M';
    GPS.diffDataAge = 0;
    GPS.stationID = 0;
    
    % $GPGGA
    % Global Positioning System Fix Data 
    % 
    % eg1. $GPGGA,170834   ,4124.8963,N,08151.6838,W,1,05,1.5,280.2,M,-34.0,M,,,*75 
    % Name  Example Data  Description  
    % Sentence Identifier $GPGGA Global Positioning System Fix Data 
    % Time 170834 17:08:34 UTC 
    % Latitude 4124.8963, N 41d 24.8963' N or 41d 24' 54" N 
    % Longitude 08151.6838, W 81d 51.6838' W or 81d 51' 41" W 
    % Fix Quality:
    % - 0 = Invalid
    % - 1 = GPS fix
    % - 2 = DGPS fix 1 Data is from a GPS fix 
    % Number of Satellites 05 5 Satellites are in view 
    % Horizontal Dilution of Precision (HDOP) 1.5 Relative accuracy of horizontal position 
    % Altitude 280.2, M 280.2 meters above mean sea level 
    % Height of geoid above WGS84 ellipsoid -34.0, M -34.0 meters 
    % Time since last DGPS update blank No last update 
    % DGPS reference station id blank No station id 
    % Checksum *75 Used by program to check for transmission errors 
    % 
    % 
    % Courtesy of Brian McClure, N8PQI. 
    % 
    % Global Positioning System Fix Data. Time, position and fix related data for a GPS receiver. 
    % 
    % eg2. $GPGGA,hhmmss.ss,ddmm.mmm,a,dddmm.mmm,b,q,xx,p.p,a.b,M,c.d,M,x.x,nnnn 
    % 
    % $GPGGA,hhmmss.ss,ddmm.mmm,a,dddmm.mmm,b,q,xx,p.p,a.b,M,c.d,M,x.x,nnnn 
    % $GPGGA,170834,4124.8963,N,08151.6838,W,1,05,1.5,280.2,M,-34.0,M,,,*75 

    tokIdx = [0 find(tline==',') length(tline)+1];
    tokSize = diff(tokIdx)-1;
    numTok = length(tokSize);
    for i=1:numTok
        if tokSize(i)>0
            myTok = tline(tokIdx(i)+1:tokIdx(i)+tokSize(i));
            switch(i)
                case 1  % $GPGGA header
                case 2  % hhmmss.ss = UTC of position 
                    num = sscanf(myTok,'%f');
                    GPS.hour = floor(num/10000);
                    GPS.min  = floor((num-GPS.hour*10000)/100);
                    GPS.sec = num-GPS.hour*10000-GPS.min*100;
                    %if GPS.sec > 59
                        disp(sprintf('  Time %s : %.2f = %d:%d:%.2f',myTok,num,GPS.hour,GPS.min,GPS.sec))
                    %end
                case 3  % ddmm.mmm = latitude of position
                    num = sscanf(myTok,'%f');
                    latd = floor(num/100);
                    latm = num-latd*100;
                    GPS.lat  = latd+latm/60;
                case 4  % a = N or S, latitutde hemisphere
                    GPS.latDir = sscanf(myTok,'%c');
                case 5  % dddmm.mmm = longitude of position
                    num = sscanf(myTok,'%f');
                    lond = floor(num/100);
                    lonm = num-lond*100;
                    GPS.lon  = lond+lonm/60;
                case 6  % b = E or W, longitude hemisphere 
                    GPS.lonDir = sscanf(myTok,'%c');
                case 7  % q = GPS Quality indicator (0=No fix, 1=Non-differential GPS fix, 2=Differential GPS fix, 6=Estimated fix)
                    GPS.q = sscanf(myTok,'%d');
                case 8  % xx = number of satellites in use 
                    GPS.numSat = sscanf(myTok,'%d');
                case 9  % p.p = horizontal dilution of precision 
                    GPS.hzDil = sscanf(myTok,'%f');
                case 10 % a.b = Antenna altitude above mean-sea-level
                    GPS.alt = sscanf(myTok,'%f');
                case 11 % M = units of antenna altitude, meters 
                    GPS.altUnits = sscanf(myTok,'%c');
                case 12 % c.d = Geoidal height
                    GPS.geodHeight = sscanf(myTok,'%f');
                case 13 % M = units of geoidal height, meters 
                    GPS.geodUnits = sscanf(myTok,'%c');
                case 14 % x.x = Age of Differential GPS data (seconds since last valid RTCM transmission) 
                    GPS.diffDataAge = sscanf(myTok,'%f');
                case 15 % nnnn = Differential reference station ID, 0000 to 1023 
                    GPS.stationID = sscanf(myTok(2:length(myTok)),'%d');
                otherwise
                    disp(sprintf('%s - Unknown GPS token',myTok))
            end
        end
    end
%     [hh mm ss latd latm latD lond lonm lonD q nSat hDilution alt altU geodHeight geodU dgpsAge stationID] = ...
%     sscanf(tline,'$GPGGA,%2.2d%2.2d%5.2f,%2.2d%7.4f,%c,%3.3d%7.4f,%c,%d,%d,%f,%f,%c,%f,%c,%f,%d')';
    % $GPGGA,182652.00,3701.2141,N,07635.3237,W,1,05,2.38,00009,M,-034,M,,*5A
return


function GPS = parseGPVTG(tline)
    GPS = [];
    GPS.trueCourse = 0;
    GPS.trueCourseL = 'T';
    GPS.magCourse = 0;
    GPS.magCourseL = 'M';
    GPS.gSpeedKnots = 0;
    GPS.gSpeedKnotsU = 'N';
    GPS.gSpeedKPH = 0;
    GPS.gSpeedKPHU = 'K';
    
    % $GPVTG
    % Track Made Good and Ground Speed. 
    % 
    % eg1. $GPVTG,360.0,T,348.7,M,000.0,N,000.0,K*43
    % eg2. $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K*41
    % 
    %            054.7,T      True course made good over ground, degrees
    %            034.4,M      Magnetic course made good over ground, degrees
    %            005.5,N      Ground speed, N=Knots
    %            010.2,K      Ground speed, K=Kilometers per hour
    % 
    % eg3. for NMEA 0183 version 3.00 active the Mode indicator field
    %      is added at the end
    %      $GPVTG,054.7,T,034.4,M,005.5,N,010.2,K,A*53
    %            A            Mode indicator (A=Autonomous, D=Differential,
    %                         E=Estimated, N=Data not valid)

    tokIdx = [0 find(tline==',') length(tline)+1];
    tokSize = diff(tokIdx)-1;
    numTok = length(tokSize);
    GPS.mode = 0;
    for i=1:numTok
        if tokSize(i)>0
            myTok = tline(tokIdx(i)+1:tokIdx(i)+tokSize(i));
            switch(i)
                case 1  % $GPVTG header
                case 2  % True course made good over ground, degrees
                    GPS.trueCourse = sscanf(myTok,'%f');
                case 3  % True course made good over ground, degrees
                    GPS.trueCourseL = sscanf(myTok,'%c');
                case 4  % Magnetic course made good over ground, degrees
                    GPS.magCourse = sscanf(myTok,'%f');
                case 5  % Magnetic course made good over ground, degrees
                    GPS.magCourseL = sscanf(myTok,'%c');
                case 6  % Ground speed
                    GPS.gSpeedKnots = sscanf(myTok,'%f');
                case 7  % N=Knots
                    GPS.gSpeedKnotsU = sscanf(myTok,'%c');
                case 8  % Ground speed
                    GPS.gSpeedKPH = sscanf(myTok,'%f');
                case 9  % K=Kilometers per hour
                    GPS.gSpeedKPHU = sscanf(myTok,'%c');
                case 10 % Mode indicator (A=Autonomous, D=Differential,
                        %                 E=Estimated, N=Data not valid)
                    GPS.mode = myTok(1);
                otherwise
                    disp(sprintf('%s - Unknown GPS token',myTok))
            end
        end
    end
%     [hh mm ss latd latm latD lond lonm lonD q nSat hDilution alt altU geodHeight geodU dgpsAge stationID] = ...
%     sscanf(tline,'$GPGGA,%2.2d%2.2d%5.2f,%2.2d%7.4f,%c,%3.3d%7.4f,%c,%d,%d,%f,%f,%c,%f,%c,%f,%d')';
    % $GPGGA,182652.00,3701.2141,N,07635.3237,W,1,05,2.38,00009,M,-034,M,,*5A
return
