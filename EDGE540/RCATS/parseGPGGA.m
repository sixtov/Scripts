%function lGPS = parseGPGGA(tline,lGPS)
function lGPS = parseGPGGA(tline)
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

    
    lGPS = blankGPGGA();
    gpgga = sscanf(tline,'$GPGGA,%f,%f,%c,%f,%c,%d,%d,%f,%f,%c,%f,%c,,*%x')';
    if (length(gpgga)==13)
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
        
        lGPS.latDir = char(gpgga(3));
        if lGPS.latDir == 'S'
            lGPS.lat = -lGPS.lat;
        end
        
        num = gpgga(4);
        lond = floor(num/100);
        lonm = num-lond*100;
        lGPS.lon  = lond+lonm/60;
        
        lGPS.lonDir = char(gpgga(5));
        if lGPS.lonDir == 'W'
            lGPS.lon = -lGPS.lon;
        end
        
        lGPS.q = gpgga(6);
        lGPS.numSat = gpgga(7);
        lGPS.hzDil = gpgga(8);
        lGPS.alt = gpgga(9);
        lGPS.altUnits = char(gpgga(10));
        lGPS.geodHeight = gpgga(11);
        lGPS.geodUnits = char(gpgga(12));
        lGPS.checkSum1 = gpgga(13);
    end
return

function GPS = blankGPGGA()
    % $GPGGA Data
    GPS.packet       =   0;
    GPS.time         =  -1;
    GPS.utc          =   0;
    GPS.hour         =   0;
    GPS.min          =   0;
    GPS.sec          =  -1;
    GPS.lat          =   0;
    GPS.latDir       = 'N';
    GPS.lon          =   0;
    GPS.lonDir       = 'W';
    GPS.q            =   0;
    GPS.numSat       =   0;
    GPS.hzDil        =  -1;
    GPS.alt          =   0;
    GPS.altUnits     = 'M';
    GPS.geodHeight   =   0;
    GPS.geodUnits    = 'M';
    GPS.checkSum1    =   0;
return

    
