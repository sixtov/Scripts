%%
mps2knots = 1.94384449;
    
%%
RPM = MavLink_ts.ANALOG_EU.RPM;
fCurr = MavLink_ts.ANALOG_EU.fwdCurr;
aCurr = MavLink_ts.ANALOG_EU.aftCurr;
throttle_pwm = MavLink_ts.SERVO_OUTPUT_RAW.servo3_raw;
target_airspeed = MavLink_ts.NAV_CONTROLLER_OUTPUT.aspd_error;
airspeed = MavLink_ts.VFR_HUD.airspeed/mps2knots;
throttle = MavLink_ts.VFR_HUD.throttle;

%%
superTime = unique(sort([MavLink.SYS_STATUS.time; ...
             MavLink.ANALOG_EU.time; ...
             MavLink.SERVO_OUTPUT_RAW.time; ...
             MavLink.NAV_CONTROLLER_OUTPUT.time; ...
             MavLink.VFR_HUD.time]));
auto = ((MavLink.SYS_STATUS.mode==4) & (MavLink.SYS_STATUS.nav_mode==3));
sseg = find(diff(auto)==1);
eseg = find(diff(auto)==-1)+1;
tseg = zeros(size(superTime));
for i=1:3
    tseg = [tseg | (superTime>MavLink.SYS_STATUS.time(sseg(i)) & superTime<MavLink.SYS_STATUS.time(eseg(i)))];
end
nTime = superTime(tseg);

%% Resample
RPM = resample(RPM,nTime);
fCurr = resample(fCurr,nTime);
aCurr = resample(aCurr,nTime);
throttle_pwm = resample(throttle_pwm,nTime);
target_airspeed = resample(target_airspeed,nTime);
airspeed = resample(airspeed,nTime);
throttle = resample(throttle,nTime);
airspeed_error = target_airspeed - airspeed;
abs_ase = airspeed_error;
abs_ase.data = abs(abs_ase.data);

%%
slvFigure('Airpeed Data');
h=[];
h=[h subplot(3,1,1)];
hold off
plot(target_airspeed,':.')
hold all
plot(airspeed,':.')
grid on
vtitle('target and actual airspeeds')
xlabel('time (sec)')
ylabel('speed (m/s)')

h=[h subplot(3,1,2)];
hold off
plot(airspeed_error,':.')
hold all
plot(abs_ase,':.')
grid on
vtitle('airspeed error')
xlabel('time (sec)')
ylabel('error (m/s)')

h=[h subplot(3,1,3)];
hold off
plot((throttle_pwm-1000)/5,':.')
hold all
plot(throttle,':.')
grid on
vtitle('throttle')
xlabel('time (sec)')
ylabel('throttle (%)')

linkaxes(h,'x')

%%
idx = find(diff(throttle.data)~=0);
nTime = throttle.time(idx);

%% Resample
RPM = resample(RPM,nTime);
fCurr = resample(fCurr,nTime);
aCurr = resample(aCurr,nTime);
throttle_pwm = resample(throttle_pwm,nTime);
target_airspeed = resample(target_airspeed,nTime);
airspeed = resample(airspeed,nTime);
throttle = resample(throttle,nTime);
airspeed_error = target_airspeed - airspeed;

%%
plot(RPM.data,airspeed.data,'.')
