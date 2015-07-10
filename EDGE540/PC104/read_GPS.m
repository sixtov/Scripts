Xpctime = [];
GPStime = [];
lat     = [];
lon     = [];
alt     = [];

N = size(pc104.data,1);            % Number of logged strings with number to skip until

for i = 1:N;
    Xpctime_now = pc104.data(i,166);
    [GPStime1,lat1,lon1,alt1] = parse_latlonalt(char(pc104.data(i,1:165)));  
    if (GPStime1>0)
        %Data in record, save it in the output arrays and bump ikeep index.
        %Xpctime(ikeep) = pc104.data(2+i,166);
        Xpctime = [Xpctime; Xpctime_now];
        GPStime = [GPStime; GPStime1];
        lat = [lat; lat1];
        lon = [lon; lon1];
        alt = [alt; alt1];
    end
end
