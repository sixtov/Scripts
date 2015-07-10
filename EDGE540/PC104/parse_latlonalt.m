function [GPStime,lat,lon,alt] = parse_latlonalt(inchars)
% Extract GPStime in week (sec), Latitude (deg), Longitude (deg), 
% and Altitude (m) from the Sparkfun GPGGA message.

headerindx = findstr('$GPGGA',inchars);
inchars(inchars == 13) = ' ';
inchars(inchars == 10) = ' ';
if ~isempty(headerindx)
%     disp(inchars(headerindx:length(inchars)));
end

[tok1, seg1]  = strtok(inchars(headerindx+6+1:length(inchars)),',');
[tok2, seg2]  = strtok(seg1 ,',');
[tok3, seg3]  = strtok(seg2 ,',');
[tok4, seg4]  = strtok(seg3 ,',');
[tok5, seg5]  = strtok(seg4 ,',');
[tok6, seg6]  = strtok(seg5 ,',');
[tok7, seg7]  = strtok(seg6 ,',');
[tok8, seg8]  = strtok(seg7 ,',');
[tok9, seg9]  = strtok(seg8 ,',');
[tok10,seg10] = strtok(seg9 ,',');
[tok11,seg11] = strtok(seg10,',');


if ~isempty(tok1)
    GPStime = str2double(tok1);
    if isempty(GPStime)
        GPStime = -1;
    end
else
    GPStime = -1;
end

if ~isempty(tok2)
    num = str2double(tok2);
    if isempty(num)
        num = 0;
    end
    lat = floor(num/100);
    lat = lat + (num-100*lat)/60;
    if (lat == 0)
        lat = NaN;
    end
else
    lat = NaN;
end

if ~isempty(tok4)
    num = str2double(tok4);
    if isempty(num)
        num = 0;
    end
    lon = floor(num/100);
    lon = lon + (num-100*lon)/60;
    lon = -lon;
    if (lon == 0)
        lon = NaN;
    end
else
    lon = NaN;
end

if ~isempty(tok9)
    alt = str2double(tok9);
    if isempty(alt)
        alt = NaN;
    end
else
    alt = NaN;
end

return


