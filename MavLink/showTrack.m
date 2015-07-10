function showTrack(M)
%%
slvFigure('Flight Track');
h=subplot(4,1,1);
plot(M.GPS_RAW.time,M.GPS_RAW.lat,':o');
grid on
h=[h;subplot(4,1,2)];
plot(M.GPS_RAW.time,M.GPS_RAW.lon,':o');
grid on
h=[h;subplot(4,1,3)];
plot(M.VFR_HUD.time,M.VFR_HUD.alt,':o');
grid on
h=[h;subplot(4,1,4)];
plot(M.GPS_STATUS.time,M.GPS_STATUS.satellites_visible,':o');
grid on

linkaxes(h,'x');
return
