%% function plotForSync()
    file = dir('PC104.mat');
    if ~isempty(file)
        load(file.name)
    else
        PC104 = [];
    end
    
    file = dir('RCATS.mat');
    if ~isempty(file)
        load(file.name)
    else
        RCATS = [];
    end
    
    file = dir('AHRS.mat');
    if ~isempty(file)
        load(file.name)
    else
        AHRS = [];
    end
    
    %%% First alignment attempt
    idx = find(RCATS.DATA.sync>0);
    didx = diff(idx);
    ddidx = find(didx>1);
    if ~isempty(ddidx)
        si = idx(max(ddidx)+1);
    else
        si = min(idx);
    end
    idx = si;
    %idx = find(RCATS.DATA.sync==0,1,'last')+1;
    if isempty(idx)
        idx = 1;
    else
        idx = min(idx,length(RCATS.DATA.sync));
    end
    jdx = find(PC104.DATA.sync>RCATS.DATA.sync(idx),1,'first');
    if isempty(jdx)
        jdx = 4;
    else
        jdx = max(jdx,2);
    end
    p = polyfit(PC104.DATA.sync(jdx-1:jdx),PC104.DATA.time(jdx-1:jdx),1);
    tzc = polyval(p,1.5);
    time_off = RCATS.DATA.time(idx)-tzc;
    disp(sprintf('RCATS sync starts at time(%d) = %f',idx,time_off))
    
    RCATS.DATA.tp1 = RCATS.DATA.tp1-RCATS.DATA.tp1(idx);
    RCATS.DATA.tlf = RCATS.DATA.tlf-RCATS.DATA.tlf(idx);
    RCATS.DATA.tpw = RCATS.DATA.tpw-RCATS.DATA.tpw(idx);
    
    slvFigure('Synchronize PC104 and RCATS using SYNC');
    hold off
    plot(PC104.DATA.time,PC104.DATA.sync)
    ylim([0 3])
    grid on

    hold all
    plot(RCATS.DATA.tp1,RCATS.DATA.sync)
    plot(RCATS.DATA.tlf,RCATS.DATA.sync)
    plot(RCATS.DATA.tpw,RCATS.DATA.sync)
    legend([...
           {'PC104.DATA.sync'} ...
           {'RCATS tp1'} ...
           {'RCATS tlf'} ...
           {'RCATS tpw'} ...
           ])
       
       
    [pnP     pzT] = findZeroCrossings(PC104.DATA.time,PC104.DATA.sync);
    [tp1nP tp1zT] = findZeroCrossings(RCATS.DATA.tp1 ,RCATS.DATA.sync);
    [tlfnP tlfzT] = findZeroCrossings(RCATS.DATA.tlf ,RCATS.DATA.sync);
    [tpwnP tpwzT] = findZeroCrossings(RCATS.DATA.tpw ,RCATS.DATA.sync);
 
    tp1zT = tp1zT(tp1zT>=0);
    tlfzT = tlfzT(tlfzT>=0);
    tpwzT = tpwzT(tpwzT>=0);
    
    tp1nP = floor(length(tp1zT)/2);
    tlfnP = floor(length(tlfzT)/2);
    tpwnP = floor(length(tpwzT)/2);

    disp(sprintf('PC104 %d periods %f(sec)',  pnP, max(pzT)))
    disp(sprintf('RCATS %d periods %f(sec)',tp1nP, max(tp1zT)))
    disp(sprintf('RCATS %d periods %f(sec)',tlfnP, max(tlfzT)))
    disp(sprintf('RCATS %d periods %f(sec)',tpwnP, max(tpwzT)))

    slvFigure('Synchronicity');
    nCross = min([pnP tp1nP tlfnP tpwnP]);
    hold off
    plot(tp1zT(1:nCross)-pzT(1:nCross),':b.')
    hold on
    plot(tlfzT(1:nCross)-pzT(1:nCross),':r.')
    plot(tpwzT(1:nCross)-pzT(1:nCross),':g.')
    grid on


%         idx = find(RCzcTimes>=0);
%         RCzcTimes = RCzcTimes(idx);
%         RCnPeriods = floor(length(RCzcTimes)/2);
%         [PCnPeriods PCzcTimes] = sinePeriods(PC104.DATA.time,PC104.DATA.sync);
%     disp(sprintf('PC104 %d periods %f(sec)',PCnPeriods, max(PCzcTimes)))
%     disp(sprintf('RCATS %d periods %f(sec)',RCnPeriods, max(RCzcTimes)))
%     linkaxes(h,'x')
%     nCross = min(PCnPeriods,RCnPeriods);
% 
%     slvFigure('Synchronicity');
%     plot(RCzcTimes(1:nCross)-PCzcTimes(1:nCross),':b.')

%%return
    