%%
function PC = decodePC104AsciiFiles()
    %% Find Data
    SignalList = dir('SignalList*.xls');
    if (~isempty(SignalList))
        [n,t,r]=xlsread(SignalList.name,'Sheet1',' ','basic');
        idx = strfind(t(1,:),'Variable');
        N = length(idx);
        k = [];
        for i=1:N
            if (idx{i}==1)
                k = i;
            end
        end
        if (~isempty(k))
            Nsig = size(t,1)-1;
            for i=1:Nsig
                signal.idx(i) = i;
                signal.name{i} = t{i+1,k};
            end
        end
    end
    for i=1:Nsig
        disp(signal.name{i})
        PC.DATA.(signal.name{i}) = [];
    end
    
    dfiles = dir('*.mat');
    M = length(dfiles);

    %% BHM Fields
    PC.BHM.time    = [];
    PC.BHM.soc1    = [];
    PC.BHM.soc2    = [];
    PC.BHM.soc3    = [];
    PC.BHM.soc4    = [];
                
    %% $GPGGA Fields
    PC.GPS.time    = [];
    PC.GPS.UTCtime = [];
    PC.GPS.lat     = [];
    PC.GPS.lon     = [];
    PC.GPS.alt     = [];
    PC.GPS.head    = [];

    %% $VNQMR Fields
    PC.VN.time    = [];
    PC.VN.q0      = [];
    PC.VN.q1      = [];
    PC.VN.q2      = [];
    PC.VN.q3      = [];
    PC.VN.yaw     = [];
    PC.VN.pitch   = [];
    PC.VN.roll    = [];
    
    for j=1:M
        load(dfiles(j).name,'pc104');
        if exist('pc104','var')
            N = size(pc104.data,1);  % Number of logged strings with number to skip until
            K = size(pc104.data,2);
            
            idx100 = findstr(dfiles(j).name,'F100');
            if ~isempty(idx100)
                for i=1:Nsig
                    PC.DATA.(signal.name{i}) = [PC.DATA.(signal.name{i}) pc104.data(:,signal.idx(i))];
                end
            else

            idx302 = findstr(dfiles(j).name,'F302');
            if ~isempty(idx302)
                %%N = size(pc104.data,2);
                %%BHMtime = pc104.data(:,N);
                PC.BHM.time = [PC.BHM.time pc104.data(:,K)];
                PC.BHM.soc1 = [PC.BHM.soc1 pc104.data(:,3)];
                PC.BHM.soc2 = [PC.BHM.soc2 pc104.data(:,19)];
                PC.BHM.soc3 = [PC.BHM.soc3 pc104.data(:,35)];
                PC.BHM.soc4 = [PC.BHM.soc4 pc104.data(:,51)];
            else

            ddata = pc104.data(:,1:K-1);
            if ((max(ddata(:))>255) || (min(ddata(:))<0))
                continue;
            end
            dtext = char(pc104.data);
            jtext = dtext';
            jtext = jtext(:)';

            GPSidx = findstr('$GPGGA',jtext);
            if ~isempty(GPSidx)
                for i = 1:N;
                    Xpctime_now = pc104.data(i,K);
                    %[GPStime1,lat1,lon1,alt1] = parse_latlonalt(char(pc104.data(i,1:165)));  
                    [GPStime1,lat1,lon1,alt1] = parse_latlonalt(dtext(i,1:K-1));  
                    if (GPStime1>0)
                        %Data in record, save it in the output arrays and bump ikeep index.
                        %Xpctime(ikeep) = pc104.data(2+i,166);
                        Xpctime = [Xpctime; Xpctime_now];
                        GPStime = [GPStime; GPStime1];
                        lat = [lat; lat1];
                        lon = [lon; lon1];
                        alt = [alt; alt1];
                        if (length(lat) ~= length(lon))
                            disp('Error')
                        end
                    end
                end
            end

            VNidx  = findstr('$VNQMR',jtext);
            if ~isempty(VNidx)
                for i = 1:N;
                    ltime = pc104.data(i,K);
                    [q0 q1 q2 q3 m1 m2 m3 a1 a2 a3 r1 r2 r3] = parse_vnqmr(dtext(i,1:K-1));
                    if ~isempty(q0)
                        [lyaw lpitch lroll] = quat2euler3([q0 q1 q2 q3]);
                        time  = [time; ltime];
                        yaw = [yaw; lyaw];
                        pitch = [pitch; lpitch];
                        roll = [roll; lroll];
                    end
                end
            end
            end
            end
            
        end
    end

    if (isempty(lat) || isempty(roll))
        disp('ERROR: Position/Orientation data NOT found!')
        return
    else
        N = length(lat);
        head = zeros(N,1);
        for i=2:N
            head(i) = get_bearing(lat(i),lon(i),lat(i-1),lon(i-1));
        end
        head(1) = head(2);
        head = 180*unwrap(pi*head/180)/pi;
    end

    st = 0;
    et = floor(max([max(Xpctime); max(time); 1]));
    it = 0.1;
    dtime = (st:it:et)';

%% BHM Data
    PC.ts_soc1 = timeseries(soc1,BHMtime,'name','soc1');
    PC.ts_soc2 = timeseries(soc2,BHMtime,'name','soc2');
    PC.ts_soc3 = timeseries(soc3,BHMtime,'name','soc3');
    PC.ts_soc4 = timeseries(soc4,BHMtime,'name','soc4');
warning off 'interpolation:interpolation:noextrap';
    PC.ts_soc1_10hz = resample(PC.ts_soc1,dtime,'zoh');
    PC.ts_soc2_10hz = resample(PC.ts_soc2,dtime,'zoh');
    PC.ts_soc3_10hz = resample(PC.ts_soc3,dtime,'zoh');
    PC.ts_soc4_10hz = resample(PC.ts_soc4,dtime,'zoh');
warning on 'interpolation:interpolation:noextrap';

%% Flight Data
    PC.ts_RPM = timeseries(RPM,time100,'name','RPM');
warning off 'interpolation:interpolation:noextrap';
    PC.ts_RPM_10hz = resample(PC.ts_RPM,dtime,'zoh');
warning on 'interpolation:interpolation:noextrap';

%% GPS DATA
    PC.ts_GPStime = timeseries(GPStime,Xpctime,'name','GPStime');
    PC.ts_lat     = timeseries(lat,Xpctime,'name','lat');
    PC.ts_lon     = timeseries(lon,Xpctime,'name','lon');
    PC.ts_alt     = timeseries(alt*3.2808399,Xpctime,'name','alt');
    PC.ts_head    = timeseries(head,Xpctime,'name','heading');
warning off 'interpolation:interpolation:noextrap';
    PC.ts_GPStime_10hz = resample(PC.ts_GPStime,dtime,'zoh');
    PC.ts_lat_10hz     = resample(PC.ts_lat,dtime,'zoh');
    PC.ts_lon_10hz     = resample(PC.ts_lon,dtime,'zoh');
    PC.ts_alt_10hz     = resample(PC.ts_alt,dtime,'zoh');
    PC.ts_head_10hz    = resample(PC.ts_head,dtime,'zoh');
warning on 'interpolation:interpolation:noextrap';

%% VN100 DATA
    PC.ts_yaw   = timeseries(unwrap(yaw),  time,'name','yaw');
    PC.ts_pitch = timeseries(pitch,time,'name','pitch');
    PC.ts_roll  = timeseries(roll, time,'name','roll');
warning off 'interpolation:interpolation:noextrap';
    PC.ts_yaw_10hz = resample(PC.ts_yaw,dtime,'zoh');
    PC.ts_pitch_10hz = resample(PC.ts_pitch,dtime,'zoh');
    PC.ts_roll_10hz = resample(PC.ts_roll,dtime,'zoh');
warning on 'interpolation:interpolation:noextrap';

%%
%     head_diff = PC.ts_head_10hz;
%     head_diff.data = [0; diff(PC.ts_head_10hz.data)];
%     yaw_diff = PC.ts_yaw_10hz;
%     yaw_diff.data = [0; diff(PC.ts_yaw_10hz.data)];
%     roll_diff = PC.ts_roll_10hz;
%     roll_diff.data = [0; diff(PC.ts_roll_10hz.data)];
%     alt_diff = PC.ts_alt_10hz;
%     alt_diff.data = [0; diff(PC.ts_alt_10hz.data)];
%     RPM_diff = PC.ts_RPM_10hz;
%     RPM_diff.data = [0; diff(PC.ts_RPM_10hz.data)];
% 
%     max_roll = 20;
%     max_pitch = 8;
%     min_alt = 500;
%     max_yawroc = 5;
%     max_altroc = 5;
%     max_rpmroc = 100;
%     min_seg_duration = 8;
%     
%     idxr = abs(PC.ts_roll_10hz.data) < max_roll;
%     idxp = abs(PC.ts_pitch_10hz.data) < max_pitch;
%     idxa = abs(PC.ts_alt_10hz.data) > min_alt;
%     idxy = abs(yaw_diff.data) < max_yawroc;
%     idxh = abs(head_diff.data) < max_yawroc;
%     idxar = abs(alt_diff.data) < max_altroc;
%     idxrpm = abs(RPM_diff.data) < max_rpmroc;
%     
%     idx = idxr & idxa & idxp & idxy & idxh & idxar & idxrpm;
% 
%     seg = findSegmentsFromLogical(idx);
%     delta_t = yaw_diff.time(seg(:,2)) - yaw_diff.time(seg(:,1));
%     sidx = find(delta_t > min_seg_duration);
%     seg = seg(sidx,:);
%     delta_t = delta_t(sidx);
%     N = length(sidx);
%     
%     slvFigure('Flight Variables');
%     h = [];
%     
%     h = [h; subplot(7,1,1)];
%     hold off
%     plot(PC.ts_roll_10hz.time,PC.ts_roll_10hz.data,'b')
%     hold all
%     plotSegments(PC.ts_roll_10hz,seg);
%     grid on
%     set(gca,'ytick',[-max_roll 0 max_roll])
%     title('Roll')
% 
%     h = [h; subplot(7,1,2)];
%     hold off
%     plot(PC.ts_pitch_10hz.time,PC.ts_pitch_10hz.data,'b')
%     hold all
%     plotSegments(PC.ts_pitch_10hz,seg);
%     grid on
%     set(gca,'ytick',[-max_pitch 0 max_pitch])
%     title('Pitch')
% 
%     h = [h; subplot(7,1,3)];
%     hold off
%     plot(PC.ts_alt_10hz.time,PC.ts_alt_10hz.data,'b')
%     hold all
%     plotSegments(PC.ts_alt_10hz,seg);
%     grid on
%     set(gca,'ytick',[0 min_alt])
%     title('Altitude')
%     
%     h = [h; subplot(7,1,4)];
%     hold off
%     plot(alt_diff.time,alt_diff.data,'b')
%     hold all
%     plotSegments(alt_diff,seg);
%     grid on
%     set(gca,'ytick',[-max_altroc 0 max_altroc])
%     title('Altitude Slope')
% 
% 
% %     h = [h; subplot(3,2,3)];
% %     hold off
% %     plot(PC.APM_ANALOG_EU_chan12.time,PC.APM_ANALOG_EU_chan12.data)
% %     hold all
% %     plotSegments(PC.APM_ANALOG_EU_chan12,seg);
% %     grid on
% %     title('RPM')
% 
%     h = [h; subplot(7,1,5)];
%     hold off
%     plot(PC.ts_yaw_10hz.time,PC.ts_yaw_10hz.data,'b')
%     hold all
%     plotSegments(PC.ts_yaw_10hz,seg);
% 
%     plot(PC.ts_head_10hz.time,PC.ts_head_10hz.data)
%     plotSegments(PC.ts_head_10hz,seg);
%     grid on
%     title('True Heading')
% 
%     h = [h; subplot(7,1,6)];
%     hold off
%     plot(yaw_diff.time,yaw_diff.data,'b')
%     hold all
%     plotSegments(yaw_diff,seg);
% 
%     plot(head_diff.time,head_diff.data)
%     plotSegments(head_diff,seg);
%     grid on
%     set(gca,'ytick',[-max_yawroc 0 max_yawroc])
%     title('Heading Slope')
% 
%     h = [h; subplot(7,1,7)];
%     hold off
%     plot(RPM_diff.time,RPM_diff.data,'b')
%     hold all
%     plotSegments(RPM_diff,seg);
%     grid on
%     set(gca,'ytick',[-max_rpmroc 0 max_rpmroc])
%     title('RPM Slope')
% 
%     linkaxes(h,'x')
% 
%     slvFigure('Lat/Lon');
%     hold off
%     x = PC.ts_lon_10hz.data;
%     y = PC.ts_lat_10hz.data;
%     idx = x<-76;
%     x = x(idx);
%     y = y(idx);
%     plot(x,y,'b');
%     grid on
%     axis equal
%     hold all
%     for i=1:N
%         plot(PC.ts_lon_10hz.data(seg(i,1):seg(i,2)),PC.ts_lat_10hz.data(seg(i,1):seg(i,2)),':.','LineWidth',2);
%         slon = PC.ts_lon_10hz.data(seg(i,1));
%         slat = PC.ts_lat_10hz.data(seg(i,1));
%         stext = sprintf('S%d',i);
%         text(slon,slat,stext,'BackgroundColor',[.7 .9 .7]);
%     end
%     
%     slvFigure('Alt/Lon');
%     h = subplot(1,1,1);
%     hold off
%     x = PC.ts_lon_10hz.data;
%     y = PC.ts_alt_10hz.data;
%     idx = x<-76;
%     x = x(idx);
%     y = y(idx);
%     plot(x,y,'b');
%     grid on
%     %axis equal
%     hold all
%     for i=1:N
%         plot(PC.ts_lon_10hz.data(seg(i,1):seg(i,2)),PC.ts_alt_10hz.data(seg(i,1):seg(i,2)),':.','LineWidth',2);
%         slon = PC.ts_lon_10hz.data(seg(i,1));
%         salt = PC.ts_alt_10hz.data(seg(i,1));
%         stext = sprintf('S%d',i);
%         text(slon,salt,stext,'BackgroundColor',[.7 .9 .7]);
%     end
%     
%     slvFigure('Alt/Lat');
%     h = [h; subplot(1,1,1)];
%     hold off
%     x = PC.ts_lat_10hz.data;
%     y = PC.ts_alt_10hz.data;
%     idx = x>37;
%     x = x(idx);
%     y = y(idx);
%     plot(x,y,'b');
%     grid on
%     %axis equal
%     hold all
%     for i=1:N
%         plot(PC.ts_lat_10hz.data(seg(i,1):seg(i,2)),PC.ts_alt_10hz.data(seg(i,1):seg(i,2)),':.','LineWidth',2);
%         slat = PC.ts_lat_10hz.data(seg(i,1));
%         salt = PC.ts_alt_10hz.data(seg(i,1));
%         stext = sprintf('S%d',i);
%         text(slat,salt,stext,'BackgroundColor',[.7 .9 .7]);
%     end
% 
%     linkaxes(h,'y')
% 
%     disp(sprintf(' t_start    t_end duration(s)'));
%     for i=1:N
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
