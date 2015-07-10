function genGPXFile(dfile)
%%
gpxfile = sprintf('%s.gpx',dfile(1:end-4));
txtfile = sprintf('%s.txt',dfile(1:end-4));
kmlfile = sprintf('%s_forKML.txt',dfile(1:end-4));
load(dfile);
a = dir(dfile);
fname = a.name(1:end-4);
dinfo = datevec(a.datenum);

if (isempty(MavLink_ts)),            fprintf('No timeseries found in %s\n',dfile); return; end
if (~isfield(MavLink_ts,'GPS_RAW')), fprintf('timeseries did not contain GPS_RAW data\n'); return; end

tdata = repmat(dinfo,length(MavLink_tsc.APM_GPS_RAW_lat.data),1);
tdata(:,6) = (tdata(:,6)+MavLink_tsc.APM_GPS_RAW_lat.time);
tnum = datenum(tdata);
tdata = datevec(tnum);
tdata(:,6) = floor(100*tdata(:,6))/100;

%%
data = [MavLink_tsc.APM_GPS_RAW_lat.data ...
        MavLink_tsc.APM_GPS_RAW_lon.data ...
        MavLink_tsc.APM_GPS_RAW_alt.data ...
        tdata ...
        180*mod(pi*MavLink_tsc.APM_ATTITUDE_yaw.data/180,2*pi)/pi ...
        MavLink_tsc.APM_ATTITUDE_roll.data ...
        MavLink_tsc.APM_ATTITUDE_pitch.data];

%%
idx = all(~isnan(data),2);
idx = and(idx,abs(MavLink_tsc.APM_GPS_RAW_lat.data)>0);
idx = and(idx,abs(MavLink_tsc.APM_GPS_RAW_lon.data)>0);
data = data(idx,:);

%%
fp = fopen(gpxfile,'w');
fprintf(fp,'<gpx><trk><trkseg>\r\n');
fprintf(fp,'<trkpt lat="%f" lon="%f"> <ele>%6.2f</ele> <time>%04d-%02d-%02dT%02d:%02d:%05.2f-04:00</time> <course>%7.2f</course> <roll>%5.2f</roll> <pitch>%5.2f</pitch> </trkpt>\r\n', ...
             data');
fprintf(fp,'</trkseg></trk></gpx>\r\n');
fclose(fp);

%%
data = [MavLink_tsc.APM_GPS_RAW_lat.data ...
        MavLink_tsc.APM_GPS_RAW_lon.data ...
        MavLink_tsc.APM_GPS_RAW_alt.data ...
        tdata];
data = data(idx,:);

%%
fp = fopen(txtfile,'w');
fprintf(fp,'%f,  %f,  %6.2f,  %04d-%02d-%02dT%02d:%02d:%05.2f\r\n',data');
fclose(fp);

%%
data = [MavLink_tsc.APM_GPS_RAW_lon.data ...
        MavLink_tsc.APM_GPS_RAW_lat.data ...
        MavLink_tsc.APM_GPS_RAW_alt.data];
data = data(idx,:);

%%
fp = fopen(kmlfile,'w');
fprintf(fp,'%f,%f,%.1f ',data');
fclose(fp);
