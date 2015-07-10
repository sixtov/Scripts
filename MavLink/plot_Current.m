%%
slvFigure('HIRF_11');
subplot(2,1,1)
hold off
plot(MavLink.Analog.time,[MavLink.Analog.chan13 MavLink.Analog.chan14])
hold on
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.chan13),80),'c')
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.chan14),80),'m')
grid on

subplot(2,1,2)
hold off
plot(MavLink.Analog.time,[MavLink.Analog.FwdMtrCurr MavLink.Analog.AftMtrCurr])
hold on
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.FwdMtrCurr),80),'c')
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.AftMtrCurr),80),'m')
grid on

%%
slvFigure('HIRF_11');
subplot(2,1,1)
hold off
plot(MavLink.Analog.time,MavLink.Analog.FwdMtrCurr,'b')
hold on
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.FwdMtrCurr),80),'c')
grid on

subplot(2,1,2)
hold off
plot(MavLink.Analog.time,MavLink.Analog.AftMtrCurr,'g')
hold on
plot(MavLink.Analog.time,smooth(double(MavLink.Analog.AftMtrCurr),80),'m')
grid on
