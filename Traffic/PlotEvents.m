%%
N = length(MavLink.GPS_RAW.lon);
iidx = find(MavLink.ANALOG_EU.RPM>4000,1,'first');
iidx = find(MavLink.GPS_RAW.time>=MavLink.ANALOG_EU.time(iidx),1,'first');
hold off
plot(MavLink.GPS_RAW.lon,MavLink.GPS_RAW.lat,'b')
hold on
for i=1:N
    if (i<iidx), r=0; g=0; b=0;
    else 
        r = (sin(2*pi*7*i/N+pi/2)+1)/2;
        g = (sin(2*pi*5*i/N+pi/4)+1)/2;
        b = (sin(2*pi*9*i/N+pi/8)+1)/2;
    end
    plot(MavLink.GPS_RAW.lon(i),MavLink.GPS_RAW.lat(i),'.','Color',[r g b])
%     disp([r g b])
end
eTime = [1160 1177];
xTime = [eTime(2) eTime(2)+5];
idx = find(MavLink.GPS_RAW.time>eTime(1) & MavLink.GPS_RAW.time<eTime(2));
lat = double(MavLink.GPS_RAW.lat(idx));
lon = double(MavLink.GPS_RAW.lon(idx));
alt = double(MavLink.GPS_RAW.alt(idx));
idxx= [idx(end); find(MavLink.GPS_RAW.time>xTime(1) & MavLink.GPS_RAW.time<xTime(2))];
latx= double(MavLink.GPS_RAW.lat(idxx));
lonx= double(MavLink.GPS_RAW.lon(idxx));
altx= double(MavLink.GPS_RAW.alt(idxx));
plot(lon,lat,'LineWidth',2)
plot(lonx,latx,'r','LineWidth',2)
plot(lon(1),lat(1),'kd','MarkerFaceColor','g')
plot(lon(end),lat(end),'ks','MarkerFaceColor','r')
text(lon(1),lat(1),' \leftarrow Event 1')

eTime = [1230 1232];
xTime = [eTime(2) eTime(2)+5];
idx = find(MavLink.GPS_RAW.time>eTime(1) & MavLink.GPS_RAW.time<eTime(2));
lat = double(MavLink.GPS_RAW.lat(idx));
lon = double(MavLink.GPS_RAW.lon(idx));
alt = double(MavLink.GPS_RAW.alt(idx));
idxx= [idx(end); find(MavLink.GPS_RAW.time>xTime(1) & MavLink.GPS_RAW.time<xTime(2))];
latx= double(MavLink.GPS_RAW.lat(idxx));
lonx= double(MavLink.GPS_RAW.lon(idxx));
altx= double(MavLink.GPS_RAW.alt(idxx));
plot(lon,lat,'LineWidth',2)
plot(lonx,latx,'r','LineWidth',2)
plot(lon(1),lat(1),'kd','MarkerFaceColor','g')
plot(lon(end),lat(end),'ks','MarkerFaceColor','r')
text(lon(1),lat(1),' \leftarrow Event 2')

eTime = [1325 1331];
xTime = [eTime(2) eTime(2)+5];
idx = find(MavLink.GPS_RAW.time>eTime(1) & MavLink.GPS_RAW.time<eTime(2));
lat = double(MavLink.GPS_RAW.lat(idx));
lon = double(MavLink.GPS_RAW.lon(idx));
alt = double(MavLink.GPS_RAW.alt(idx));
idxx= [idx(end); find(MavLink.GPS_RAW.time>xTime(1) & MavLink.GPS_RAW.time<xTime(2))];
latx= double(MavLink.GPS_RAW.lat(idxx));
lonx= double(MavLink.GPS_RAW.lon(idxx));
altx= double(MavLink.GPS_RAW.alt(idxx));
plot(lon,lat,'LineWidth',2)
plot(lonx,latx,'r','LineWidth',2)
plot(lon(1),lat(1),'kd','MarkerFaceColor','g')
plot(lon(end),lat(end),'ks','MarkerFaceColor','r')
text(lon(1),lat(1),' \leftarrow Event 3')

eTime = [1359 1365];
xTime = [eTime(2) eTime(2)+5];
idx = find(MavLink.GPS_RAW.time>eTime(1) & MavLink.GPS_RAW.time<eTime(2));
lat = double(MavLink.GPS_RAW.lat(idx));
lon = double(MavLink.GPS_RAW.lon(idx));
alt = double(MavLink.GPS_RAW.alt(idx));
idxx= [idx(end); find(MavLink.GPS_RAW.time>xTime(1) & MavLink.GPS_RAW.time<xTime(2))];
latx= double(MavLink.GPS_RAW.lat(idxx));
lonx= double(MavLink.GPS_RAW.lon(idxx));
altx= double(MavLink.GPS_RAW.alt(idxx));
plot(lon,lat,'LineWidth',2)
plot(lonx,latx,'r','LineWidth',2)
plot(lon(1),lat(1),'kd','MarkerFaceColor','g')
plot(lon(end),lat(end),'ks','MarkerFaceColor','r')
text(lon(1),lat(1),' \leftarrow Event 4')
