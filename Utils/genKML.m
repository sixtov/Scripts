%%
function genKML(file)
    load(file);
    ofile = file(1:end-4);
    idx = MavLink.GPS_RAW.lat>0;
    data = [MavLink.GPS_RAW.lat(idx) MavLink.GPS_RAW.lon(idx)]; %% MavLink.GPS_RAW.alt(idx)];
    pwr_kml(ofile,data);
return
