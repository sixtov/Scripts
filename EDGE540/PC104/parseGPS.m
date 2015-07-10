function GPS = parseGPS(data)
    GPS.time = [];
    GPS.utc =  [];
    GPS.hour = [];
    GPS.min =  [];
    GPS.sec =  [];
    GPS.lat =  [];
    GPS.lon =  [];
    GPS.q =  [];
    GPS.numSat =  [];
    GPS.hzDil =  [];
    GPS.alt =  [];
    
    [N M] = size(data);
    dArray = data(:,1:M-1)';
    dArray = dArray(:);
    tArray = char(dArray);
    K = length(dArray);
    sidx = 1;
    vidx = [];
    
    % '$' == 36
    while sidx<K
        tidx = sidx;
        sidx = find(tArray(tidx:end)=='$',1,'first')+tidx-1;
        eidx = find(tArray(sidx:end)==char(13),1,'first')+sidx-1;
        tline = tArray(sidx:eidx)';
        dline = dArray(sidx:eidx)';
        tf = isstrprop(tline, 'print');
        tline = tline(tf);
        dline = dline(tf);
        %disp(dline)
        %disp(sprintf('>%s<',tline))
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
        gpgga = sscanf(tline,'$GPGGA,%f,%f,N,%f,W,%f,%d,%f,%f,M,%*f')';

        if ~isempty(gpgga)
            num = gpgga(1);
            lGPS.utc = num;
            lGPS.hour = floor(num/10000);
            lGPS.min  = floor((num-lGPS.hour*10000)/100);
            lGPS.sec = num-lGPS.hour*10000-lGPS.min*100;
            lGPS.time = lGPS.hour*3600+lGPS.min*60+lGPS.sec;

            num = gpgga(2);
            latd = floor(num/100);
            latm = num-latd*100;
            lGPS.lat  = latd+latm/60;

            num = gpgga(3);
            lond = floor(num/100);
            lonm = num-lond*100;
            lGPS.lon  = lond+lonm/60;
            
            lGPS.q = gpgga(4);
            lGPS.numSat = gpgga(5);
            lGPS.hzDil = gpgga(6);
            lGPS.alt = gpgga(7);
            
            i = round(sidx/(M-1));
            vidx = [vidx; i];
            
            GPS.utc    =  [GPS.utc;     lGPS.utc];
            GPS.hour   = [GPS.hour;     lGPS.hour];
            GPS.min    =  [GPS.min;     lGPS.min];
            GPS.sec    =  [GPS.sec;     lGPS.sec];
            GPS.lat    =  [GPS.lat;     lGPS.lat];
            GPS.lon    =  [GPS.lon;     lGPS.lon];
            GPS.q      =  [GPS.q;       lGPS.q];
            GPS.numSat =  [GPS.numSat;  lGPS.numSat];
            GPS.hzDil  =  [GPS.hzDil;   lGPS.hzDil];
            GPS.alt    =  [GPS.alt;     lGPS.alt];
        end
        sidx = eidx+1;
    end
    GPS.time = data(vidx,M);
return

