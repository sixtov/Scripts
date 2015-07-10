%% This data was taken from a Hil-Sim run
Throttle = [40 45 50 55 60 65 70 75 80 85 90]';
Airspeed = [17 20 22 25 27 29 30 32 33 35 36]';

hold off
plot(Airspeed,Throttle,'o');
grid on

p2 = polyfit(Throttle,Airspeed,2);
tickThrottle = [0:5:100]';
tickAirspeed = polyval(p2,tickThrottle);
%%
hold all
tThr = [35:95]';
tAir = polyval(p2,tThr);
idx = find(tAir>=0);
plot(tAir(idx),tThr(idx),'LineWidth',2);
set(gca,'XTick',tickAirspeed,'YTick',tickThrottle);

%%
q2 = polyfit(tAir,tThr,2);
q2 = polyfit(Airspeed,Throttle,2);
plot(tAir,polyval(q2,tAir))
