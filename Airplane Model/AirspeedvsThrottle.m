%%
load('R2_Flight_50_2013-04-09 09-35-09_mavLink.mat');
time = MavLink_tsc.APM_VFR_HUD_airspeed.time;
airspeed = MavLink_tsc.APM_VFR_HUD_airspeed.data;
throttle = MavLink_tsc.APM_VFR_HUD_throttle.data;

slvFigure('Throttle vs Airspeed');
h = subplot(4,1,1);
plot(time,throttle)
grid on
h = [h subplot(4,1,2)];
plot(time,airspeed)
grid on
linkaxes(h,'x');

%%
i60p = find(time>=2985 & time<=3059);
i65p = find(time>=3109 & time<=3357);
i75p = find(time>=3359 & time<=3512);
i85p = find(time>=3514 & time<=3584);

ais60p = airspeed(i60p); 
ais65p = airspeed(i65p);
ais75p = airspeed(i75p);
ais85p = airspeed(i85p);

AIS60P = mean(ais60p);
AIS65P = mean(ais65p);
AIS75P = mean(ais75p);
AIS85P = mean(ais85p);

subplot(4,4,9)
plot(time(i60p),ais60p)
grid on
axis tight
set(gca,'YTick',sort(unique([ylim AIS60P])))

subplot(4,4,10)
plot(time(i65p),ais65p)
grid on
axis tight
set(gca,'YTick',sort(unique([ylim AIS65P])))

subplot(4,4,11)
plot(time(i75p),ais75p)
grid on
axis tight
set(gca,'YTick',sort(unique([ylim AIS75P])))

subplot(4,4,12)
plot(time(i85p),ais85p)
grid on
axis tight
set(gca,'YTick',sort(unique([ylim AIS85P])))

T = [60 65 75 85];
A = [AIS60P AIS65P AIS75P AIS85P];

p = polyfit(A,T,1);
ais = 0:100;
fthrottle = polyval(p,ais);

subplot(4,1,4)
hold off
plot(A,T,'o')
hold on
plot(ais,fthrottle,'r','LineWidth',2)
xlabel('airspeed (m/s)')
ylabel('throttle (%)')
xlim([12 28])
ylim([50 100])
grid on
ftext = sprintf('throttle(%%) = %.2f * airspeed + %.2f',p);
text(13,85,ftext)
