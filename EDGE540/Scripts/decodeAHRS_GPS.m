function GPS = decodeAHRS_GPS(GPSlog)
global fid;
    disp('DECODE STARTS:')
    session = 1;
    disp(sprintf('SESSION %d',session))
    fid=fopen(GPSlog);
    if fid == -1
        disp(sprintf('Could not open ''%s''',GPSlog))
        return
    end
    GPS = emptyGPS();
    while 1
        tline = fgetl(fid);
        if ~ischar(tline),   break,   end
        if ~isempty(tline)
            GPS = parseGPS(tline,GPS);
        end
    end
    fclose(fid);
return

function GPS = emptyGPS()
    GPS.hour = [];
    GPS.min = [];
    GPS.sec = [];
    GPS.lat = [];
    GPS.lon = [];
    GPS.alt = [];
    GPS.time = [];
return

function GPS = parseGPS(tline,GPS)
    ldata = sscanf(tline,'%d:%d:%d,%f,%f,%f')';
    N = length(ldata);
    if (N==6)
        disp(tline)
        GPS.hour = [GPS.hour; ldata(1)];
        GPS.min  = [GPS.min ; ldata(2)];
        GPS.sec  = [GPS.sec ; ldata(3)];
        GPS.lon  = [GPS.lon ; ldata(4)];
        GPS.lat  = [GPS.lat ; ldata(5)];
        GPS.alt  = [GPS.alt ; ldata(6)];
        nGPS = length(GPS.hour);
        GPS.time = [GPS.time; GPS.hour(nGPS)*3600+GPS.min(nGPS)*60+GPS.sec(nGPS)];
    else
        disp('Incomplete GPS packet')
    end
return

