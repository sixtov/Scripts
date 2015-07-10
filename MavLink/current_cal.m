%%
clear all
load('2011-09-07 01-59-44_mavLink.mat');
load('PC104\\Edge540R3_HIRF1_CHECKOUT_F100_090711_1445.mat');
pc104.eu = zeros(length(pc104.data(:,1)),64);
[ncal,txcal,rcal] = xlsread('PC104\\CalSheet_R3_090811.xls','DownlinkCal',' ','basic');
for k=1:32
    pc104.eu(:,k) = pc104.data(:,k) * ncal(k+1,5) + ncal(k+1,6);
end

%%
clear chan13ac
clear chan14ac
idx = [ ...
        1.300e5     1.472e5;    ... % 0 
        1.480e5     1.485e5;    ...
        1.492e5     1.503e5;    ... % Max
        1.504e5     1.517e5;    ...
        1.519e5     1.527e5;    ...
        1.530e5     1.539e5;    ...
        1.542e5     1.547e5;    ...
        1.550e5     1.630e5     ... % 0
        ];

 for i=1:8
     chan13ac(i,1) = mean(smooth(double(MavLink.Analog.chan13(idx(i,1):idx(i,2))),80));
     chan14ac(i,1) = mean(smooth(double(MavLink.Analog.chan14(idx(i,1):idx(i,2))),80));
 end
 
%%
slvFigure('APM Currents');
subplot(1,2,1)
hold off
plot(MavLink.Analog.chan13);
hold on
plot(smooth(double(MavLink.Analog.chan13),80),'r')
grid on
xlim([1.46e5 1.56e5]);
ylim([0 750]);
set(gca,'ytick',sort(chan13ac(1:7)));
vtitle('Autopilot Fwd Motor');
vylabel('ADC counts')

%%
subplot(1,2,2)
hold off
plot(MavLink.Analog.chan14);
hold on
plot(smooth(double(MavLink.Analog.chan14),80),'r')
grid on
xlim([1.46e5 1.56e5]);
ylim([0 750]);
set(gca,'ytick',sort(chan14ac(1:7)));
vtitle('Autopilot Aft Motor');
vylabel('ADC counts')
    
%%
saveas(gcf,'APM_ADC.jpg');

%%
fwdCurr = pc104.eu(:,15);
aftCurr = pc104.eu(:,16);

idx = [ ...
        0.600e5     0.800e5;    ... % 0 
        0.979e5     1.043e5;    ...
        1.160e5     1.237e5;    ... % Max
        1.259e5     1.360e5;    ...
        1.423e5     1.454e5;    ...
        1.511e5     1.578e5;    ...
        1.640e5     1.681e5;    ...
        1.707e5     2.400e5     ... % 0
        ];
    
fwdCurr = fwdCurr - mean(fwdCurr(idx(1,1):idx(1,2)));
aftCurr = aftCurr - mean(aftCurr(idx(1,1):idx(1,2)));

 for i=1:8
     chan15pc(i,1) = mean(smooth(fwdCurr(idx(i,1):idx(i,2)),80));
     chan16pc(i,1) = mean(smooth(aftCurr(idx(i,1):idx(i,2)),80));
 end
 
%%
slvFigure('PC104 Currents');
subplot(1,2,1)
hold off
plot(fwdCurr);
hold on
plot(smooth(fwdCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan15pc(1:7)));
vtitle('PC104 Fwd Motor');
vylabel('Current (A)')

%%
subplot(1,2,2)
hold off
plot(aftCurr);
hold on
plot(smooth(aftCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan16pc(1:7)));
vtitle('PC104 Aft Motor');
vylabel('Current (A)')
    
%%
saveas(gcf,'PC104_Current.jpg');

%%
pf = polyfit(chan13ac,chan15pc,1);
pa = polyfit(chan14ac,chan16pc,1);

%%
slvFigure('Calibrated APM');
subplot(2,2,1)
hold off
plot(fwdCurr);
hold on
plot(smooth(fwdCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan15pc(1:7)));
vtitle('PC104 Fwd Motor');
vylabel('Current (A)')

%%
subplot(2,2,3)
hold off
plot(aftCurr);
hold on
plot(smooth(aftCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan16pc(1:7)));
vtitle('PC104 Aft Motor');
vylabel('Current (A)')

%%
subplot(2,2,2)
hold off
plot(polyval(pf,double(MavLink.Analog.chan13)));
hold on
plot(smooth(polyval(pf,double(MavLink.Analog.chan13)),80),'r');
grid on
xlim([1.46e5 1.56e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan15pc(1:7)));
vtitle('Autopilot Fwd Motor');
vylabel('Current (A)')

%%
subplot(2,2,4)
hold off
plot(polyval(pa,double(MavLink.Analog.chan14)));
hold on
plot(smooth(polyval(pa,double(MavLink.Analog.chan14)),80),'r');
grid on
xlim([1.46e5 1.56e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan16pc(1:7)));
vtitle('Autopilot Aft Motor');
vylabel('Current (A)')
    
%%
saveas(gcf,'Calibration_Result.jpg');

%%
slvFigure('Current Data');
subplot(2,2,3)
hold off
plot(fwdCurr);
hold on
plot(smooth(fwdCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan15pc(1:7)));
vtitle('PC104 Fwd Motor');
vylabel('Current (A)')

%%
subplot(2,2,4)
hold off
plot(aftCurr);
hold on
plot(smooth(aftCurr,80),'r');
grid on
xlim([0.8e5 1.8e5]);
ylim([0 110]);
set(gca,'ytick',sort(chan16pc(1:7)));
vtitle('PC104 Aft Motor');
vylabel('Current (A)')

%%
subplot(2,2,1)
hold off
plot(MavLink.Analog.chan13);
hold on
plot(smooth(double(MavLink.Analog.chan13),80),'r')
grid on
xlim([1.46e5 1.56e5]);
ylim([0 750]);
set(gca,'ytick',sort(chan13ac(1:7)));
vtitle('Autopilot Fwd Motor');
vylabel('ADC counts')

%%
subplot(2,2,2)
hold off
plot(MavLink.Analog.chan14);
hold on
plot(smooth(double(MavLink.Analog.chan14),80),'r')
grid on
xlim([1.46e5 1.56e5]);
ylim([0 750]);
set(gca,'ytick',sort(chan14ac(1:7)));
vtitle('Autopilot Aft Motor');
vylabel('ADC counts')
    
%%
saveas(gcf,'Current_Data.jpg');

%%
disp('Forward Motor ADC counts         Aft Motor ADC counts')
disp([chan13ac chan14ac]);

disp('Forward Motor PC104 Current         Aft Motor PC104 Current')
disp([chan15pc chan16pc]);

disp('Forward Motor Data')
disp('  APM(cnts) Current(A)')
disp([chan13ac chan15pc]);
disp('       Motor Coeff')
disp('    Slope    Intercept')
disp(pf);

disp('Aft Motor Data')
disp('  APM(cnts) Current(A)')
disp([chan14ac chan16pc]);
disp('       Motor Coeff')
disp('    Slope    Intercept')
disp(pa);
