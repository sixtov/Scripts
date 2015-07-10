function seg = FindPC104_TS_LevelFlightSegments(PC104,a,b,c,d,e,f)
    if ~isempty(a), max_roll = a;         else max_roll = 20;        end
    if ~isempty(b), max_pitch = b;        else max_pitch = 8;        end
    if ~isempty(c), min_alt = c;          else min_alt = 500;        end
    if ~isempty(d), max_altroc = d;       else max_altroc = 0.7;     end
    if ~isempty(e), max_yawroc = e;       else max_yawroc = 0.7;     end
    if ~isempty(f), min_seg_duration = f; else min_seg_duration = 8; end
    max_powerroc = 7;

    llf20p = PC104.llf20p_ts;
    ula20p = PC104.ula20p_ts;
    lrf40p = PC104.lrf40p_ts;
    ura40p = PC104.ura40p_ts;
    llf20p.data = [0; diff(llf20p.data)]./[1; diff(llf20p.time)];
    ula20p.data = [0; diff(ula20p.data)]./[1; diff(ula20p.time)];
    lrf40p.data = [0; diff(lrf40p.data)]./[1; diff(lrf40p.time)];
    ura40p.data = [0; diff(ura40p.data)]./[1; diff(ura40p.time)];

    yaw_diff = PC104.hdg_ts;
    yaw_diff.data = [0; diff(yaw_diff.data)]./[1; diff(yaw_diff.time)];
    roll_diff = PC104.roll_ts;
    roll_diff.data = [0; diff(roll_diff.data)]./[1; diff(roll_diff.time)];
    alt_diff = PC104.alt_ts;
    alt_diff.data = [0; diff(alt_diff.data)]./[1; diff(alt_diff.time)];

    idxr = abs(PC104.roll_ts.data) < max_roll;
    idxp = abs(PC104.pitch_ts.data) < max_pitch;
    idxa = abs(PC104.alt_ts.data) > min_alt;
    idxy = abs(yaw_diff.data) < max_yawroc;
    idxar = abs(alt_diff.data) < max_altroc;
    idxllf = abs(llf20p.data) < max_powerroc;
    idxula = abs(ula20p.data) < max_powerroc;
    idxlrf = abs(lrf40p.data) < max_powerroc;
    idxura = abs(ura40p.data) < max_powerroc;
    idx = idxr & idxa & idxp & idxy & idxar; %% & idxllf & idxula & idxlrf & idxura;

    seg = findSegmentsFromLogical(idx);
    nSeg = size(seg,1);
    if (nSeg>1)
        delta_bseg = yaw_diff.time(seg(2:end,1)) - yaw_diff.time(seg(1:end-1,2));
        didx = find(delta_bseg <= 2);
        if (~isempty(didx))
            N = length(didx);
            for i=N:-1:1
%                 seg = [seg([1:i i+2:end],1) seg([1:i-1 i+1:end],2)];
                seg = [seg(1:didx(i)-1,:); [seg(didx(i),1) seg(didx(i)+1,2)]; seg(didx(i)+2:end,:)];
            end
        end
    end
    delta_t = yaw_diff.time(seg(:,2)) - yaw_diff.time(seg(:,1));
    sidx = find(delta_t > min_seg_duration);
    seg = seg(sidx,:);
    nSeg = size(seg,1);
%     tseg = PC104.roll_ts.time(seg);
%     delta_t = delta_t(sidx);
%     N = length(sidx);
    
    slvFigure('Lat/Lon');
    hold off
    x = PC104.lon_ts.data;
    y = PC104.lat_ts.data;
    idx = x<-76;
    x = x(idx);
    y = y(idx);
    plot(x,y,'b');
    grid on
    axis equal
    hold all
    M = size(seg,1);
    x = PC104.lon_ts.data;
    y = PC104.lat_ts.data;
    for i=1:M
        plot(x(seg(i,1):seg(i,2)),y(seg(i,1):seg(i,2)),':.','LineWidth',2);
        slon = x(seg(i,1));
        slat = y(seg(i,1));
        stext = sprintf('S%d',i);
        text(slon,slat,stext,'BackgroundColor',[.7 .9 .7]);
    end
    
    slvFigure('3D Lat/Lon');
    hold off
    x = PC104.lon_ts.data;
    y = PC104.lat_ts.data;
    z = PC104.alt_ts.data;
    idx = x<-76;
    x = x(idx);
    y = y(idx);
    z = z(idx);
    delta = max(max(x)-min(x),max(y)-min(y));
    maxX = (max(x)+min(x))/2+delta/2;
    minX = (max(x)+min(x))/2-delta/2;
    maxY = (max(y)+min(y))/2+delta/2;
    minY = (max(y)+min(y))/2-delta/2;
    
%     disp([x y z])
    plot3(x,y,z,'b');
    grid on
    xlim([minX maxX]);
    ylim([minY maxY]);
    %axis equal
    hold all
    M = size(seg,1);
    x = PC104.lon_ts.data;
    y = PC104.lat_ts.data;
    z = PC104.alt_ts.data;
%     t = MavLink_tsc.APM_ANALOG_EU_chan10.time;
%     Va = MavLink_tsc.APM_ANALOG_EU_chan10.data;
%     Ia = MavLink_tsc.APM_ANALOG_EU_chan10.data;
%     Vf = MavLink_tsc.APM_ANALOG_EU_chan10.data;
%     If = MavLink_tsc.APM_ANALOG_EU_chan10.data;
%     energy = zeros(M,1);
    for i=1:M
        plot3(x(seg(i,1):seg(i,2)),y(seg(i,1):seg(i,2)),z(seg(i,1):seg(i,2)),':.','LineWidth',2);
        slon = x(seg(i,1));
        slat = y(seg(i,1));
        salt = z(seg(i,1));
        stext = sprintf('S%d',i);
        text(slon,slat,salt,stext,'BackgroundColor',[.7 .9 .7]);
%         energy(i) = trapz(t,V.*I);
    end
    
    slvFigure('Flight Variables');
    h = [];
    
    h = [h; subplot(3,2,1)];
    hold off
    plot(PC104.roll_ts.time,PC104.roll_ts.data,'b')
    hold all
    plotSegments(PC104.roll_ts,seg);
    grid on
    ylim(50*[-1 1])
    yTicks = unique(sort([max_roll*[-1 1] 0 ylim]));
    set(gca,'YTick',yTicks);
    title('Roll')

    h = [h; subplot(3,2,2)];
    hold off
    plot(alt_diff.time,alt_diff.data,'b')
    hold all
    plotSegments(alt_diff,seg);
    grid on
    ylim(20*[-1 1])
    yTicks = unique(sort([max_altroc*[-1 1] 0 ylim]));
    set(gca,'YTick',yTicks);
    title('Altitude Slope')

    h = [h; subplot(3,2,3)];
    hold off
    plot(PC104.alt_ts.time,PC104.alt_ts.data,'b')
    hold all
    plotSegments(PC104.alt_ts,seg);
    grid on
    ylim([0 1].*ylim)
    yTicks = unique(sort([min_alt 0 ylim]));
    set(gca,'YTick',yTicks);
    title('Altitude')


%     h = [h; subplot(3,2,3)];
%     hold off
%     plot(MavLink_tsc.APM_ANALOG_EU_chan12.time,MavLink_tsc.APM_ANALOG_EU_chan12.data,'b')
%     hold all
%     plotSegments(MavLink_tsc.APM_ANALOG_EU_chan12,seg);
%     grid on
%     title('RPM')

    h = [h; subplot(3,2,4)];
    hold off
    plot(PC104.hdg_ts.time,PC104.hdg_ts.data,'b')
    hold all
    plotSegments(PC104.hdg_ts,seg);
    grid on
    title('True Heading')

    h = [h; subplot(3,2,5)];
    hold off
    plot(PC104.pitch_ts.time,PC104.pitch_ts.data,'b')
    hold all
    plotSegments(PC104.pitch_ts,seg);
    grid on
    ylim(50*[-1 1])
    yTicks = unique(sort([max_pitch*[-1 1] 0 ylim]));
    set(gca,'YTick',yTicks);
    title('Pitch')

    h = [h; subplot(3,2,6)];
    hold off
    plot(yaw_diff.time,yaw_diff.data,'b')
    hold all
    plotSegments(yaw_diff,seg);
    grid on
    ylim(90*[-1 1])
    yTicks = unique(sort([max_yawroc*[-1 1] 0 ylim]));
    set(gca,'YTick',yTicks);
    title('Heading Slope')

    
    slvFigure('Battery Power');
    h = [h; subplot(2,2,1)];
    hold off
    plot(llf20p.time,llf20p.data,'b')
    hold all
    plotSegments(llf20p,seg);
    grid on
    title('llf20p')

    h = [h; subplot(2,2,2)];
    hold off
    plot(ula20p.time,ula20p.data,'b')
    hold all
    plotSegments(ula20p,seg);
    grid on
    title('ula20p')

    h = [h; subplot(2,2,3)];
    hold off
    plot(lrf40p.time,lrf40p.data,'b')
    hold all
    plotSegments(lrf40p,seg);
    grid on
    title('lrf40p')

    h = [h; subplot(2,2,4)];
    hold off
    plot(ura40p.time,ura40p.data,'b')
    hold all
    plotSegments(ura40p,seg);
    grid on
    title('ura40p')

    linkaxes(h,'x')


%     disp(sprintf(' t_start    t_end duration(s)'));
%     for i=1:M
%         disp(sprintf('S%d: %8.1f %8.1f %6.1f',i,yaw_diff.time(seg(i,1)),yaw_diff.time(seg(i,2)),delta_t(i)))
%     end

return

function plotSegments(var,seg)
    N = size(seg,1);
    for i=1:N
        plot(var.time(seg(i,1):seg(i,2)),var.data(seg(i,1):seg(i,2)),'LineWidth',2)
        stime = var.time(seg(i,1));
        sdata = var.data(seg(i,1));
        stext = sprintf('S%d',i);
        text(stime,sdata,stext,'BackgroundColor',[.7 .9 .7]);
    end
return
