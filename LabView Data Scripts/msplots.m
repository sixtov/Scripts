function  msplots(tprefix, simLPSon, pc104LPSon, simLPSoff, pc104LPSoff, SPon_Offset)
%plot constants
LW = 2;
FS = 12;
ONCol = [.2 .7 .2];  %'m';
OFFCol = 'b';
simRange = [296 298];

slvFigure ( 'Longitudinal Control Stick Input');
hold off
plot(simLPSoff.TimeStamp, simLPSoff.lon_stk, OFFCol,'LineWidth', LW)
hold on
plot(simLPSon.TimeStamp, simLPSon.lon_stk,'Color', ONCol,'LineWidth', LW)
xlabel ('Time (s)');
validTitle ('Longitudinal Control Stick Input')
grid on
xlim (simRange)
saveas (gcf, sprintf('%s_SIM_StickInput.jpg',tprefix))
%%
pglimNew = 1.2;
nglimNew = -0.2;

slvFigure ( 'Simulator CG Accelerations');
hold off
plot(simLPSoff.TimeStamp, simLPSoff.nzbody, OFFCol, 'LineWidth', LW)
hold on
plot(simLPSon.TimeStamp, simLPSon.nzbody,'Color',  ONCol, 'LineWidth', LW)
plot([1,1000], nglimNew*[1 1], ':m', 'LineWidth', 1)
plot([1,1000], pglimNew*[1 1], ':m', 'LineWidth', 1)
xlabel ('Time (s)');
ylabel ('Acceleration (g)');
legend ('Mitigation OFF', 'Mitigation ON');
validTitle ('Simulator CG Accelerations')
grid on
xlim (simRange)
 saveas (gcf, sprintf('%s_SIM_CGAccel.jpg',tprefix))
%%
slvFigure ( 'Simulator Elevator Command');
hold off
plot(simLPSoff.TimeStamp, simLPSoff.ELLOB, OFFCol, 'LineWidth', LW)
hold on
plot(simLPSon.TimeStamp, simLPSon.ELLOB,'Color',  ONCol, 'LineWidth', LW)
xlabel ('Time (s)');
ylabel ('Elevator (deg)');
legend ('Mitigation OFF', 'Mitigation ON');
validTitle ('Simulator Elevator Command')
grid on
xlim (simRange)
saveas (gcf, sprintf('%s_SIM_ELLOB.jpg',tprefix) )

%%
[OFFmv OFFmi] = min(pc104LPSoff.cgaz);
OFFt = pc104LPSoff.time(OFFmi);
[ONmv ONmi] = min(pc104LPSon.cgaz);
ONt = pc104LPSon.time(ONmi);
offset = OFFt - ONt;
pc104LPSon.time = pc104LPSon.time+offset;
plotRange = [OFFt-2 OFFt+2];
ONrange = find(pc104LPSon.time >= plotRange(1) & pc104LPSon.time < plotRange(2));
OFFrange = find(pc104LPSoff.time >= plotRange(1) & pc104LPSoff.time < plotRange(2));
%%
vOFF = pc104LPSoff.cgaz(OFFrange);
%dvOFF = sqrt(dot(vOFF, vOFF)/length(vOFF));
dvOFF = max(abs(vOFF));

sOFF = pc104LPSoff.str(OFFrange);
%dsOFF = sqrt(dot(sOFF, sOFF)/length(sOFF));
dsOFF = max(abs(sOFF));

oOFF = pc104LPSoff.obaz(OFFrange);
%doOFF = sqrt(dot(oOFF, oOFF)/length(oOFF));
doOFF = max(abs(oOFF));

disp(sprintf('%s: without LPS cgaz[%5.3f] str[%5.3f] obaz[%5.3f]',tprefix,dvOFF, dsOFF, doOFF));

vON = pc104LPSon.cgaz(ONrange);
% dvON = sqrt(dot(vON, vON)/length(vON));
dvON = max(abs(vON));

sON = pc104LPSon.str(ONrange);
% dsON = sqrt(dot(sON, sON)/length(sON));
dsON = max(abs(sON));

oON = pc104LPSon.obaz(ONrange);
% doON = sqrt(dot(oON, oON)/length(oON));
doON = max(abs(oON));

disp(sprintf('%s: with LPS cgaz[%5.3f] str[%5.3f] obaz[%5.3f]',tprefix,dvON, dsON, doON));
ddv = dvOFF-dvON;
dds = dsOFF-dsON;
ddo = doOFF-doON;
disp(sprintf('%s: delta: cgaz[%5.3f/%5.3f%%] str[%5.3f/%5.3f%%] obaz[%5.3f/%5.3f%%]'    ...
                ,tprefix     ...
                ,ddv, (100*ddv/dvOFF)  ...
                ,dds, (100*dds/dsOFF)  ...
                ,ddo, (100*ddo/doOFF)  ...
                ) );
            
        
%%
ylimargin = 1.2;
slvFigure ( 'PC104 CG Accelerations');
hold off
plot(pc104LPSoff.time, pc104LPSoff.cgaz, OFFCol , 'LineWidth', LW)
hold on
plot(pc104LPSon.time, pc104LPSon.cgaz,'Color',  ONCol, 'LineWidth', LW)
plot([1,1000], nglimNew*[1 1], ':m', 'LineWidth', 1)
plot([1,1000], pglimNew*[1 1], ':m', 'LineWidth', 1)
xlim (plotRange)
allDat = [pc104LPSoff.cgaz(OFFrange);pc104LPSon.cgaz(ONrange)];
yl = [min(allDat)*ylimargin   max(allDat)*ylimargin];
xlabel ('Time (s)');
ylabel ('Acceleration (g)');
legend ('Mitigation OFF', 'Mitigation ON');
validTitle ('Measured CG Accelerations')
grid on
xl = xlim();
yl = ylim();
text(dot(xl,[.90 1-.90]),dot(yl,[.10 1-.10]),sprintf('Percent change:[%0.1f%%]',(100*ddv/dvOFF))  ...
    ,'FontSize',FS,'Color','k','FontName','Courier')
saveas (gcf, sprintf('%s_PC104_CGAccel.jpg',tprefix))

%%
slvFigure ( 'PC104 OB Accelerations');
hold off
plot(pc104LPSoff.time, pc104LPSoff.obaz, OFFCol , 'LineWidth', LW)
hold on
plot(pc104LPSon.time, pc104LPSon.obaz,'Color',  ONCol, 'LineWidth', LW)
plot([1,1000], nglimNew*[1 1], ':m', 'LineWidth', 1)
plot([1,1000], pglimNew*[1 1], ':m', 'LineWidth', 1)
xlim (plotRange)
xlabel ('Time (s)');
ylabel ('Outboard Acceleration (g)');
legend ('Mitigation OFF', 'Mitigation ON');
validTitle ('Measured Outboard Accelerations')
grid on
saveas (gcf, sprintf('%s_PC104_OBAccel.jpg',tprefix))

%%

slvFigure ('Root Strain ');
hold off
plot(pc104LPSoff.time, pc104LPSoff.str, OFFCol, 'LineWidth', LW)
hold on
plot(pc104LPSon.time, pc104LPSon.str,'Color',  ONCol, 'LineWidth', LW)
grid on
xlim (plotRange)
xlabel ('Time (s)');
ylabel ('Root Strain (\mu\epsilon)');
legend ('Mitigation OFF', 'Mitigation ON');
xl = xlim();
yl = ylim();
text(dot(xl,[.90 1-.90]),dot(yl,[.10 1-.10]),sprintf('Percent change:[%0.1f%%]', (100*dds/dsOFF))  ...
    ,'FontSize',FS,'Color','k','FontName','Courier')
validTitle ('Measured Root Strain');
saveas (gcf, sprintf('%s_PC104_Strain.jpg',tprefix))

%%
% [ONmvP ONmiP] = min(pc104LPSon.cgaz(floor(plotRange(1)): floor(plotRange(2))));
% [ONmvS ONmiS] = min(simLPSon.nzbody(floor(simRange(1)): floor(simRange(2))));
% ONtP = pc104LPSon.time(ONmiP);
% ONtS = simLPSon.TimeStamp(ONmiS);
% dPS = ONtP - ONtS;
% pc104LPSon.time = pc104LPSon.time-dPS;

slvFigure ( 'Sim vs PC104 CG Accelerations');
hold off
plot(pc104LPSon.time-SPon_Offset, pc104LPSon.cgaz, OFFCol , 'LineWidth', LW)
%plot(pc104LPSon.time, pc104LPSon.cgaz, OFFCol , 'LineWidth', LW)
hold on
plot(simLPSon.TimeStamp, simLPSon.nzbody,'Color',  ONCol, 'LineWidth', LW)
plot([1,1000], nglimNew*[1 1], ':m', 'LineWidth', 1)
plot([1,1000], pglimNew*[1 1], ':m', 'LineWidth', 1)
%xlim (plotRange)
xlim (simRange)
xlabel ('Time (s)');
ylabel ('Acceleration (g)');
legend ('Measured Accel', 'Sim Accel');
validTitle ('Simulator CG vs Measured CG Accelerations')
grid on
saveas (gcf, sprintf('%s_sim_PC104_CGAccel.jpg',tprefix))


return