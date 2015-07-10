%%
load('R3_Flight_1_2011-10-25 10-43-15_mavLink.mat');
%load('R3_Flight_2_2011-10-25 11-43-12_mavLink.mat');
%load('R3_Flight_3_2011-10-25 12-57-42_mavLink.mat');

% Convert to EU and match units across MavLink members
MavLink = MavLink_EU_units(MavLink);
plotStructure('MavLink',MavLink,[{'rssi'}]);

%% Ground Speed
slvFigure('Ground Speed');
hold off
plot(MavLink.GPS.Raw.time,MavLink.GPS.Raw.v,':b.')
hold on
groundspeed = sqrt(double(MavLink.GPS.Int.vx).^2+double(MavLink.GPS.Int.vy).^2);
plot(MavLink.GPS.Int.time,groundspeed,':r.')
grid on

%% calculate Wind Speed
slvFigure('Wind Speed');
dv = [1; diff(MavLink.Hud.groundspeed)];
t1 = MavLink.GPS.Raw.time;
gs = MavLink.GPS.Raw.v;
gh = MavLink.GPS.Raw.hdg;
t2 = MavLink.Hud.time;
as = MavLink.Hud.airspeed;
ah = MavLink.Hud.heading;
[tg gs ta as] = matchTimeData(t1,gs,t2,as);
[tg gh ta ah] = matchTimeData(t1,gh,t2,ah);
wsc = (gs.*cos(pi*gh/180) - as.*cos(pi*ah/180)) + ...
    i*(gs.*sin(pi*gh/180) - as.*sin(pi*ah/180));
R = abs(wsc);
theta = 180*angle(wsc)/pi;
idx = find(theta<0);
theta(idx) = theta(idx)+360;
subplot(2,1,1)
hold off
m = find(abs([1; diff(MavLink.Hud.groundspeed)])>0);
plot(MavLink.Hud.time(m),(MavLink.Hud.groundspeed(m)-MavLink.Hud.airspeed(m)),':.')
hold on
plot(tg,R,':r.')
title('Wind Speed')
ylabel('(mph)')
xlabel('time (s)')
grid on
subplot(2,1,2)
plot(tg,theta,':r.')
grid on

%% calculate Percent Throttle
slvFigure('% Throttle');
minT = 1123;
maxT = 1521;

hold off
plot(MavLink.RC.Raw.time,100*(MavLink.RC.Raw.chan3-minT)/(maxT-minT),':b.')
hold on
plot(MavLink.Hud.time,MavLink.Hud.throttle,':r.')
title('Percent Throttle')
ylabel('(%)')
xlabel('time (s)')
grid on
legend([{'RC Throttle In'} {'AP Throttle Out'}])

%% YPR Plot
slvFigure('YPR Plot');
subplot(3,1,1)
plot(MavLink.Attitude.time,MavLink.Attitude.yaw)
subplot(3,1,2)
plot(MavLink.Attitude.time,MavLink.Attitude.pitch)
subplot(3,1,3)
plot(MavLink.Attitude.time,MavLink.Attitude.roll)


%% RC_CHANNEL settings
deg1 = 18;
max1 = 1819;
trim1 = 1517;
deg2 = 7;
max2 = 1641;
trim2 = 1546; %1518;

%% Check Stabilize Mode
h = [];
slvFigure('R3 Flight');
h(1) = subplot(2,1,1);
hold off
plot(MavLink.Attitude.time,MavLink.Attitude.roll*180/pi,':b.')
hold on
grid on
ylim(90*[-1 1])
vtitle('Roll')
vylabel('deg')
vxlabel('time (s)')

h(2) = subplot(2,1,2);
hold off
plot(MavLink.Attitude.time,MavLink.Attitude.pitch*180/pi,':b.')
hold on
grid on
ylim(90*[-1 1])
vtitle('Pitch')
vylabel('deg')
vxlabel('time (s)')

subplot(2,1,1)
plot(MavLink.Servo.Raw.time,6*(deg1/(max1-trim1))*(trim1-double(MavLink.Servo.Raw.chan1)),':r.')
legend([{'Roll (deg)'} {'Aileron Servo Cmd (scaled)'}])

subplot(2,1,2)
plot(MavLink.Servo.Raw.time,6*(deg2/(max2-trim2))*(trim2-double(MavLink.Servo.Raw.chan2)),':r.')
legend([{'Pitch (deg)'} {'Elevator Servo Cmd (scaled)'}])

linkaxes(h,'x')


slvFigure('R3 roll pitch');
subplot(2,1,1)
plot(MavLink_tsc.APM_Attitude_roll.data*180/pi, (double(MavLink_tsc.APM_Servo_Raw_chan1.data)),'.')
grid on
subplot(2,1,2)
plot(MavLink_tsc.APM_Attitude_pitch.data*180/pi,(double(MavLink_tsc.APM_Servo_Raw_chan2.data)),'.')
grid on

%% Four plots
h = [];
slvFigure('R3 Flight');
h(1) = subplot(2,2,1);
plot(MavLink.Attitude.time,MavLink.Attitude.roll*180/pi)
grid on
ylim(90*[-1 1])
vtitle('Roll')
vylabel('deg')
vxlabel('time (s)')

h(2) = subplot(2,2,2);
plot(MavLink.Attitude.time,MavLink.Attitude.pitch*180/pi)
grid on
ylim(90*[-1 1])
vtitle('Pitch')
vylabel('deg')
vxlabel('time (s)')

h(3) = subplot(2,2,3);
plot(MavLink.Servo.Raw.time,double(MavLink.Servo.Raw.chan1)-trim1)
grid on
ylim(500*[-1 1])
vtitle('Aileron Servo Cmd')
vylabel('pwm')
vxlabel('time (s)')

h(4) = subplot(2,2,4);
plot(MavLink.Servo.Raw.time,double(MavLink.Servo.Raw.chan2)-trim2)
grid on
ylim(500*[-1 1])
vtitle('Elevator Servo Cmd')
vylabel('pwm')
vxlabel('time (s)')

linkaxes(h,'x')

