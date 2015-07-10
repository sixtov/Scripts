%%
dfile = 'R3_Flight4_2011-11-10 11-41-28_mavLink.mat';
load(dfile);
tseg = [850.5 1512];
tseg = [817 1507];
plotMavLink(dfile);

% p.t0 = 0;
% p.append = 0;
% p.figure = strcat(dfile,':Fwd Cur vs Throttle');
% p.sel = [];
% p.sel(1).sp = [3 1 1];
% p.sel(1).y = 'RC_CHANNELS_RAW.chan3_raw';
% p.sel(1).unit = 'pwm';
% p.sel(1).ylim = [900 1600];
% p.sel(1).hilite = 'stabilize';
% p.sel(2).sp = [3 1 2];
% p.sel(2).y = 'ANALOG_EU.fwdCurr';
% p.sel(2).unit = 'A';
% p.sel(2).hilite = 'stabilize';
% plotSelection(MavLink,p);
% 
% p.sel = [];
% p.append = 1;
% p.sel(1).sp = [3 1 1];
% p.sel(1).y = [{''}; {'APM_RC_CHANNELS_RAW_chan3_raw.data'}];
% p.sel(1).unit = 'pwm';
% p.sel(1).ylim = [900 1600];
% p.sel(2).sp = [3 1 2];
% p.sel(2).y = [{'junk'}; {'APM_ANALOG_EU_fwdCurr.data'}];
% p.sel(2).unit = 'A';
% p.sel(3).sp = [3 1 3];
% p.sel(3).x = 'APM_RC_CHANNELS_RAW_chan3_raw.data';
% p.sel(3).y = 'APM_ANALOG_EU_fwdCurr.data';
% p.sel(3).unit = 'A';
% plotSelection(MavLink_tsc,p);

%%
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time;
    idx = find(time>=tseg(1) & time<=tseg(2));
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time(idx);
    chan3 = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx);
    rpm = MavLink_tsc.APM_ANALOG_EU_RPM.data(idx);
    fcu = MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx);
    acu = MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx);
    air = MavLink_tsc.APM_VFR_HUD_airspeed.data(idx);
    
%%
dfile = 'R3_Flight5_2011-11-10 12-45-10_mavLink.mat';
load(dfile);
tseg = [350 1027];
tseg = [345 1016];
plotMavLink(dfile);

%%
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time;
    idx = find(time>=tseg(1) & time<=tseg(2));
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time(idx);
    chan3 = [chan3; MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx)];
    rpm = [rpm; MavLink_tsc.APM_ANALOG_EU_RPM.data(idx)];
    fcu = [fcu; MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx)];
    acu = [acu; MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx)];
    air = [air; MavLink_tsc.APM_VFR_HUD_airspeed.data(idx)];
    
%%
dfile = 'R3_Flight6_2011-11-10 01-50-13_mavLink.mat';
load(dfile);
tseg = [197 532; 760 1125];
tseg = [184 510; 700 1130];
plotMavLink(dfile);

%%
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time;
    idx = find((time>=tseg(1,1) & time<=tseg(1,2)) | (time>=tseg(2,1) & time<=tseg(2,2)));
    time = MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.time(idx);
    chan3 = [chan3; MavLink_tsc.APM_RC_CHANNELS_RAW_chan3_raw.data(idx)];
    rpm = [rpm; MavLink_tsc.APM_ANALOG_EU_RPM.data(idx)];
    fcu = [fcu; MavLink_tsc.APM_ANALOG_EU_fwdCurr.data(idx)];
    acu = [acu; MavLink_tsc.APM_ANALOG_EU_aftCurr.data(idx)];
    air = [air; MavLink_tsc.APM_VFR_HUD_airspeed.data(idx)];
    
%%
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
    airout  = zeros(L,1);
    airoutm = zeros(L,1);
    airmax  = zeros(L,1);
    airmin  = zeros(L,1);
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

            airout(i) = mean(air(idx));
            airoutm(i)= median(air(idx));
            airmax(i) = max(air(idx));
            airmin(i) = min(air(idx));
            
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
            airout(i) = NaN;
            airoutm(i)= NaN;
            airmax(i) = NaN;
            airmin(i) = NaN;
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
    airout  = airout(ilist);
    airoutm = airoutm(ilist);
    airmax  = airmax(ilist);
    airmin  = airmin(ilist);

    slvFigure('Performance');
    subplot(4,1,1)
    hold off
    plot(xout,fout, 'b.');
    hold on
    plot(chan3,fcu,'bo');
    plot(xout,foutm, ':ro');
    plot(xout,fmax, 'c');
    plot(xout,fmin, 'c');
    grid on;
    ylabel('Fwd Current','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Fwd Current vs Throttle','FontWeight','bold','FontSize',12);
    p = polyfit(xout,fout,2);
    disp(sprintf('p = [%f %f %f];',p))
    ffit = polyval(p,xout);
    plot(xout,ffit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)

    subplot(4,1,2)
    hold off
    plot(xout,aout, ':b.');
    hold on
    plot(chan3,acu,'bo');
    plot(xout,aoutm, ':ro');
    plot(xout,amax, 'c');
    plot(xout,amin, 'c');
    grid on;
    ylabel('Aft Current','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Aft Current vs Throttle','FontWeight','bold','FontSize',12);
    p = polyfit(xout,aout,2);
    disp(sprintf('p = [%f %f %f];',p))
    afit = polyval(p,xout);
    plot(xout,afit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)

    subplot(4,1,3)
    hold off
    plot(xout,rout, ':b.');
    hold on
    plot(chan3,rpm,'bo');
    plot(xout,routm, ':ro');
    plot(xout,rmax, 'c');
    plot(xout,rmin, 'c');
    grid on;
    ylabel('RPM','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('RPM vs Throttle','FontWeight','bold','FontSize',12);
    %p = [0 0 6000] - polyfit(xout,6000-rout,2);
    p = polyfit(xout,rout,2);
    disp(sprintf('p = [%f %f %f];',p))
    rfit = polyval(p,xout);
    plot(xout,rfit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)

    subplot(4,1,4)
    hold off
    plot(xout,airout, ':b.');
    hold on
    plot(chan3,air,'bo');
    plot(xout,airoutm, ':ro');
    plot(xout,airmax, 'c');
    plot(xout,airmin, 'c');
    grid on;
    ylabel('Airspeed','FontWeight','bold','FontSize',8)
    xlabel('Throttle (pwm)','FontWeight','bold','FontSize',8)
    title('Airspeed vs Throttle','FontWeight','bold','FontSize',12);
    p = polyfit(xout(1:end-2),airout(1:end-2),2);
    disp(sprintf('p = [%f %f %f];',p))
    %disp([xout airout]);
    airfit = polyval(p,xout);
    plot(xout,airfit,'r','LineWidth',2);
    xlim(pwmLim);
    set(gca,'xtick',throttlePWM)
