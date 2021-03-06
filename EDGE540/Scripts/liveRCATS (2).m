% Uses live RCATS serial stream
function [RCATS GPS] = liveRCATS()
    global s1;
    froot = '.\';
    disp('DECODE STARTS:')
    session = 1;
    disp(sprintf('SESSION %d',session))
    oPacket = 0;
    nPacket = 0;

    RCATS = emptyRCATS();
    GPS = emptyGPS();
    RCATS_DATA = 'TSP';
    GPS_DATA = '$GP';
    NEW_SESSION = '>>>';    %' >>'; % first character is a line feed
    
    % To construct a serial port object:
    s1 = serial('COM1');
    % To connect the serial port object to the serial port:
    fopen(s1)

    % To query the device.
    while length(RCATS.time)<1000
        tline = fgetl(s1);
        if ~ischar(tline), break, end
        if ~isempty(tline)
            %disp(tline)
            k = strfind(tline,'TSP');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            k = strfind(tline,'$GPGGA');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            k = strfind(tline,'>>>');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            
            nChars = min(length(tline),3);
            switch(tline(1:nChars))
                case RCATS_DATA(1:nChars)
                    [RCATS nPacket] = parseRCATS(tline,RCATS);
                    if nPacket < oPacket
                        [RCATS GPS] = saveSession(froot,session,RCATS,GPS,1);
                        session = session+1;
                        %oPacket = 0;
                        disp(sprintf('SESSION %d',session))
                    end
                    oPacket = nPacket;
                case GPS_DATA(1:nChars)
                    disp(tline)
                    NMEA_Code = tline(1:6);
                    switch(NMEA_Code)
                        case '$GPGGA'
                            GPS = parseGPS(tline,GPS,nPacket);
%                             nGPS = length(GPS.time);
%                             nRCATS = length(RCATS.time);
%                             if nGPS>0 && GPS.q(nGPS)==1
%                                 RCATS.time(nRCATS) = GPS.time(nGPS);
%                             end
                        case '$GPVTG'
                            disp(tline)
                        otherwise
                            disp('Unparsed command')
                    end
                case NEW_SESSION(1:nChars)
                    %disp(tline)
                    SESSION_Code = tline(5:7);
                    switch(SESSION_Code)
                        case 'NEW'
                            if ~isempty(RCATS.time) || ~isempty(GPS.time)
                                [RCATS GPS] = saveSession(froot,session,RCATS,GPS,1);
                                session = session+1;
                                oPacket = 0;
                                disp(sprintf('SESSION %d',session))
                            end
                        case 'RCA'
                            disp(tline)
                        otherwise
                            disp('Unparsed command')
                    end
                otherwise
                    disp(sprintf('Invalid Line: %s',tline))
            end
        end
    end

    % To disconnect the serial port object from the serial port.
    fclose(s1); 
    
    if ~isempty(RCATS.time) || ~isempty(GPS.time)
        [RCATS GPS] = saveSession(froot,session,RCATS,GPS,0);
    end
return
    

function [RCATS GPS] = decodeRCATS(RCATSlog)
global fid;
    disp('DECODE STARTS:')
    session = 1;
    disp(sprintf('SESSION %d',session))
    oPacket = 0;
    nPacket = 0;
    froot = RCATSlog(1:find(RCATSlog=='.')-1);
    fid=fopen(RCATSlog);
    if fid == -1
        disp(sprintf('Could not open ''%s''',RCATSlog))
        return
    end
    RCATS = emptyRCATS();
    GPS = emptyGPS();
    RCATS_DATA = 'TSP';
    GPS_DATA = '$GP';
    NEW_SESSION = '>>>';    %' >>'; % first character is a line feed
    
    while 1
        tline = fgetl(fid);
        %disp(tline)
        if ~ischar(tline),   break,   end
        if ~isempty(tline)
            
            k = strfind(tline,'TSP');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            k = strfind(tline,'$GPGGA');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            k = strfind(tline,'>>>');
            if (~isempty(k) && length(k)==1)
                tline = tline(k:length(tline));
            end
            
            nChars = min(length(tline),3);
            switch(tline(1:nChars))
                case RCATS_DATA(1:nChars)
                    [RCATS nPacket] = parseRCATS(tline,RCATS);
                    if nPacket < oPacket
                        [RCATS GPS] = saveSession(froot,session,RCATS,GPS,1);
                        session = session+1;
                        %oPacket = 0;
                        disp(sprintf('SESSION %d',session))
                    end
                    oPacket = nPacket;
                case GPS_DATA(1:nChars)
                    disp(tline)
                    NMEA_Code = tline(1:6);
                    switch(NMEA_Code)
                        case '$GPGGA'
                            GPS = parseGPS(tline,GPS,nPacket);
%                             nGPS = length(GPS.time);
%                             nRCATS = length(RCATS.time);
%                             if nGPS>0 && GPS.q(nGPS)==1
%                                 RCATS.time(nRCATS) = GPS.time(nGPS);
%                             end
                        case '$GPVTG'
                            disp(tline)
                        otherwise
                            disp('Unparsed command')
                    end
                case NEW_SESSION(1:nChars)
                    %disp(tline)
                    SESSION_Code = tline(5:7);
                    switch(SESSION_Code)
                        case 'NEW'
                            if ~isempty(RCATS.time) || ~isempty(GPS.time)
                                [RCATS GPS] = saveSession(froot,session,RCATS,GPS,1);
                                session = session+1;
                                oPacket = 0;
                                disp(sprintf('SESSION %d',session))
                            end
                        case 'RCA'
                            disp(tline)
                        otherwise
                            disp('Unparsed command')
                    end
                otherwise
                    disp(sprintf('Invalid Line: %s',tline))
            end
        end
    end
    if ~isempty(RCATS.time) || ~isempty(GPS.time)
        [RCATS GPS] = saveSession(froot,session,RCATS,GPS,0);
%         [RCATS GPS] = checkData(RCATS, GPS);
%         RCATS = genTime(RCATS);
    end
    fclose(fid);
return

function [DATA GPS] = saveSession(froot,session,DATA,GPS,ZEROFLAG)
    [DATA GPS] = fixTime(DATA, GPS);
%     [DATA GPS] = checkData(DATA, GPS);
%     DATA = genTime(DATA);
    RCATS.DATA = DATA;
    RCATS.GPS  = GPS;
    save(sprintf('%s_Session%d.mat',froot,session),'RCATS');
    if ZEROFLAG
        DATA = emptyRCATS();
        GPS = emptyGPS();
    end
return

function RCATS = emptyRCATS()
    RCATS.time     = [];
    RCATS.packet   = [];
    RCATS.temp1    = [];
    RCATS.temp2    = [];
    RCATS.rpm      = [];
    RCATS.altitude = [];
    RCATS.ias      = [];
    RCATS.voltage  = [];
    RCATS.cgLoad   = [];
    RCATS.current  = [];
    RCATS.sync     = [];
    RCATS.io2      = [];
    RCATS.alt_off  = [];
    RCATS.ambient  = [];
    RCATS.orderinsec = [];
return

function GPS = emptyGPS()
    % $GPGGA Data
    GPS.packet       = [];
    GPS.time         = [];
    GPS.hour         = [];
    GPS.min          = [];
    GPS.sec          = [];
    GPS.lat          = [];
    GPS.latDir       = [];
    GPS.lon          = [];
    GPS.lonDir       = [];
    GPS.q            = [];
    GPS.numSat       = [];
    GPS.hzDil        = [];
    GPS.alt          = [];
    GPS.altUnits     = [];
    GPS.geodHeight   = [];
    GPS.geodUnits    = [];
    GPS.diffDataAge  = [];
    GPS.stationID    = [];
    % $GPVTG Data
    GPS.trueCourse   = [];
    GPS.trueCourseL  = [];
    GPS.magCourse    = [];
    GPS.magCourseL   = [];
    GPS.gSpeedKnots  = [];
    GPS.gSpeedKnotsU = [];
    GPS.gSpeedKPH    = [];
    GPS.gSpeedKPHU   = [];
    GPS.mode         = [];
return

function GPS = blankGPS()
    % $GPGGA Data
    GPS.packet       =   0;
    GPS.time         =  -1;
    GPS.hour         =   0;
    GPS.min          =   0;
    GPS.sec          =  -1;
    GPS.lat          =   0;
    GPS.latDir       = 'N';
    GPS.lon          =   0;
    GPS.lonDir       = 'W';
    GPS.q            =   0;
    GPS.numSat       =   0;
    GPS.hzDil        =   -1;
    GPS.alt          =   0;
    GPS.altUnits     = 'M';
    GPS.geodHeight   =   0;
    GPS.geodUnits    = 'M';
    GPS.diffDataAge  =   0;
    GPS.stationID    =   0;
    % $GPVTG Data
    GPS.trueCourse   =   0;
    GPS.trueCourseL  = 'T';
    GPS.magCourse    =   0;
    GPS.magCourseL   = 'M';
    GPS.gSpeedKnots  =   0;
    GPS.gSpeedKnotsU = 'N';
    GPS.gSpeedKPH    =   0;
    GPS.gSpeedKPHU   = 'K';
    GPS.mode         = 'N';
return


function [RCATS nPacket] = parseRCATS(tline,RCATS)
    ldata = sscanf(tline,'TSP%dA%fB%fC%dD%dE%fF%fG%fH%fI%fJ%fK%dL%f')';
    if ~isempty(ldata)
        nPacket = ldata(1);
    else
        nPacket = 0;
    end
    if length(ldata) == 13
        nPts = length(RCATS.packet);
        if nPts==0 || nPacket>RCATS.packet(nPts)
            if nPts==0
                RCATS.time = 0;
            else
                RCATS.time = [RCATS.time;     0.1*(nPacket-RCATS.packet(1))];
            end
            RCATS.packet   = [RCATS.packet;   ldata(1)];
            RCATS.temp1    = [RCATS.temp1;    ldata(2)];
            RCATS.temp2    = [RCATS.temp2;    ldata(3)];
            RCATS.rpm      = [RCATS.rpm;      ldata(4)];
            RCATS.altitude = [RCATS.altitude; ldata(5)];
            RCATS.ias      = [RCATS.ias;      ldata(6)];
            RCATS.voltage  = [RCATS.voltage;  ldata(7)];
            RCATS.cgLoad   = [RCATS.cgLoad;   ldata(8)];
            RCATS.current  = [RCATS.current;  ldata(9)];
            RCATS.sync     = [RCATS.sync;     round(ldata(10)/5e-3)*5e-3]; % maintain quantization 5V @ 10 bits
            RCATS.io2      = [RCATS.io2;      ldata(11)];
            RCATS.alt_off  = [RCATS.alt_off;  ldata(12)];
            RCATS.ambient  = [RCATS.ambient;  ldata(13)];
            RCATS.orderinsec = [RCATS.orderinsec; mod(ldata(1),10)];
            
            plot(RCATS.time,RCATS.cgLoad,':b.')
            grid on
            xlim(RCATS.time(nPts+1)-[5 0])
            ylim(4*[-1 1])
            pause(0.01)
        else
            disp(sprintf('Skip RCATS: %s',tline))
        end
    else
        disp(sprintf('Invalid RCATS: %s',tline))
    end
return


function GPS = parseGPS(tline,GPS,packet)
global s1;
    lGPS = blankGPS();
    lGPS = parseGPGGA(tline,lGPS);

    %% Now parse the $GPVTG line
    oline = tline;
    tline = fgetl(s1);
    while isempty(tline)
        tline = fgetl(fid);
    end
    %if ~ischar(tline),   break,   end
    if ~isempty(tline) && lGPS.q==1
        lGPS = parseGPVTG(tline,lGPS);
    end
    
%     if lGPS.q==1
    nGPS = length(GPS.time);
    if nGPS>0
%         delta = round((packet-GPS.packet(nGPS))/10);
%         if delta==0
%             delta = 1;
%         end
%         packet = GPS.packet(nGPS) + 10*delta;
        if lGPS.q~=1
            lGPS.time = GPS.time(nGPS)+1;
            lGPS = fixGPS_HMS(lGPS);
        end
        if lGPS.time<GPS.time(nGPS)
            disp(sprintf('Time Discontinuity at [RCATS packet %d]',packet))
        end
    end
    % $GPGGA Data
    GPS.packet       = [GPS.packet; packet];
    GPS.time         = [GPS.time; lGPS.time];
    GPS.hour         = [GPS.hour; lGPS.hour];
    GPS.min          = [GPS.min; lGPS.min];
    GPS.sec          = [GPS.sec; lGPS.sec];
    GPS.lat          = [GPS.lat; lGPS.lat];
    GPS.latDir       = [GPS.latDir; lGPS.latDir];
    GPS.lon          = [GPS.lon; lGPS.lon];
    GPS.lonDir       = [GPS.lonDir; lGPS.lonDir];
    GPS.q            = [GPS.q; lGPS.q];
    GPS.numSat       = [GPS.numSat; lGPS.numSat];
    GPS.hzDil        = [GPS.hzDil; lGPS.hzDil];
    GPS.alt          = [GPS.alt; lGPS.alt];
    GPS.altUnits     = [GPS.altUnits; lGPS.altUnits];
    GPS.geodHeight   = [GPS.geodHeight; lGPS.geodHeight];
    GPS.geodUnits    = [GPS.geodUnits; lGPS.geodUnits];
    GPS.diffDataAge  = [GPS.diffDataAge; lGPS.diffDataAge];
    GPS.stationID    = [GPS.stationID; lGPS.stationID];
    % $GPVTG Data
    GPS.trueCourse   = [GPS.trueCourse; lGPS.trueCourse];
    GPS.trueCourseL  = [GPS.trueCourseL; lGPS.trueCourseL];
    GPS.magCourse    = [GPS.magCourse; lGPS.magCourse];
    GPS.magCourseL   = [GPS.magCourseL; lGPS.magCourseL];
    GPS.gSpeedKnots  = [GPS.gSpeedKnots; lGPS.gSpeedKnots];
    GPS.gSpeedKnotsU = [GPS.gSpeedKnotsU; lGPS.gSpeedKnotsU];
    GPS.gSpeedKPH    = [GPS.gSpeedKPH; lGPS.gSpeedKPH];
    GPS.gSpeedKPHU   = [GPS.gSpeedKPHU; lGPS.gSpeedKPHU];
    GPS.mode         = [GPS.mode; lGPS.mode];
%     end
return


function lGPS = parseGPGGA(tline,lGPS)
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
                    lGPS.hour = floor(num/10000);
                    lGPS.min  = floor((num-lGPS.hour*10000)/100);
                    lGPS.sec = num-lGPS.hour*10000-lGPS.min*100;
                    lGPS.time = lGPS.hour*3600+lGPS.min*60+lGPS.sec;
                    %if GPS.sec > 59
                    %    disp(sprintf('  Time %s : %.2f = %d:%d:%.2f',myTok,num,lGPS.hour,lGPS.min,lGPS.sec))
                    %end
                case 3  % ddmm.mmm = latitude of position
                    num = sscanf(myTok,'%f');
                    latd = floor(num/100);
                    latm = num-latd*100;
                    lGPS.lat  = latd+latm/60;
                case 4  % a = N or S, latitutde hemisphere
                    lGPS.latDir = sscanf(myTok,'%c');
                    if lGPS.latDir == 'S'
                        lGPS.lat = -lGPS.lat;
                    end
                case 5  % dddmm.mmm = longitude of position
                    num = sscanf(myTok,'%f');
                    lond = floor(num/100);
                    lonm = num-lond*100;
                    lGPS.lon  = lond+lonm/60;
                case 6  % b = E or W, longitude hemisphere 
                    lGPS.lonDir = sscanf(myTok,'%c');
                    if lGPS.lonDir == 'W'
                        lGPS.lon = -lGPS.lon;
                    end
                case 7  % q = GPS Quality indicator (0=No fix, 1=Non-differential GPS fix, 2=Differential GPS fix, 6=Estimated fix)
                    lGPS.q = sscanf(myTok,'%d');
                case 8  % xx = number of satellites in use 
                    lGPS.numSat = sscanf(myTok,'%d');
                case 9  % p.p = horizontal dilution of precision 
                    lGPS.hzDil = sscanf(myTok,'%f');
                case 10 % a.b = Antenna altitude above mean-sea-level
                    lGPS.alt = sscanf(myTok,'%f');
                case 11 % M = units of antenna altitude, meters 
                    lGPS.altUnits = sscanf(myTok,'%c');
                case 12 % c.d = Geoidal height
                    lGPS.geodHeight = sscanf(myTok,'%f');
                case 13 % M = units of geoidal height, meters 
                    lGPS.geodUnits = sscanf(myTok,'%c');
                case 14 % x.x = Age of Differential GPS data (seconds since last valid RTCM transmission) 
                    lGPS.diffDataAge = sscanf(myTok,'%f');
                case 15 % nnnn = Differential reference station ID, 0000 to 1023 
                    lGPS.stationID = sscanf(myTok(2:length(myTok)),'%d');
                otherwise
                    disp(sprintf('%s - Unknown GPS token',myTok))
            end
        end
    end
return
    
function lGPS = parseGPVTG(tline,lGPS)
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
    for i=1:numTok
        if tokSize(i)>0
            myTok = tline(tokIdx(i)+1:tokIdx(i)+tokSize(i));
            switch(i)
                case 1  % $GPVTG header
                case 2  % True course made good over ground, degrees
                    lGPS.trueCourse = sscanf(myTok,'%f');
                case 3  % True course made good over ground, degrees
                    lGPS.trueCourseL = sscanf(myTok,'%c');
                case 4  % Magnetic course made good over ground, degrees
                    lGPS.magCourse = sscanf(myTok,'%f');
                case 5  % Magnetic course made good over ground, degrees
                    lGPS.magCourseL = sscanf(myTok,'%c');
                case 6  % Ground speed
                    lGPS.gSpeedKnots = sscanf(myTok,'%f');
                case 7  % N=Knots
                    lGPS.gSpeedKnotsU = sscanf(myTok,'%c');
                case 8  % Ground speed
                    lGPS.gSpeedKPH = sscanf(myTok,'%f');
                case 9  % K=Kilometers per hour
                    lGPS.gSpeedKPHU = sscanf(myTok,'%c');
                case 10 % Mode indicator (A=Autonomous, D=Differential,
                        %                 E=Estimated, N=Data not valid)
                    lGPS.mode = myTok(1);
                otherwise
                    disp(sprintf('%s - Unknown GPS token',myTok))
            end
        end
    end
return


function ridx = findRCATSidx(RCATS,packets)
    N = length(packets);
    ridx = zeros(N,1);
    for i=1:N
        ridx(i) = find(RCATS.packet==packets(i));
    end
return

function [RCATS GPS] = fixTime(RCATS, GPS)
    gidx = find((GPS.q==1) & (GPS.numSat>4));
    if ~isempty(gidx)
        ridx = findRCATSidx(RCATS,GPS.packet(gidx));
        eidx = 0;
        N = length(RCATS.time);
        while ~isempty(eidx)
            dterr = [0; round((diff(GPS.time(gidx))-diff(RCATS.time(ridx)))/0.1)];
            eidx = find(dterr~=0);
            ridx = ridx+dterr;
            ridx(ridx>N) = N;
        end
        dtime = GPS.time(gidx)-RCATS.time(ridx);
        delta = mean(dtime);
        RCATS.time = RCATS.time + delta;
    end
%     N = length(RCATS.time);
%     so = mod(find(RCATS.sync==0,1,'last')+1,N);
%     if isempty(so)
%         po = RCATS.packet(1);
%         SINEFLAG = 0;
%     else
%         po = RCATS.packet(so);
%         SINEFLAG = 1;
%     end
%     tdx = find(RCATS.time>0);
%     gdx = [];
%     
%     if isempty(tdx) % No valid GPS time available
%         RCATS.time = 0.1*(RCATS.packet-po);
%     else            % Valid GPS time available
%         gdx = find(GPS.q==1);
%         if ~isempty(gdx)
%             dtime = diff(GPS.time(gdx)); % delta time between valid GPS points
%             dgdx  = diff(gdx);           % delta index between valid GPS points
%             if any(dgdx-dtime)           % since GPS updates at 1Hz, dgdx and dtime 
%                 [mv mdx] = min(GPS.hzDil(gdx)); % should be equal. If not, find GPS
%                 mdx = gdx(mdx);                 % point with best horizontal dilation
%                 nGPS = length(GPS.time);        % and make it the GPS time reference
%                 GPS.time = (-(mdx-1):(nGPS-mdx))'+GPS.time(mdx);
%                 RCATS.time(tdx) = GPS.time(gdx);
%             end
%             RCATS = genTime(RCATS);
%             GPS.time(gdx) = RCATS.time(tdx);
%         end
%     end
%     
%     % apply sinewave time corrections
%     if (SINEFLAG)
%         RCATS = SyncTimetoSine(RCATS);
%         if length(gdx)==length(tdx)
%             GPS.time(gdx) = RCATS.time(tdx);
%         end
%     end
%     GPS = fixGPS_HMS(GPS);
    
return

% function [RCATS GPS] = checkData(RCATS, GPS)
%     jdx = find(RCATS.time>0);
%     idx = find(GPS.q==1);
%     if length(jdx)~=length(idx)
%         disp('Number of valid GPS points ~= number of RCAT points')
%     else
%         %disp([jdx RCATS.time(jdx) idx GPS.time(idx)])
%         if any(RCATS.time(jdx)-GPS.time(idx))
%             disp('RCATS and GPS time mismatch')
%         end
%     end
%     
%     if ~isempty(idx)
%         dtime = diff(GPS.time(idx));
%         didx  = diff(idx);
%         if any(didx-dtime)
%             [mv mdx] = min(GPS.hzDil(idx));
%             mdx = idx(mdx);
%             nGPS = length(GPS.time);
%             for i=mdx-1:-1:1
%                 %disp(sprintf('PREVIOUS time %d:%d:%d',GPS.hour(i),GPS.min(i),GPS.sec(i)))
%                 GPS.sec(i) = GPS.sec(i+1)-1;
%                 GPS.min(i) = GPS.min(i+1);
%                 GPS.hour(i) = GPS.hour(i+1);
%                 if (GPS.sec(i) < 0)
%                     GPS.sec(i) = mod(GPS.sec(i),60);
%                     GPS.min(i) = GPS.min(i+1)-1;
%                     if (GPS.min(i) < 0)
%                         GPS.min(i) = mod(GPS.min(i),60);
%                         GPS.hour(i) = GPS.hour(i+1)-1;
%                     end
%                 end
%                 %disp(sprintf('NEW      time %d:%d:%d',GPS.hour(i),GPS.min(i),GPS.sec(i)))
%                 GPS.time(i) = GPS.hour(i)*3600 + GPS.min(i)*60 + GPS.sec(i);
% %                 hold off
% %                 plot(GPS.time,':.')
% %                 hold on
% %                 plot(i,GPS.time(i),'ro')
% %                 grid on
%             end
%             for i=mdx+1:nGPS
%                 %disp(sprintf('PREVIOUS time %d:%d:%d',GPS.hour(i),GPS.min(i),GPS.sec(i)))
%                 GPS.sec(i) = GPS.sec(i-1)+1;
%                 GPS.min(i) = GPS.min(i-1);
%                 GPS.hour(i) = GPS.hour(i-1);
%                 if (GPS.sec(i) > 59)
%                     GPS.sec(i) = mod(GPS.sec(i),60);
%                     GPS.min(i) = GPS.min(i-1)+1;
%                     if (GPS.min(i) > 59)
%                         GPS.min(i) = mod(GPS.min(i),60);
%                         GPS.hour(i) = GPS.hour(i-1)+1;
%                     end
%                 end
%                 %disp(sprintf('PREVIOUS time %d:%d:%d',GPS.hour(i),GPS.min(i),GPS.sec(i)))
%                 GPS.time(i) = GPS.hour(i)*3600 + GPS.min(i)*60 + GPS.sec(i);
% %                 hold off
% %                 plot(GPS.time,':.')
% %                 hold on
% %                 plot(i,GPS.time(i),'ro')
% %                 grid on
%             end
%             dtime = diff(GPS.time);
%             RCATS.time(jdx) = GPS.time(idx);
%             %disp('GPS ERROR')
%             
%             if length(jdx)~=length(idx)
%                 disp('Number of valid GPS points ~= number of RCAT points')
%             else
%                 %disp([jdx RCATS.time(jdx) idx GPS.time(idx)])
%                 if any(RCATS.time(jdx)-GPS.time(idx))
%                     disp('RCATS and GPS time mismatch')
%                 end
%             end
%         end
% %         M = length(GPS.time);
% %         for i=idx(1)-1:-1:1
% %             RCATS.time(i) = RCATS.time(idx(1))-0.1*(RCATS.packet(idx(1))-RCATS.packet(i));
% %         end
% %         N = length(idx);
% %         for i=idx(N)+1:M
% %             RCATS.time(i) = RCATS.time(idx(N))-0.1*(RCATS.packet(idx(N))-RCATS.packet(i));
% %         end
% %         for j=1:N-1
% %             for i=idx(j)+1:idx(j+1)-1
% %                 RCATS.time(i) = RCATS.time(idx(j))-0.1*(RCATS.packet(idx(j))-RCATS.packet(i));
% %             end
% %         end
%     end
% return

function RCATS = genTime(RCATS)
    idx = find(RCATS.time>0);
    tflag = max(diff(idx))>1;
    if ~isempty(idx) && tflag
        N = length(idx);
        M = length(RCATS.time);
%         for i=idx(1)-1:-1:1
%             RCATS.time(i) = RCATS.time(idx(1))-0.1*(RCATS.packet(idx(1))-RCATS.packet(i));
%         end
        bdx = 1:idx(1)-1;
        RCATS.time(bdx) = RCATS.time(idx(1)) + 0.1*(RCATS.packet(bdx) - RCATS.packet(idx(1)));
%         for i=idx(N)+1:M
%             RCATS.time(i) = RCATS.time(idx(N))-0.1*(RCATS.packet(idx(N))-RCATS.packet(i));
%         end
        edx = idx(N)+1:M;
        RCATS.time(edx) = RCATS.time(idx(N)) + 0.1*(RCATS.packet(edx) - RCATS.packet(idx(N)));
        for j=1:N-1
            %disp('-----')
            %disp(sprintf('Boundary %f to %f',RCATS.time(idx(j)),RCATS.time(idx(j+1))))
            disp(sprintf('time(%d) = %f  [%d]',idx(j),RCATS.time(idx(j)), RCATS.packet(idx(j)))); 
            %disp(sprintf('npoints=%d delta=%f(sec) npackets=%d',idx(j+1)-idx(j),RCATS.time(idx(j+1))-RCATS.time(idx(j)),RCATS.packet(idx(j+1))-RCATS.packet(idx(j))))
            
            slope = (RCATS.time(idx(j+1))-RCATS.time(idx(j)))/(RCATS.packet(idx(j+1))-RCATS.packet(idx(j)));
%             for i=idx(j)+1:idx(j+1)-1
%                 RCATS.time(i) = RCATS.time(idx(j))-slope*(RCATS.packet(idx(j))-RCATS.packet(i));
%                 %disp(sprintf('time(%d) = %f  [%d]',i,RCATS.time(i), RCATS.packet(i))); 
%             end
            sdx = idx(j)+1:idx(j+1)-1;
            RCATS.time(sdx) = RCATS.time(idx(j)) + slope*(RCATS.packet(sdx) - RCATS.packet(idx(j)));
        end
    else
        disp('RCATS.time was not processed')
    end
    [mv,mi] = max(diff(RCATS.time));
    disp(sprintf('Max RCATS.time(%d) delta=%f',mi,mv))
return


function RCATS = SyncTimetoSine(RCATS)
    f = 0.5;
    y = RCATS.sync;
    y = y-1.5;
    N = length(y);

    sdx = mod(find(y==0,1,'last')+1,N);
    tsdx = RCATS.time(sdx);
    
    te = RCATS.time-tsdx;
    t  = RCATS.time-tsdx;
    for i=sdx:N
        tband = t(i-1)+0.1-.050:0.001:t(i-1)+0.1+0.050;
        yband = sin(2*pi*f*tband);
        eband = y(i)-yband;
        [mv ti] = min(abs(eband));
        dt = tband(ti)-t(i);
        if i==sdx
            te = te + dt;
            t  = t  + dt;
        else
            t(i) = t(i) + dt;
        end
        hold off
        ptband = t(i)-(1/(2*f)):0.01:t(i)+(1/(2*f));
        pyband = sin(2*pi*f*ptband);
        plot(ptband,pyband,':b.')
        hold on
        plot(tband,yband,':g.')
        plot(t(sdx:i),y(sdx:i),'r.')
        plot(tband(ti),y(i),'ro')
        grid on
        set(gca,'YTick',y(i))
        set(gca,'XTick',sort(t(sdx:i)))
        xlim([min(ptband) max(ptband)])
%         while abs(e)>1e-3
%             m = cos(2*pi*f*(t(i)+dt))/2;
%             if abs(m*e)<1e-4, m = sign(m)*1e-4/abs(e); end
%             dt = dt + m*e;
%             e = y(i)-sin(2*pi*f*(t(i)+dt));
% %             dift = t(i)+dt-t(i-1);
% %             if abs(dift)>.2
% %                 PLOTFLAG = 1;
% %             end
%             if PLOTFLAG
%                 subplot(2,1,1)
%                 hold off
%                 plot(pdx,y(pdx),':b.')
%                 hold on
%                 plot(i,sin(2*pi*f*(t(i)+dt)),':ro')
%                 grid on
%                 subplot(2,1,2)
%                 hold off
%                 plot(pdx,t(pdx)-te(pdx),':b.')
%                 hold on
%                 plot(i,(t(i)+dt-te(i)),':ro')
%                 grid on
%                 xlim([min(pdx) max(pdx)])
%                 %ylim(0.4*[-1 1])
%                 set(gca,'YTick',0.1*(-1:1))
%                 pause(0.1)
%             end
% %             if abs(dift)>.2
% %                 dt = 0;
% %                 t(i) = t(i-1);
% %             end
%         end
%         subplot(2,1,1)
%         hold off
%         plot(pdx,y(pdx),':b.')
%         hold on
%         plot(i,sin(2*pi*f*t(i)),':ro')
%         grid on
%         xlim([min(pdx) max(pdx)])
%         
%         subplot(2,1,2)
%         hold off
%         plot(pdx,t(pdx)-te(pdx),':b.')
%         hold on
%         plot(i,t(i)-te(i),':ro')
%         grid on
%         ylim(0.2*[-1 1])
%         set(gca,'YTick',0.1*(-2:2))
%         xlim([min(pdx) max(pdx)])
%         pause(0.1)
    end
    
    h(1) = subplot(2,1,1);
    hold off
    plot(y,':b.')
    hold on
    plot(sin(2*pi*f*t),':ro')
    grid on

    h(2) = subplot(2,1,2);
    hold off
    plot(t-te,':b.')
    hold on
    plot([0;diff(t)],':r.')
    grid on
    ylim(0.2*[-1 1])
    set(gca,'YTick',0.1*(-2:2))
    
    linkaxes(h,'x')
    
    if any(diff(t)<0)
        disp('SyncTimetoSine(): TIME ERROR')
        idx = find([0;diff(t)]<0)-2;
        for i=1:length(idx)
            disp(sprintf('idx=%d t=%f  t=%f  t=%f',idx(i),t(idx(i)),t(idx(i)+1),t(idx(i)+2)))
        end
    end
    RCATS.time = t;
return

function GPS = fixGPS_HMS(GPS)
GPS.hour = floor(GPS.time/3600);
GPS.min  = floor((GPS.time-GPS.hour*3600)/60);
GPS.sec  = GPS.time-GPS.hour*3600-GPS.min*60;
return
 