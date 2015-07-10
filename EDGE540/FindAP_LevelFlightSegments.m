%%
function seg = FindAP_LevelFlightSegments(dfile,a,b,c,d,e,f)
    load(dfile);
    if ~isempty(a)
        max_roll = a;
    else
        max_roll = 20;
    end
    if ~isempty(b)
        max_pitch = b;
    else
        max_pitch = 8;
    end
    if ~isempty(c)
        min_alt = c;
    else
        min_alt = 500;
    end
    if ~isempty(d)
        max_altroc = d;
    else
        max_altroc = 0.7;
    end
    if ~isempty(e)
        max_yawroc = e;
    else
        max_yawroc = 0.7;
    end
    if ~isempty(f)
        min_seg_duration = f;
    else
        min_seg_duration = 8;
    end

    yaw_diff = MavLink_tsc.APM_ATTITUDE_yaw;
    yaw_diff.data = [0; diff(MavLink_tsc.APM_ATTITUDE_yaw.data)];
    roll_diff = MavLink_tsc.APM_ATTITUDE_roll;
    roll_diff.data = [0; diff(MavLink_tsc.APM_ATTITUDE_roll.data)];
    alt_diff = MavLink_tsc.APM_GPS_RAW_alt;
    alt_diff.data = [0; diff(MavLink_tsc.APM_GPS_RAW_alt.data)];

    idxr = abs(MavLink_tsc.APM_ATTITUDE_roll.data) < max_roll;
    idxp = abs(MavLink_tsc.APM_ATTITUDE_pitch.data) < max_pitch;
    idxa = abs(MavLink_tsc.APM_GPS_RAW_alt.data) > min_alt;
    idxy = abs(yaw_diff.data) < max_yawroc;
    idxar = abs(alt_diff.data) < max_altroc;
    idx = idxr & idxa & idxp & idxy & idxar;

    seg = findSegmentsFromLogical(idx);
    delta_t = yaw_diff.time(seg(:,2)) - yaw_diff.time(seg(:,1));
    sidx = find(delta_t > min_seg_duration);
    seg = seg(sidx,:);
    delta_t = delta_t(sidx);
    N = length(sidx);
    
    slvFigure('Flight Variables');
    h = [];
    
    h = [h; subplot(3,2,1)];
    hold off
    plot(MavLink_tsc.APM_ATTITUDE_roll.time,MavLink_tsc.APM_ATTITUDE_roll.data,'b')
    hold all
    plotSegments(MavLink_tsc.APM_ATTITUDE_roll,seg);
    grid on
    title('Roll')

    h = [h; subplot(3,2,2)];
    hold off
    plot(alt_diff.time,alt_diff.data,'b')
    hold all
    plotSegments(alt_diff,seg);
    grid on
    title('Altitude Slope')

%     h = [h; subplot(3,2,2)];
%     hold off
%     plot(MavLink_tsc.APM_GPS_RAW_alt.time,MavLink_tsc.APM_GPS_RAW_alt.data,'b')
%     hold all
%     plotSegments(MavLink_tsc.APM_GPS_RAW_alt,seg);
%     grid on
%     title('Altitude')


    h = [h; subplot(3,2,3)];
    hold off
    plot(MavLink_tsc.APM_ANALOG_EU_chan12.time,MavLink_tsc.APM_ANALOG_EU_chan12.data,'b')
    hold all
    plotSegments(MavLink_tsc.APM_ANALOG_EU_chan12,seg);
    grid on
    title('RPM')

    h = [h; subplot(3,2,4)];
    hold off
    plot(MavLink_tsc.APM_ATTITUDE_yaw.time,MavLink_tsc.APM_ATTITUDE_yaw.data,'b')
    hold all
    plotSegments(MavLink_tsc.APM_ATTITUDE_yaw,seg);
    grid on
    title('True Heading')

    h = [h; subplot(3,2,5)];
    hold off
    plot(MavLink_tsc.APM_ATTITUDE_pitch.time,MavLink_tsc.APM_ATTITUDE_pitch.data,'b')
    hold all
    plotSegments(MavLink_tsc.APM_ATTITUDE_pitch,seg);
    grid on
    title('Pitch')

    h = [h; subplot(3,2,6)];
    hold off
    plot(yaw_diff.time,yaw_diff.data,'b')
    hold all
    plotSegments(yaw_diff,seg);
    grid on
    title('Heading Slope')

    linkaxes(h,'x')


    slvFigure('Lat/Lon');
    hold off
    x = MavLink_tsc.APM_GPS_RAW_lon.data;
    y = MavLink_tsc.APM_GPS_RAW_lat.data;
    idx = x<-76;
    x = x(idx);
    y = y(idx);
    plot(x,y,'b');
    grid on
    axis equal
    hold all
    M = size(seg,1);
    x = MavLink_tsc.APM_GPS_RAW_lon.data;
    y = MavLink_tsc.APM_GPS_RAW_lat.data;
    for i=1:M
        plot(x(seg(i,1):seg(i,2)),y(seg(i,1):seg(i,2)),':.','LineWidth',2);
        slon = x(seg(i,1));
        slat = y(seg(i,1));
        stext = sprintf('S%d',i);
        text(slon,slat,stext,'BackgroundColor',[.7 .9 .7]);
    end
    
    slvFigure('3D Lat/Lon');
    hold off
    x = MavLink_tsc.APM_GPS_RAW_lon.data;
    y = MavLink_tsc.APM_GPS_RAW_lat.data;
    z = MavLink_tsc.APM_GPS_RAW_alt.data;
    idx = x<-76;
    x = x(idx);
    y = y(idx);
    z = z(idx);
    delta = max(max(x)-min(x),max(y)-min(y));
    maxX = (max(x)+min(x))/2+delta/2;
    minX = (max(x)+min(x))/2-delta/2;
    maxY = (max(y)+min(y))/2+delta/2;
    minY = (max(y)+min(y))/2-delta/2;
    
    disp([x y z])
    plot3(x,y,z,'b');
    grid on
    xlim([minX maxX]);
    ylim([minY maxY]);
    %axis equal
    hold all
    M = size(seg,1);
    x = MavLink_tsc.APM_GPS_RAW_lon.data;
    y = MavLink_tsc.APM_GPS_RAW_lat.data;
    z = MavLink_tsc.APM_GPS_RAW_alt.data;
    t = MavLink_tsc.APM_ANALOG_EU_chan10.time;
    Va = MavLink_tsc.APM_ANALOG_EU_chan10.data;
    Ia = MavLink_tsc.APM_ANALOG_EU_chan10.data;
    Vf = MavLink_tsc.APM_ANALOG_EU_chan10.data;
    If = MavLink_tsc.APM_ANALOG_EU_chan10.data;
    energy = zeros(M,1);
    for i=1:M
        plot3(x(seg(i,1):seg(i,2)),y(seg(i,1):seg(i,2)),z(seg(i,1):seg(i,2)),':.','LineWidth',2);
        slon = x(seg(i,1));
        slat = y(seg(i,1));
        salt = z(seg(i,1));
        stext = sprintf('S%d',i);
        text(slon,slat,salt,stext,'BackgroundColor',[.7 .9 .7]);
        energy(i) = trapz(t,V.*I);
    end
    
    disp(sprintf(' t_start    t_end duration(s)'));
    for i=1:M
        disp(sprintf('S%d: %8.1f %8.1f %6.1f',i,yaw_diff.time(seg(i,1)),yaw_diff.time(seg(i,2)),delta_t(i)))
    end

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
