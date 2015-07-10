%% Analyze 4D Performance
mps2knots = 1.94384449;
targetDist = timeseries(MavLink.NAV_CONTROLLER_OUTPUT.wp_dist,MavLink.NAV_CONTROLLER_OUTPUT.time,'Name','TARGET DIST');
targetSpeed = timeseries(MavLink.NAV_CONTROLLER_OUTPUT.aspd_error,MavLink.NAV_CONTROLLER_OUTPUT.time,'Name','TARGET SPEED');
airSpeed = timeseries(MavLink.VFR_HUD.airspeed/mps2knots,MavLink.VFR_HUD.time,'Name','AIRSPEED');
timeLeft = timeseries(MavLink.VFR_HUD.climb,MavLink.VFR_HUD.time,'Name','TIME LEFT');
throttle = timeseries(MavLink.VFR_HUD.throttle,MavLink.VFR_HUD.time,'Name','THROTTLE');

MaxT = max([max(MavLink.NAV_CONTROLLER_OUTPUT.time) max(MavLink.VFR_HUD.time)]); 
time3Hz = [0:1/3:MaxT]';

targetDist = resample(targetDist,time3Hz,'zoh');
targetSpeed = resample(targetSpeed,time3Hz);
airSpeed = resample(airSpeed,time3Hz);
timeLeft = resample(timeLeft,time3Hz,'zoh');
throttle = resample(throttle,time3Hz,'zoh');

%%
dDist = timeseries(diff(targetDist.data),time3Hz(2:end),'Name','dDist');
dTime = timeseries(diff(timeLeft.data),time3Hz(2:end),'Name','dTime');
idx = find(dTime.data>0)+1;
N = length(idx);
tTicks = time3Hz(idx);

allotedTime = timeseries(timeLeft.data(idx(1:N-1))-(timeLeft.data(idx(1:N-1)-1)-1/3),time3Hz(idx(1:N-1)),'Name','Alloted Time');
actualTime = timeseries(timeLeft.data(idx(1:N-1))-(timeLeft.data(idx(1:N-1)-1)-1/3)-(timeLeft.data(idx(2:N)-1)-1/3),time3Hz(idx(1:N-1)),'Name','Actual Time');
errorTime = timeseries(-(timeLeft.data(idx(2:N)-1)-1/3),time3Hz(idx(1:N-1)),'Name','4D Error');
percentTime = timeseries(100*errorTime.data./allotedTime.data,time3Hz(idx(1:N-1)),'Name','%4D Error');
%[timeLeft.data(idx(1:N-1))-(timeLeft.data(idx(1:N-1)-1)-1/3) timeLeft.data(idx(1:N-1))-(timeLeft.data(idx(1:N-1)-1)-1/3)-(timeLeft.data(idx(2:N)-1)-1/3) -(timeLeft.data(idx(2:N)-1)-1/3)];

%%
h = [];

h = [h subplot(4,1,1)];
hold off
plot(targetSpeed,':.')
hold all
plot(airSpeed,':.')
set(gca,'Xtick',tTicks)
grid on

h = [h subplot(4,1,2)];
hold off
plot(throttle,':.')
hold all
set(gca,'Xtick',tTicks)
grid on

h = [h subplot(4,1,3)];
hold off
plot(timeLeft,':.')
hold all
set(gca,'Xtick',tTicks)
grid on

h = [h subplot(4,1,4)];
hold off
plot(percentTime,':.')
hold all
plot(errorTime,':.')
set(gca,'Xtick',tTicks)
grid on

linkaxes(h,'x');
