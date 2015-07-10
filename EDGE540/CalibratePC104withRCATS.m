%% First Step to Calibrate PC104 with RCATS
    % G:\SmithField July 16 2010\for Analysis
    load('EDGE_FLIGHT_08.mat');
    PC104 = EDGE.PC104.EU;
    RCATS = EDGE.RCATS.DATA;
    [PC104idx RCATSidx] = pairUpTimeValues(PC104.time,RCATS.time);
    PC104 = extractSection(PC104,PC104idx);
    RCATS = extractSection(RCATS,RCATSidx);
    
    pairUpSignals(PC104,'PSR',RCATS,'altitude','poly1');

%% Find Calibration Parameters between Signal Pairs
    pairUpSignals(PC104,'PSR',RCATS,'altitude','poly1');
    pairUpSignals(PC104,'PDR',RCATS,'ias','rat54');
    pairUpSignals(PC104,'RPM',RCATS,'rpm','poly2');
%     pairUpSignals(PC104,'FWDMTRCUR',RCATS,'frontmotorcurr','poly1');
%     pairUpSignals(PC104,'AFTMTRCUR',RCATS,'aftmotorcurr','poly1');
%     pairUpSignals(PC104,'MTRMOUNTTEMP',RCATS,'motortemp','poly1');
%     pairUpSignals(PC104,'RTBOTBATTEMP',RCATS,'batterytemp','poly1');
    %pairUpSignals(PC104,'',RCATS,'','poly1');

%%
    slvFigure('Test');
    h(1)=subplot(2,1,1);
    plot(EDGE.RCATS.GPS.time,unwrap(EDGE.RCATS.GPS.magCourse))
    grid on
    h(2)=subplot(2,1,2);
    plot(EDGE.RCATS.GPS.time,EDGE.RCATS.GPS.alt)
    grid on
    linkaxes(h,'x')
    
%%
    subplot(3,1,1)
    latidx = find(EDGE.RCATS.GPS.lat ~= 0);
    lonidx = find(EDGE.RCATS.GPS.lon ~= 0);
    idx = intersect(latidx,lonidx);
    plot(EDGE.RCATS.GPS.lon(idx),EDGE.RCATS.GPS.lat(idx))
    grid on
    axis equal
    
    h(1)=subplot(3,1,2);
    plot(EDGE.RCATS.GPS.time(idx),EDGE.RCATS.GPS.lat(idx))
    grid on
    
    h(2)=subplot(3,1,3);
    plot(EDGE.RCATS.GPS.time(idx),EDGE.RCATS.GPS.lon(idx))
    grid on
    linkaxes(h,'x')
    
%%

    
%%
SyncRCATSandPC104(08,'RCATS_Flight_08_trimmed_071610.mat','PC104_EDGE540R2_FLT08.mat');
SyncRCATSandPC104(09,'RCATS_Flight_09_trimmed_071610.mat','PC104_EDGE540R2_FLT09.mat');
SyncRCATSandPC104(10,'RCATS_Flight_10_trimmed_071610.mat','PC104_EDGE540R2_FLT10.mat');

%% Calibrate PC104 pitot tube, rpm, and currents with RCATS data

EDGE.RCATS.DATA.time
EDGE.RCATS.DATA.rpm
EDGE.RCATS.DATA.altitude
EDGE.RCATS.DATA.ias
EDGE.RCATS.DATA.frontmotorcurr
EDGE.RCATS.DATA.aftmotorcurr
EDGE.RCATS.DATA.motortemp
EDGE.RCATS.DATA.batterytemp

EDGE.PC104.RAW.time
EDGE.PC104.RAW.RPM
EDGE.PC104.RAW.PDR
EDGE.PC104.RAW.PSR
EDGE.PC104.RAW.FWDMTRCUR
EDGE.PC104.RAW.AFTMTRCUR
EDGE.PC104.RAW.MTRMOUNTTEMP
EDGE.PC104.RAW.RTBOTBATTEMP

%%
N = length(EDGE.RCATS.DATA.time);
Pidx = [];
for i=1:N
    [mval idx] = min(abs(EDGE.PC104.RAW.time-EDGE.RCATS.DATA.time(i)));
    Pidx = [Pidx idx];
end

%%
RCATS = EDGE.RCATS.DATA.rpm;
PC104 = EDGE.PC104.RAW.RPM;
Label = 'RPM Calibration';
p = polyfit(PC104(Pidx),RCATS,2);

%%
RCATS = EDGE.RCATS.DATA.frontmotorcurr;
PC104 = EDGE.PC104.RAW.FWDMTRCUR;
Label = 'FWD Motor Current Calibration';
p = polyfit(PC104(Pidx),RCATS,1);

%%
RCATS = EDGE.RCATS.DATA.aftmotorcurr;
PC104 = EDGE.PC104.RAW.AFTMTRCUR;
Label = 'AFT Motor Current Calibration';
p = polyfit(PC104(Pidx),RCATS,1);

%%
RCATS = EDGE.RCATS.DATA.batterytemp;
PC104 = EDGE.PC104.RAW.RTBOTBATTEMP;
Label = 'Bat. Temp Calibration';
p = polyfit(PC104(Pidx),RCATS,1);

%%
RCATS = EDGE.RCATS.DATA.altitude;
PC104 = EDGE.PC104.RAW.PSR;
Label = 'Altitud Calibration';
p = polyfit(PC104(Pidx),RCATS,1);

%%
RCATS = EDGE.RCATS.DATA.ias;
PC104 = EDGE.PC104.RAW.PDR;
Label = 'Airspeed Calibration';
p = polyfit(PC104(Pidx),RCATS,2);

%%
h = [];
disp(sprintf('%0.4f  ',p))

slvFigure(Label);
h(1)=subplot(3,1,1);
plot(EDGE.PC104.RAW.time,PC104,'r')
grid on
vxlabel('time (sec)')
vylabel('PC104 Raw')
vtitle(Label)

h(2)=subplot(3,1,2);
plot(EDGE.RCATS.DATA.time,RCATS,'b')
grid on
vxlabel('time (sec)')
vylabel('RCATS')

subplot(3,1,3)
hold off
plot(PC104(Pidx),RCATS,'.')
grid on
hold on
X = min(PC104):(max(PC104)-min(PC104))/99:max(PC104);
plot(X,polyval(p,X),'r','LineWidth',2)
vxlabel('PC104 Raw')
vylabel('RCATS')
lText = [{'data'} {sprintf('polyfit: %s',sprintf('%.4f  ',p))}];
legend(lText,'Location','Best')
vtitle('Calibration Fit')

subplot(3,1,2)
hold off
plot(EDGE.PC104.RAW.time,polyval(p,PC104),'r')
hold on
plot(EDGE.RCATS.DATA.time,RCATS,'b')
grid on
vxlabel('time (sec)')
vylabel(Label)
vtitle('Calibration Result')
lText = [{'PC104'} {'RCATS'}];
legend(lText)

linkaxes(h,'x')

saveas(gcf,Label,'fig')
%%
