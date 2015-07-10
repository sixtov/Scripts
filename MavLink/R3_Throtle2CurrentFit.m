%%
%load('RPM_Cal_2011-09-07 01-59-44_mavLink.mat');
load('R3_Flight_3_2011-10-25 12-57-42_mavLink.mat');

%%
hold off
plot(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,MavLink_tsc.APM_ANALOG_EU_fwdCurr.data,'b.')
hold on
plot(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,MavLink_tsc.APM_ANALOG_EU_aftCurr.data,'r.')
[junk idx] = sort(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data);
plot(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),smooth(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx),5),'b','LineWidth',2)
plot(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),smooth(MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx),5),'r','LineWidth',2)

idx = find(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data>0);

ffun = fit(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx),'exp1');
afun = fit(MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx),'exp1');

x = 1300:10:1700;
yf= ffun.a*exp(ffun.b.*x);
ya= afun.a*exp(afun.b.*x);

plot(x,yf,'k','LineWidth',2)
plot(x,ya,'k','LineWidth',2)
grid on
ylim([0 100])
xlim([1000 1600])

fp = 1585;
ap = 1612;
fc = floor(ffun.a*exp(ffun.b*fp));
ac = floor(afun.a*exp(afun.b*ap));
fmess = sprintf('Fwd Mtr: %d(A) @ %d(pwm)',fc,fp);
amess = sprintf('Aft Mtr: %d(A) @ %d(pwm)',ac,ap);

disp(fmess)
disp(amess)
legend([{fmess} {amess}],'Location','Best','FontName','Courier')

%%
hold off
plot(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,'b.')
hold on
plot(MavLink_tsc.APM_ANALOG_EU_aftCurr.data,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,'r.')

idx = find(MavLink_tsc.APM_ANALOG_EU_fwdCurr.time>3054 & MavLink_tsc.APM_ANALOG_EU_fwdCurr.time<3648);

pf = polyfit(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx),MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),2);
pa = polyfit(MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx),MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),2);

x = 0:1:100;
yf= polyval(pf,x);
ya= polyval(pa,x);

plot(x,yf,'k','LineWidth',2)
plot(x,ya,'k','LineWidth',2)
grid on

fc = 90;
ac = 90;
pwmf = floor(polyval(pf,fc));
pwma = floor(polyval(pa,ac));
fmess = sprintf('Fwd Mtr: %d(A) @ %d(pwm)',fc,pwmf);
amess = sprintf('Aft Mtr: %d(A) @ %d(pwm)',ac,pwma);

disp(fmess)
disp(amess)
legend([{fmess} {amess}],'Location','Best','FontName','Courier')


%%
floor(polyval(pf,67.7))
floor(polyval(pa,58.7))


%%
hold off
plot(MavLink_tsc.APM_ANALOG_EU_fwdCurr.time,MavLink_tsc.APM_ANALOG_EU_fwdCurr.data,'b.')
hold on
plot(MavLink_tsc.APM_ANALOG_EU_fwdCurr.time,smooth(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data,3),'r')
grid on

%%
hold off
plot(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data+eps,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,'ko','MarkerSize',5,'MarkerFaceColor','b')
hold on
plot(MavLink_tsc.APM_ANALOG_EU_aftCurr.data+eps,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data,'ko','MarkerSize',5,'MarkerFaceColor','r')
grid on
ylim([1100 1700])

idx = find(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data>10);
ffun = fit(MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx)+eps,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),'power2');
afun = fit(MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx)+eps,MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx),'power2');

x = 0:1:90;
fy = ffun.a * x.^ffun.b + ffun.c;
ay = afun.a * x.^afun.b + afun.c;

plot(x,fy,'k','LineWidth',2)
plot(x,ay,'k','LineWidth',2)

x = [(((1516-ffun.c)/ffun.a)^(1/ffun.b)) (((1516-afun.c)/afun.a)^(1/afun.b))];

plot(x(1),1516,'kd','LineWidth',2,'MarkerSize',12,'MarkerFaceColor','b')
plot(x(2),1516,'kd','LineWidth',2,'MarkerSize',12,'MarkerFaceColor','r')

ytic = sort(unique(floor([1100:100:1400 1700 fy(end) ay(end) 1516])));
xtic = sort(unique(([0:45:90 round(x)])));
set(gca,'xtick',xtic,'ytick',ytic)

xlabel('Motor Current (A)')
ylabel('Throttle PWM')

legend([{sprintf('Forward Motor %.1f',x(1))} {sprintf('Aft Motor %.1f',x(2))}],'FontName','Courier','Location','Best')

