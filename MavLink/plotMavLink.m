%%
function plotMavLink(file,mode)
    global t0;
    global dfile;
    if (~exist('mode','var'))
        mode = 'all';
    end
    if ischar(file)
        load(file);
        dfile = file;
    else
        MavLink = file;
        dfile = 'Unknown File';
    end
    if isfield(MavLink,'STATUSTEXT')
        idx = length(MavLink.STATUSTEXT.severity);
        t0 = MavLink.STATUSTEXT.time(idx);
    else
        t0 = 0;
    end
    t0 = 0;
    plotCustom(MavLink_tsc,mode);
%     plotModes(MavLink);
%     plotPitchData(MavLink,mode);
%     plotAttitude(MavLink,mode);
%     plotRollPitch(MavLink,mode);
%     plotMotorData(MavLink,MavLink_tsc,mode);
%     plotAirData(MavLink,MavLink_tsc,mode);
return

%%
function plotCustom(S,mode)
global dfile;
    odx = getModeSections(S,mode);
%     slvFigure('Custom');
%     subplot(3,1,1)
%     hold off
%     plot(S.APM_ATTITUDE_yaw.time(odx),mod(S.APM_ATTITUDE_yaw.data(odx),360),'b:.')
%     hold on
%     plot(S.APM_GPS_RAW_hdg.time(odx),mod(S.APM_GPS_RAW_hdg.data(odx),360),'r:.')
%     grid on
%     subplot(3,1,2)
%     hold off
%     time = S.APM_ATTITUDE_yaw.time(odx);
%     error = mod(S.APM_GPS_RAW_hdg.data(odx),360) - mod(S.APM_ATTITUDE_yaw.data(odx),360);
%     error(error >  180) = error(error >  180) - 360;
%     error(error < -180) = error(error < -180) + 360;
%     plot(time,error,'b:.')
%     grid on
%     subplot(3,1,3)
%     hold off
%     plot(mod(S.APM_GPS_RAW_hdg.data(odx),360),mod(S.APM_ATTITUDE_yaw.data(odx),360),':.')
%     grid on
    
    %     plot(S..time,S..data,'b:.')
    h = [];
    slvFigure(dfile);
    h = subplot(3,1,1);
    hold off
    plot(S.APM_NAV_CONTROLLER_OUTPUT_target_bearing.time,mod(S.APM_NAV_CONTROLLER_OUTPUT_target_bearing.data,360),'y:.')
    hold on
    plot(S.APM_NAV_CONTROLLER_OUTPUT_nav_bearing.time,mod(S.APM_NAV_CONTROLLER_OUTPUT_nav_bearing.data,360),'g:.')
    plot(S.APM_ATTITUDE_yaw.time,mod(S.APM_ATTITUDE_yaw.data,360),'r:.')
    plot(S.APM_GPS_RAW_hdg.time,mod(S.APM_GPS_RAW_hdg.data,360),'k:.')
    plot(S.APM_GPS_RAW_hdg.time,360*odx,'c:.')
%     plot(S..time,S..data,':.')
    grid on

    h = [h subplot(3,1,2)];
    hold off
    plot(S.APM_NAV_CONTROLLER_OUTPUT_nav_roll.time,S.APM_NAV_CONTROLLER_OUTPUT_nav_roll.data,'g:.')
    hold on
    plot(S.APM_ATTITUDE_roll.time,S.APM_ATTITUDE_roll.data,'r:.')
    plot(S.APM_GPS_RAW_hdg.time,60*odx,'c:.')
    grid on
    
    h = [h subplot(3,1,3)];
    hold off
    error = S.APM_NAV_CONTROLLER_OUTPUT_nav_roll.data - S.APM_ATTITUDE_roll.data;
    plot(S.APM_ATTITUDE_roll.time,error,'g:.')
    hold on
    plot(S.APM_SERVO_OUTPUT_RAW_servo1_raw.time,(S.APM_SERVO_OUTPUT_RAW_servo1_raw.data-1500)/4,'r:.')
    plot(S.APM_GPS_RAW_hdg.time,20*odx,'c:.')
    grid on
    
    linkaxes(h,'x');
    
return

%%
function [odx] = getModeSections(S,mode)
    %odx1 = ((S.APM_VFR_HUD_airspeed.data > 5) & (S.APM_VFR_HUD_alt.data > 20));
    %odx2 = [];
    switch (lower(mode))
        case 'all'
            odx2 = ones(size(S.APM_SYS_STATUS_mode.data));
        case 'manual'
            odx2 = ((S.APM_SYS_STATUS_mode.data==2));
        case 'stabilize'
            odx2 = ((S.APM_SYS_STATUS_mode.data==5));
        case 'fbwa'
            odx2 = ((S.APM_SYS_STATUS_mode.data==6) & (S.APM_SYS_STATUS_nav_mode.data==1));
        case 'fbwb'
            odx2 = ((S.APM_SYS_STATUS_mode.data==6) & (S.APM_SYS_STATUS_nav_mode.data==2));
        case 'rtl'
            odx2 = ((S.APM_SYS_STATUS_mode.data==4) & (S.APM_SYS_STATUS_nav_mode.data==5));
        case 'auto'
            odx2 = ((S.APM_SYS_STATUS_mode.data==4) & (S.APM_SYS_STATUS_nav_mode.data==3));
        otherwise
            odx2 = ((S.APM_SYS_STATUS_mode.data==-1));
    end
    %odx = odx1 & odx2;
    odx = odx2;
return

%%
function plotPitchData(S,mode)
global t0;
global dfile;
    p.t0 = t0;
    p.figure = strcat(dfile,':Pitch Data');
    
    p.sel(1).sp = [4 1 1];
    p.sel(1).y = [{'ATTITUDE.pitch'}; ...
                  {'NAV_CONTROLLER_OUTPUT.nav_pitch'}];
    p.sel(1).unit = 'degrees';
    p.sel(1).hilite = mode;
    
    p.sel(2).sp = [4 1 2];
    if (isfield(S,'ANALOG_EU'))
        S.ANALOG_EU.left_elev = -S.ANALOG_EU.left_elev;
        p.sel(2).y = [{'ANALOG_EU.left_elev'}; ...
                      {'ANALOG_EU.right_elev'}];
    else
        p.sel(2).y = [{'ATTITUDE.pitch'}; ...
                      {'NAV_CONTROLLER_OUTPUT.nav_pitch'}];
    end
    p.sel(2).unit = 'degrees';
    p.sel(2).hilite = mode;
    
    p.sel(3).sp = [4 1 3];
    p.sel(3).y = [{'RC_CHANNELS_RAW.chan2_raw'}; ...
                  {'RC_CHANNELS_RAW.chan3_raw'}];
    p.sel(3).unit = 'PWM';
    p.sel(3).hilite = mode;

    MANUAL       = (S.SYS_STATUS.mode==2);
    STABILIZE    = (S.SYS_STATUS.mode==5);
    FBWA         = (S.SYS_STATUS.mode==6 & S.SYS_STATUS.nav_mode==1);
    FBWB         = (S.SYS_STATUS.mode==6 & S.SYS_STATUS.nav_mode==2);
    AUTO         = (S.SYS_STATUS.mode==4 & S.SYS_STATUS.nav_mode==3);
    RTL          = (S.SYS_STATUS.mode==4 & S.SYS_STATUS.nav_mode==5);
    INITIALISING = (S.SYS_STATUS.mode==0 & S.SYS_STATUS.nav_mode==0);
    S.SYS_STATUS.control_mode = -1*ones(size(S.SYS_STATUS.mode));
    S.SYS_STATUS.control_mode(MANUAL) = 0;
    S.SYS_STATUS.control_mode(STABILIZE) = 2;
    S.SYS_STATUS.control_mode(FBWA) = 5;
    S.SYS_STATUS.control_mode(FBWB) = 6;
    S.SYS_STATUS.control_mode(AUTO) = 10;
    S.SYS_STATUS.control_mode(RTL) = 11;
    S.SYS_STATUS.control_mode(INITIALISING) = 16;
    p.sel(4).sp = [4 1 4];
    p.sel(4).y = [{'SYS_STATUS.control_mode'}];
    p.sel(4).unit = 'enum';
    p.sel(4).ylim = [-2 17];
    p.sel(4).YTick = [-1 0 1 2 5 6 10 11 12 15 16];
    p.sel(4).YTickLabel = ...
        [{'UNDEF'} ...
         {'MANUAL=0'} ...
         {'CIRCLE=1'} ...
         {'STABILIZE=2'} ...
         {'FLY_BY_WIRE_A=5'} ...
         {'FLY_BY_WIRE_B=6'} ...
         {'AUTO=10'} ...
         {'RTL=11'} ...
         {'LOITER=12'} ...
         {'GUIDED=15'} ...
         {'INITIALISING=16'}];
    plotSelection(S,p);
return

%%
function plotModes(S)
global t0;
global dfile;


    p.t0 = t0;
    p.figure = strcat(dfile,':Modes');
    
    p.sel(4).sp = [4 1 1];
    p.sel(4).y = [{'RC_CHANNELS_RAW.chan3_raw'}; ...
                  {'RC_CHANNELS_RAW.chan8_raw'}];
    p.sel(4).unit = 'PWM';
    %p.sel(4).hilite = mode;

    p.sel(1).sp = [4 1 2];
    p.sel(1).y = [{'SYS_STATUS.mode'}];
    p.sel(1).unit = 'enum';
    p.sel(1).ylim = [0 9];
    p.sel(1).YTick = [0:9];
    p.sel(1).YTickLabel = ...
        [{'MAV_MODE_UNINIT=0'} ...
         {'MAV_MODE_LOCKED=1'} ...
         {'MAV_MODE_MANUAL=2'} ...
         {'MAV_MODE_GUIDED=3'} ...
         {'MAV_MODE_AUTO=4'} ...
         {'MAV_MODE_TEST1=5'} ...
         {'MAV_MODE_TEST2=6'} ...
         {'MAV_MODE_TEST3=7'} ...
         {'MAV_MODE_READY=8'} ...
         {'MAV_MODE_RC_TRAINING=9'}];
    p.sel(2).sp = [4 1 3];
    p.sel(2).y = [{'SYS_STATUS.nav_mode'}];
    p.sel(2).unit = 'enum';
    p.sel(2).ylim = [0 9];
    p.sel(2).YTick = [0:9];
    p.sel(2).YTickLabel = ...
        [{'MAV_NAV_GROUNDED=0'} ...
         {'MAV_NAV_LIFTOFF=1'} ...
         {'MAV_NAV_HOLD=2'} ...
         {'MAV_NAV_WAYPOINT=3'} ...
         {'MAV_NAV_VECTOR=4'} ...
         {'MAV_NAV_RETURNING=5'} ...
         {'MAV_NAV_LANDING=6'} ...
         {'MAV_NAV_LOST=7'} ...
         {'MAV_NAV_LOITER=8'} ...
         {'MAV_NAV_FREE_DRIFT=9'}];
%     p.sel(3).sp = [2 3 3];
%     p.sel(3).y = [{'SYS_STATUS.status'}];
%     p.sel(3).unit = 'enum';
%     p.sel(3).ylim = [0 8];
%     p.sel(3).YTick = [0:8];
%     p.sel(3).YTickLabel = ...
%         [{'MAV_STATE_UNINIT=0'} ...
%          {'MAV_STATE_BOOT=1'} ...
%          {'MAV_STATE_CALIBRATING=2'} ...
%          {'MAV_STATE_STANDBY=3'} ...
%          {'MAV_STATE_ACTIVE=4'} ...
%          {'MAV_STATE_CRITICAL=5'} ...
%          {'MAV_STATE_EMERGENCY=6'} ...
%          {'MAV_STATE_HILSIM=7'} ...
%          {'MAV_STATE_POWEROFF=8'}];
     MANUAL       = (S.SYS_STATUS.mode==2);
     STABILIZE    = (S.SYS_STATUS.mode==5);
     FBWA         = (S.SYS_STATUS.mode==6 & S.SYS_STATUS.nav_mode==1);
     FBWB         = (S.SYS_STATUS.mode==6 & S.SYS_STATUS.nav_mode==2);
     AUTO         = (S.SYS_STATUS.mode==4 & S.SYS_STATUS.nav_mode==3);
     RTL          = (S.SYS_STATUS.mode==4 & S.SYS_STATUS.nav_mode==5);
     INITIALISING = (S.SYS_STATUS.mode==0 & S.SYS_STATUS.nav_mode==0);
     S.SYS_STATUS.control_mode = -1*ones(size(S.SYS_STATUS.mode));
     S.SYS_STATUS.control_mode(MANUAL) = 0;
     S.SYS_STATUS.control_mode(STABILIZE) = 2;
     S.SYS_STATUS.control_mode(FBWA) = 5;
     S.SYS_STATUS.control_mode(FBWB) = 6;
     S.SYS_STATUS.control_mode(AUTO) = 10;
     S.SYS_STATUS.control_mode(RTL) = 11;
     S.SYS_STATUS.control_mode(INITIALISING) = 16;
     p.sel(3).sp = [4 1 4];
     p.sel(3).y = [{'SYS_STATUS.control_mode'}];
     p.sel(3).unit = 'enum';
    p.sel(3).ylim = [-2 17];
    p.sel(3).YTick = [-1 0 1 2 5 6 10 11 12 15 16];
    p.sel(3).YTickLabel = ...
         [{'UNDEF'} ...
          {'MANUAL=0'} ...
          {'CIRCLE=1'} ...
          {'STABILIZE=2'} ...
          {'FLY_BY_WIRE_A=5'} ...
          {'FLY_BY_WIRE_B=6'} ...
          {'AUTO=10'} ...
          {'RTL=11'} ...
          {'LOITER=12'} ...
          {'GUIDED=15'} ...
          {'INITIALISING=16'}];
     plotSelection(S,p);
return

%%
function plotRollPitch(S,mode)
global t0;
global dfile;
    p.t0 = t0;
    p.figure = strcat(dfile,':Roll&Pitch');
    
    p.sel(1).sp = [3 1 1];
    %if (exist('S.ANALOG_EU','var'))
    if (isfield(S,'ANALOG_EU'))
        S.ANALOG_EU.right_ail = -S.ANALOG_EU.right_ail;
        p.sel(1).y = [{'ATTITUDE.roll'}; ...
                      {'ANALOG_EU.left_ail'}; ...
                      {'ANALOG_EU.right_ail'}];
    else
        p.sel(1).y = [{'ATTITUDE.roll'}];
    end
    p.sel(1).unit = 'degrees';
    p.sel(1).hilite = mode;
    p.sel(2).sp = [3 1 2];
    %if (exist('S.ANALOG_EU','var'))
    if (isfield(S,'ANALOG_EU'))
        p.sel(2).y = [{'ATTITUDE.pitch'}; ...
                      {'ANALOG_EU.left_elev'}; ...
                      {'ANALOG_EU.right_elev'}];
    else
        p.sel(2).y = [{'ATTITUDE.pitch'}];
    end
    p.sel(2).unit = 'degrees';
    p.sel(2).hilite = mode;
    p.sel(3).sp = [3 1 3];
    %if (exist('S.ANALOG_EU','var'))
    if (isfield(S,'ANALOG_EU'))
        p.sel(3).y = [{'ATTITUDE.yaw'}; ...
                      {'GPS_RAW.hdg'}; ...
                      {'ANALOG_EU.rudder'}];
    else
        p.sel(3).y = [{'ATTITUDE.yaw'}; ...
                      {'GPS_RAW.hdg'}];
    end
    p.sel(3).unit = 'degrees';
    p.sel(3).hilite = mode;
    plotSelection(S,p);
return

%%
function plotAttitude(S,mode)
global t0;
global dfile;
    p.t0 = t0;
    p.figure = strcat(dfile,':ATTITUDE');

    p.sel(1).sp = [3 1 1];
    p.sel(1).y = [{'ATTITUDE.roll'}];
    p.sel(1).unit = 'degrees';
    p.sel(1).hilite = mode;
    
    p.sel(2).sp = [3 1 2];
    p.sel(2).y = [{'ATTITUDE.pitch'}];
    p.sel(2).unit = 'degrees';
    p.sel(2).hilite = mode;
    
    p.sel(3).sp = [3 1 3];
    p.sel(3).y = [{'ATTITUDE.yaw'}; ...
                  {'GPS_RAW.hdg'}];
    p.sel(3).unit = 'degrees';
    plotSelection(S,p);
return

%%
function plotAirData(S,S_tsc,mode)
global t0;
global dfile;
    p.t0 = t0;
    p.figure = strcat(dfile,':VFR_HUD');

%     S.VFR_HUD.windspeed = S.VFR_HUD.airspeed - S.VFR_HUD.groundspeed;
    
%     STANDARD_SPEED = 15; % meters/second
    STANDARD_SPEED = 30;   % meters/second
    mps2knots = 1.94384449;
    scaler = double(S.VFR_HUD.airspeed);
    scaler = (STANDARD_SPEED * mps2knots) ./ scaler;
    scaler(scaler>2.0) = 2.0;
    scaler(scaler<0.5) = 0.5;
    S.VFR_HUD.s_scaler = scaler;

    THROTTLE_CRUISE = 45;  % percent THROTTLE
    percent2double = 0.01;
    scaler = double(S.SERVO_OUTPUT_RAW.servo3_raw);
    %scaler = 0.5 + 2 * ((THROTTLE_CRUISE*percent2double*(1521-1234)+1234) ./ scaler);
    scaler = ((THROTTLE_CRUISE*percent2double*(1521-1234)+1234) ./ scaler);
    scaler(scaler>1.67) = 1.67;
    scaler(scaler<0.60) = 0.60;
    S.SERVO_OUTPUT_RAW.t_scaler = scaler;
    
    p.sel(1).sp = [2 1 1];
    p.sel(1).y = [{'VFR_HUD.airspeed'}; ...
                  {'VFR_HUD.groundspeed'}];
    p.sel(1).unit = 'knots';
    p.sel(1).hilite = mode;
    
    p.sel(2).sp = [2 1 2];
    p.sel(2).y = [{'VFR_HUD.s_scaler'}; ...
                  {'SERVO_OUTPUT_RAW.t_scaler'}];
    p.sel(2).unit = 'gain';
    p.sel(2).hilite = mode;
    plotSelection(S,p);

    
    p.figure = strcat(dfile,':Air Data');
    p.sel = [];
    p.sel(1).sp = [1 1 1];
%     p.sel(1).x = 'APM_RC_CHANNELS_RAW_chan3_raw.data';
    p.sel(1).x = 'APM_SERVO_OUTPUT_RAW_servo3_raw.data';
    p.sel(1).y = 'APM_VFR_HUD_airspeed.data';
    p.sel(1).unit = 'knots';
    plotSelection(S_tsc,p);
    
%%%
    chan3 = S_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data;
    aspd = S_tsc.APM_VFR_HUD_airspeed.data;
    throttlePWM = [1234; ...
                   1298; ...
                   1304; ...
                   1312; ...
                   1323; ...
                   1336; ...
                   1351; ...
                   1365; ...
                   1384; ...
                   1402; ...
                   1419; ...
                   1440; ...
                   1459; ...
                   1478; ...
                   1496; ...
                   1518];
    pwmLim = [min(throttlePWM) max(throttlePWM)];
    xout = throttlePWM;
    dx = diff(xout)/2;
    dx0 = [dx(1); dx];
    dx1 = [dx; dx(end)];
    bins = [xout-dx0 xout+dx1];
    L = length(xout);
    ilist = zeros(L,1);
    aout  = zeros(L,1);
    aoutm = zeros(L,1);
    amax  = zeros(L,1);
    amin  = zeros(L,1);
    nidx  = 0;
    
    for i=1:L
        idx = find((chan3 >= bins(i,1)) & (chan3 <= bins(i,2)));
        if ~isempty(idx)
            aout(i) = mean(aspd(idx));
            aoutm(i)= median(aspd(idx));
            amax(i) = max(aspd(idx));
            amin(i) = min(aspd(idx));
            if (~isnan(aout(i)) && ~isnan(aoutm(i)))
                ilist(i) = i;
            else
                nidx = i;
            end
        else
            aout(i) = NaN;
            aoutm(i)= NaN;
            amax(i) = NaN;
            amin(i) = NaN;
            nidx = i;
        end
        disp(sprintf('[%d/%d] = (%d,%d)',round([i L xout(i) aout(i)])))
    end
    %ilist = ilist(ilist>nidx);
    ilist = ilist(ilist>0);
    xout  = xout(ilist);
    aout  = aout(ilist);
    aoutm = aoutm(ilist);
    amax  = amax(ilist);
    amin  = amin(ilist);

    subplot(1,1,1)
    plot(xout,aout, ':b.');
    plot(xout,aoutm, ':ro');
    plot(xout,amax, 'c');
    plot(xout,amin, 'c');
    grid on;
    ylabel('Airspeed (knots)','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Airspeed vs Throttle','FontWeight','bold','FontSize',12);
%     p = polyfit(xout,aout,2);
p = [0.000705 -1.709072 1036.778008];
p = [-0.000951 2.746216 -1921.551508];
p = [-0.000698 2.067917 -1466.403278];
    disp(sprintf('y = %f*x^2 + %f*x + %f',p))
    ffit = polyval(p,xout);
    plot(xout,ffit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)
return

%%
function plotMotorData(S,S_tsc,mode)
global t0;
global dfile;

if (isfield(S,'ANALOG_EU'))
    p.t0 = t0;
    p.figure = strcat(dfile,':Motor Data');

    p.sel(1).sp = [4 1 1];
%     p.sel(1).y = 'RC_CHANNELS_RAW.chan3_raw';
    p.sel(1).y = 'SERVO_OUTPUT_RAW.servo3_raw';
    p.sel(1).unit = 'pwm';
    p.sel(1).ylim = [900 1600];
    p.sel(1).hilite = mode;
    p.sel(2).sp = [4 1 2];
    p.sel(2).y = [{'ANALOG_EU.fwdCurr'}; ...
                  {'ANALOG_EU.aftCurr'}];
    p.sel(2).unit = 'A';
    p.sel(2).hilite = mode;
    p.sel(3).sp = [4 1 3];
    p.sel(3).y = 'ANALOG_EU.RPM';
    p.sel(3).hilite = mode;
    p.sel(4).sp = [4 1 4];
    p.sel(4).y = 'ANALOG_EU.mtrTemp';
    p.sel(4).unit = 'degF';
    p.sel(4).hilite = mode;
    plotSelection(S,p);
    
    p.figure = strcat(dfile,':Power Plant');
    p.sel = [];
    p.sel(1).sp = [3 1 1];
    p.sel(1).x = 'APM_SERVO_OUTPUT_RAW_servo3_raw.data';
    p.sel(1).y = 'APM_ANALOG_EU_fwdCurr.data';
    p.sel(1).unit = 'A';
    
    p.sel(2).sp = [3 1 2];
    p.sel(2).x = 'APM_SERVO_OUTPUT_RAW_servo3_raw.data';
    p.sel(2).y = 'APM_ANALOG_EU_aftCurr.data';
    p.sel(2).unit = 'A';
    
    p.sel(3).sp = [3 1 3];
    p.sel(3).x = 'APM_SERVO_OUTPUT_RAW_servo3_raw.data';
    p.sel(3).y = 'APM_ANALOG_EU_RPM.data';
    plotSelection(S_tsc,p);
    
%%%
%     [chan3 idx] = sort(S_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data);
%     cdx = idx(S_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data>=1234);
%     chan3 = S_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(cdx);
%     rpm = S_tsc.APM_ANALOG_EU_RPM.data(cdx);
%     fcu = S_tsc.APM_ANALOG_EU_fwdCurr.data(cdx);
%     acu = S_tsc.APM_ANALOG_EU_aftCurr.data(cdx);
    chan3 = S_tsc.APM_SERVO_OUTPUT_RAW_servo3_raw.data .* S_tsc.APM_ANALOG_EU_MUX.data;
    rpm = S_tsc.APM_ANALOG_EU_RPM.data                 .* S_tsc.APM_ANALOG_EU_MUX.data;
    fcu = S_tsc.APM_ANALOG_EU_fwdCurr.data             .* S_tsc.APM_ANALOG_EU_MUX.data;
    acu = S_tsc.APM_ANALOG_EU_aftCurr.data             .* S_tsc.APM_ANALOG_EU_MUX.data;
    throttlePWM = [1234; ...
                   1298; ...
                   1304; ...
                   1312; ...
                   1323; ...
                   1336; ...
                   1351; ...
                   1365; ...
                   1384; ...
                   1402; ...
                   1419; ...
                   1440; ...
                   1459; ...
                   1478; ...
                   1496; ...
                   1518];
    pwmLim = [min(throttlePWM) max(throttlePWM)];
    xout = throttlePWM;
    dx = diff(xout)/2;
    dx0 = [dx(1); dx];
    dx1 = [dx; dx(end)];
    bins = [xout-dx0 xout+dx1];
    L = length(xout);
    ilist = zeros(L,1);
    rout  = zeros(L,1);
    routm = zeros(L,1);
    rmax  = zeros(L,1);
    rmin  = zeros(L,1);
    fout  = zeros(L,1);
    foutm = zeros(L,1);
    fmax  = zeros(L,1);
    fmin  = zeros(L,1);
    aout  = zeros(L,1);
    aoutm = zeros(L,1);
    amax  = zeros(L,1);
    amin  = zeros(L,1);
    nidx  = 0;
    
    for i=1:L
%         slvFigure('Show Bin');
%         plot(chan3,':.')
%         set(gca,'ytick',unique(sort([bins(:)])));
%         ylim([bins(i,1)-50 bins(i,2)+50]);
%         grid on;
        idx = find((chan3 >= bins(i,1)) & (chan3 <= bins(i,2)));
        if ~isempty(idx)
            rout(i) = mean(rpm(idx));
            routm(i)= median(rpm(idx));
            rmax(i) = max(rpm(idx));
            rmin(i) = min(rpm(idx));

            fout(i) = mean(fcu(idx));
            foutm(i)= median(fcu(idx));
            fmax(i) = max(fcu(idx));
            fmin(i) = min(fcu(idx));

            aout(i) = mean(acu(idx));
            aoutm(i)= median(acu(idx));
            amax(i) = max(acu(idx));
            amin(i) = min(acu(idx));
            if (~isnan(rout(i)) && ~isnan(routm(i)))
                ilist(i) = i;
            else
                nidx = i;
            end
        else
            rout(i) = NaN;
            routm(i)= NaN;
            rmax(i) = NaN;
            rmin(i) = NaN;
            fout(i) = NaN;
            foutm(i)= NaN;
            fmax(i) = NaN;
            fmin(i) = NaN;
            aout(i) = NaN;
            aoutm(i)= NaN;
            amax(i) = NaN;
            amin(i) = NaN;
            nidx = i;
        end
        disp(sprintf('[%d/%d] = (%d,%d)',round([i L xout(i) rout(i)])))
    end
    %ilist = ilist(ilist>nidx);
    ilist = ilist(ilist>0);
    xout  = xout(ilist);
    rout  = rout(ilist);
    routm = routm(ilist);
    rmax  = rmax(ilist);
    rmin  = rmin(ilist);
    fout  = fout(ilist);
    foutm = foutm(ilist);
    fmax  = fmax(ilist);
    fmin  = fmin(ilist);
    aout  = aout(ilist);
    aoutm = aoutm(ilist);
    amax  = amax(ilist);
    amin  = amin(ilist);

    subplot(3,1,1)
    plot(xout,fout, ':b.');
    plot(xout,foutm, ':ro');
    plot(xout,fmax, 'c');
    plot(xout,fmin, 'c');
    grid on;
    ylabel('Fwd Current','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Fwd Current vs Throttle','FontWeight','bold','FontSize',12);
    %p = polyfit(xout,fout,2);
p = [0.000705 -1.709072 1036.778008];
p = [0.000727 -1.774961 1084.305108];
    disp(sprintf('y = %f*x^2 + %f*x + %f',p))
    ffit = polyval(p,xout);
    plot(xout,ffit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)

    subplot(3,1,2)
    plot(xout,aout, ':b.');
    plot(xout,aoutm, ':ro');
    plot(xout,amax, 'c');
    plot(xout,amin, 'c');
    grid on;
    ylabel('Aft Current','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Aft Current vs Throttle','FontWeight','bold','FontSize',12);
    %p = polyfit(xout,aout,2);
p = [0.000879 -2.205417 1385.823028];
p = [0.000806 -2.020726 1268.711857];
    disp(sprintf('y = %f*x^2 + %f*x + %f',p))
    afit = polyval(p,xout);
    plot(xout,afit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)

    subplot(3,1,3)
    plot(xout,rout, ':b.');
    plot(xout,routm, ':ro');
    plot(xout,rmax, 'c');
    plot(xout,rmin, 'c');
    grid on;
    ylabel('RPM','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('RPM vs Throttle','FontWeight','bold','FontSize',12);
    %p = [0 0 6000] - polyfit(xout,6000-rout,2);
p = [-0.048725 152.426609 -113339.562283];
p = [-0.035391 112.300920 -83181.854513];
    disp(sprintf('y = %f*x^2 + %f*x + %f',p))
    rfit = polyval(p,xout);
    plot(xout,rfit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)
end
return
                    