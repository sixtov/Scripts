%%
function status = MavLinkBinLog(dfile)
    global pnum;
    global dtime;
    global tsc;
    global timestamp;
    global datestamp;
    global t0;
    global packetID;
    global oldPacketID;
    global newPacketID;
    global L;
    global vehicle;
    %global adx;
    %global cnt;
    
    pnum = 0;
    vehicle = 0; % []
    status = 0;
    dtime = [];
    tsc = [];
    timestamp = 0;
    t0 = 0;
    pcnt = 1;
    fprintf('Processing %s\n',dfile)
    pfp_name = sprintf('%s_packet.txt',dfile(1:end-5));
    pid = fopen(dfile,'r','ieee-be');
    data = fread(pid,inf,'uint8=>uint8');
    L = length(data);
    fclose(pid);

    if (isempty(data))
        %% Need to delete empty file HERE!
        recycle on;
        fprintf('Removing empty file: %s\n',dfile)
        delete(dfile);
        return;
    end
    
    oldPacketID = 85;
    newPacketID = 254;
    oldPacket = find(data == oldPacketID);
    newPacket = find(data == newPacketID);
    if (length(oldPacket) > length(newPacket))
        packetID = oldPacketID;
        MavLink = initMavLink_v0_9();
        adx = oldPacket;
    else
        packetID = newPacketID;
        MavLink = initMavLink_v1_0();
        adx = newPacket;
    end
    
    if (isempty(adx)), return; end
    
    N = length(adx);
    tstart = tic;
    per=1;
    didx = 0;
    %pfp = fopen('packet.txt','w');
    pfp = fopen(pfp_name,'w');
    for i=1:1000    %N
        if (i==didx), 
            %fprintf('skipping index %d\n',i); 
            continue; 
        end  %skip packetID byte if it is part of previous packet 

        p = extractPacket(data,adx(i),pfp);
        if (isempty(p))
            continue;
        end
        
        if (p.len == length(p.data))
             %fprintf('message %d of %d : packet number %d\n',i,N,p.count);
             pnum = mod(p.count-1,256);   % substract one so when encode increments
                                            % it ends up with the same packet number
                                            % and the results can be compared
            dataL = L-adx(i);
            dataP = dataL/L;
            if (dataP<per)
                per = per-0.05;
                fprintf('Packets=%d Data=%d %%left=%d %d(sec)in %d(sec) %s\n',pcnt,dataL,int16(100*dataP),floor(timestamp),floor(toc(tstart)),datestamp)
            end
            if ( (i<N) && (adx(i+1) < (adx(i)+16+double(p.len))) )
                didx = i+1; % forces code to skip if packetID byte is part of previous packet
            end
%             if (p.sysid==111)
%                 head = sprintf(' p={%d,%d,%d,%d,%d,%d}[',p.head,p.len,p.count,p.sysid,p.id,p.messid);
%                 body = sprintf('%02x,',p.data);
%                 chksum = sprintf(']{%02x,%02x};',p.chksum);
%                 disp([head body chksum]);
%             end
            pcnt = pcnt+1;
            MavPoint = parseMavLinkPacketSLV(p.bytes); 
            messageName = fieldnames(MavPoint);
            MavLink.(messageName{1}) = appendStructDataPoint(MavLink.(messageName{1}),MavPoint.(messageName{1}));
        end
    end
    fclose(pfp);
    %% Eliminate empty members
    MavLink = cleanStruct(MavLink);
    MavLink = ConvertUnits(MavLink);
    MavLink = verifyEU(MavLink,vehicle);
    
    %% Convert to EU and match units across MavLink members
    %MavLink = MavLink_EU_units(MavLink,packetID);

    disp('Done Processing')
    toc(tstart);
    [fpath fname fext] = fileparts(dfile);
    %[fpath fname fext fver] = fileparts(dfile);
    %rfile = sprintf('%s_mavLink.mat',dfile(1:end-5));
    if (~isempty(fpath))
        rfile = sprintf('%s_APM.mat',[fpath filesep fname]);
    else
        rfile = sprintf('%s_APM.mat',fname);
    end
    disp('Creating timeseries structures')
    %%
    [MavLink_ts MavLink_tsc] = Struct2Timeseries(MavLink,'APM');
    %%
    MavLink.Vehicle = vehicle;
    %%
    fprintf('Saving %s\n',rfile)
    save(rfile,'MavLink','MavLink_ts','MavLink_tsc','-v7.3');
    disp('Data Saved. Finished!')
    disp(' ')
%   plotStructure('MavLink',MavLink,[]);
    status = 1;
return

function S = ConvertUnits(S)
    r2d = (180/pi); d2r = (pi/180);
    g2mps2 = 9.80665;
    
    if (isfield(S,'ATTITUDE'))
        S.ATTITUDE.roll       = r2d*S.ATTITUDE.roll;
        S.ATTITUDE.pitch      = r2d*S.ATTITUDE.pitch;
        S.ATTITUDE.yaw        = r2d*S.ATTITUDE.yaw;
        S.ATTITUDE.rollspeed  = r2d*S.ATTITUDE.rollspeed;
        S.ATTITUDE.pitchspeed = r2d*S.ATTITUDE.pitchspeed;
        S.ATTITUDE.yawspeed   = r2d*S.ATTITUDE.yawspeed;
    end
    
%     if (isfield(S,'GPS_RAW'))
%         S.GPS_RAW.hdg = r2d*d2r*S.GPS_RAW.hdg;
%     end
%     
%     if (isfield(S,'NAV_CONTROLLER_OUTPUT'))
%         S.NAV_CONTROLLER_OUTPUT.nav_bearing = r2d*S.NAV_CONTROLLER_OUTPUT.nav_bearing;
%         S.NAV_CONTROLLER_OUTPUT.target_bearing = r2d*S.NAV_CONTROLLER_OUTPUT.target_bearing;
%     end
%     
%     if (isfield(S,'VFR_HUD'))
%         S.VFR_HUD.heading = r2d*S.VFR_HUD.heading;
%     end
    
    if (isfield(S,'RAW_IMU'))
        S.RAW_IMU.xacc = g2mps2*single(S.RAW_IMU.xacc)/1000;
        S.RAW_IMU.yacc = g2mps2*single(S.RAW_IMU.yacc)/1000;
        S.RAW_IMU.zacc = g2mps2*single(S.RAW_IMU.zacc)/1000;
        S.RAW_IMU.xgyro = r2d*single(S.RAW_IMU.xgyro)/1000;
        S.RAW_IMU.ygyro = r2d*single(S.RAW_IMU.ygyro)/1000;
        S.RAW_IMU.zgyro = r2d*single(S.RAW_IMU.zgyro)/1000;
    end

%     if (isfield(S,'SENSOR_OFFSETS'))
%         S.SENSOR_OFFSETS.accel_cal_x = single(S.SENSOR_OFFSETS.accel_cal_x)/1000;
%         S.SENSOR_OFFSETS.accel_cal_y = single(S.SENSOR_OFFSETS.accel_cal_y)/1000;
%         S.SENSOR_OFFSETS.accel_cal_z = single(S.SENSOR_OFFSETS.accel_cal_z)/1000;
%         S.SENSOR_OFFSETS.gyro_cal_x = r2d*single(S.SENSOR_OFFSETS.gyro_cal_x)/1000;
%         S.SENSOR_OFFSETS.gyro_cal_y = r2d*single(S.SENSOR_OFFSETS.gyro_cal_y)/1000;
%         S.SENSOR_OFFSETS.gyro_cal_z = r2d*single(S.SENSOR_OFFSETS.gyro_cal_z)/1000;
%     end
return
