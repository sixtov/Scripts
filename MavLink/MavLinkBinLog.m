%%
function status = MavLinkBinLog(dfile)
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
        MavLink = initMavLink_0_9();
    else
        packetID = newPacketID;
        MavLink = initMavLink_1_0();
    end
    MavLink_gcs = MavLink;
    MavLink_beagle = MavLink;
    MavLink_JS = MavLink;
    MavLink_unknown = MavLink;
    
    adx = find(data==packetID);
    if (isempty(adx)), return; end
    
    N = length(adx);
    tstart = tic;
    per=1;
    didx = 0;
    %pfp = fopen('packet.txt','w');
    pfp = fopen(pfp_name,'w');
    for i=1:N
        if (i==didx), 
            %fprintf('skipping index %d\n',i); 
            continue; 
        end  %skip packetID byte if it is part of previous packet 

        p = extractPacket(data,adx(i),pfp);
        
        if (~isempty(p))
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
            switch(p.sysid)
                case 0         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 1         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 2         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 3         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 4         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 5         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 6         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 7         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 8         %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 81        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 82        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 83        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 84        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 85        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 86        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 87        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                case 88        %% Autopilot telemetry
                    MavLink = parseMavLinkPacketSLV(MavLink,p); 
                    
                case 255       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 254       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 253       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 252       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 251       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 250       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 249       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 248       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 247       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 174       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 173       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 172       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 171       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 170       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 169       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 168       %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                case 167        %% Ground Station telemetry
                    MavLink_gcs = parseMavLinkPacketSLV(MavLink_gcs,p);
                    
                case 133       %% Beagle Board telemetry
                    MavLink_beagle = parseMavLinkPacketSLV(MavLink_beagle,p);
                case 137       %% Beagle Board telemetry
                    MavLink_JS = parseMavLinkPacketSLV(MavLink_beagle,p);
                    
                otherwise      
                    MavLink_unknown = parseMavLinkPacketSLV(MavLink_unknown,p);
                    %fprintf('Telemetry from UNKNOWN system (%d)\n',p.sysid);
            end
        end
    end
    fclose(pfp);
    %% Eliminate empty members
    MavLink = cleanStruct(MavLink);
    MavLink = ConvertUnits(MavLink);
    MavLink = verifyEU(MavLink,vehicle);
    
    MavLink_gcs = cleanStruct(MavLink_gcs);
    MavLink_gcs = verifyEU(MavLink_gcs,vehicle);
    
    MavLink_beagle = cleanStruct(MavLink_beagle);
    MavLink_beagle = verifyEU(MavLink_beagle,vehicle);
    
    MavLink_JS = cleanStruct(MavLink_JS);
    MavLink_JS = verifyEU(MavLink_JS,vehicle);
    
    MavLink_unknown = cleanStruct(MavLink_unknown);
    MavLink_unknown = verifyEU(MavLink_unknown,vehicle);
    
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
    MavLink_gcs.Vehicle = vehicle;
    MavLink_beagle.Vehicle = vehicle;
    MavLink_JS.Vehicle = vehicle;
    MavLink_unknown.Vehicle = vehicle;
    %%
    fprintf('Saving %s\n',rfile)
    save(rfile,'MavLink','MavLink_ts','MavLink_tsc','MavLink_gcs','MavLink_beagle','MavLink_JS','MavLink_unknown','-v7.3');
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
    

function MavLink = parseMavLinkPacketSLV(MavLink,p)
    global vehicle;
    switch (p.packetID)
        case 85 %% MavLink 0.9 message
            %MavLink = parseMavLinkPacket_APM_2_23(MavLink,p);
            MavLink = parseMavLink_0_9_Packet(MavLink,p);
            switch (p.messid)
                case 0 %If heartbeat message
                    if (length(p.data)>3)
                        vehicle = p.data(4);
                    else
                        disp(p.data)
                    end
                    %if (vehicle <= 1)
                    %    vehicle = 3;
                    %end
                case 254 %__mavlink_statustext_t
%                     disp(strcat('DBG: ',char(MavLink.STATUSTEXT.text(end,:))))
            end
        case 254 %% MavLink 1.0 message
            MavLink = parseMavLink_1_0_Packet(MavLink,p);
            switch (p.messid)
                case 253 %__mavlink_statustext_t
%                     disp(strcat('DBG: ',char(MavLink.STATUSTEXT.text(end,:))))
            end
    end    
return
    
function packet = extractPacket(data,idx,pfp)
    global packetID;
    global L;
    packet = [];
    if (idx+5>L), return; end
    %disp(data(idx:idx+5)')
    ddx = idx-8;
    psx = idx+1; % skip the packetID for checksum
    pex = idx+double(data(psx))+5;
    csx = pex+1;
    cex = csx+1;
    if (cex>L), return; end
    gh = checkHeader(data(idx:idx+5),idx);
    gc = vchecksum(data(psx:pex),data(csx:cex));
    if (gh && gc)
        % 8-byte date + 
        packet.packetID = packetID;
        if (ddx<1)
            packet.date = uint8(zeros(1,8));
        else
            packet.date   = data(ddx:ddx+7);
        end
        
        % 6-byte header {'U'|length|count|sysid|id|messid} + 
        packet.head   = data(idx);
        packet.len    = data(idx+1);
        %plen = double(packet.len);
        %tlen = 8 + 6 + plen + 2;
        packet.count  = data(idx+2);
        packet.sysid  = data(idx+3);
        packet.id     = data(idx+4);
        packet.messid = data(idx+5);

        % x-byte data + 
        packet.data   = data(idx+6:pex);

        % 2-byte checksum
        packet.chksum = data(csx:cex);

        fprintf(pfp,'[%2d,%3d,%3d,%3d,%3d,%3d]{ ',data(idx:idx+5));
        fprintf(pfp,'0x%02x ',data(idx+6:cex));
        fprintf(pfp,'}\n');
    else
        if (gh)
%             fprintf('*%d,%d,%d,%d,%d,%d]{',data(idx:idx+5))
%             fprintf('0x%0x ',data(idx+6:idx+min([20 cex-idx])))
%             fprintf('} checksum failed\n')
        end
    end
return

function vhead = checkHeader(header,idx)
    global packetID;
    global oldPacketID;
    global newPacketID;
    apID = 1;
    gsID = 255;
    bgID = 103;
    
    vhead = 1; return;
    vhead = 0;
    switch (packetID)
        case oldPacketID
            cmIDgs = 1;
            cmIDap = 1;
           % One-based Index  (1:256)           ,   ,   ,   ,   ,   ,   ,   ,   , 10,   ,   ,   ,   ,   ,   ,   ,   ,   , 20,   ,   ,   ,   ,   ,   ,   ,   ,   , 30,   ,   ,   ,   ,   ,   ,   ,   ,   , 40,   ,   ,   ,   ,   ,   ,   ,   ,   , 50,   ,   ,   ,   ,   ,   ,   ,   ,   , 60,   ,   ,   ,   ,   ,   ,   ,   ,   , 70,   ,   ,   ,   ,   ,   ,   ,   ,   , 80,   ,   ,   ,   ,   ,   ,   ,   ,   , 90,   ,   ,   ,   ,   ,   ,   ,   ,   ,100,   ,   ,   ,   ,   ,   ,   ,   ,   ,110,   ,   ,   ,   ,   ,   ,   ,   ,   ,120,   ,   ,   ,   ,   ,   ,   ,   ,   ,130,   ,   ,   ,   ,   ,   ,   ,   ,   ,140,   ,   ,   ,   ,   ,   ,   ,   ,   ,150,   ,   ,   ,   ,   ,   ,   ,   ,   ,160,   ,   ,   ,   ,   ,   ,   ,   ,   ,170,   ,   ,   ,   ,   ,   ,   ,   ,   ,180,   ,   ,   ,   ,   ,   ,   ,   ,   ,190,   ,   ,   ,   ,   ,   ,   ,   ,   ,200,   ,   ,   ,   ,   ,   ,   ,   ,   ,210,   ,   ,   ,   ,   ,   ,   ,   ,   ,220,   ,   ,   ,   ,   ,   ,   ,   ,   ,230,   ,   ,   ,   ,   ,   ,   ,   ,   ,240,   ,   ,   ,   ,   ,   ,   ,   ,   ,250
            MAVLINK_MESSAGE_LENGTHS = uint8([  5,  4,  8, 14,  8, 28,  3, 32,  0,  2,  3,  2,  2,  0,  0,  0,  0,  0,  0,  0, 19,  2, 23, 21,  0, 37, 26,101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36,  4,  4,  2,  2,  4,  2,  2,  3, 14, 12, 18, 16,  8, 27, 25, 18, 18, 24, 24,  0,  0,  0, 26, 16, 36,  5,  6, 56, 26, 21, 18,  0,  0, 18, 20, 20,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 18,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 40, 72, 12, 33, 11,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0, 42,  8,  4, 12, 15, 13,  6, 15, 14,  0, 12,  3,  8, 28, 36,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 30, 14, 14, 51,  5]');
           %MAVLINK_MESSAGE_CRCS    = uint8([ 72, 39,190, 92,191,217,104,119,  0,219, 60,186, 10,  0,  0,  0,  0,  0,  0,  0, 89,159,162,121,  0,149,222,110,179,136, 66,126,185,147,112,252,162,215,229,128,  9,106,101,213,  4,229, 21,214,215, 14,206, 50,157,126,108,213, 95,  5,127,  0,  0,  0, 57,126,130,119,193,191,236,158,143,  0,  0,104,123,131,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,174,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,155,  0,  0,  0,  0,  0,  0,  0,  0,  0,143, 29,208,188,118,242, 19, 97,233,  0, 18, 68,136,205, 42, 21,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,178,224, 60,106,  7]');
        case newPacketID
            cmIDgs = 190;
            cmIDap = 1;
            if (header(5) ~= cmIDgs && header(5) ~= cmIDap)
                disp('junk')
            end
           % One-based Index  (1:256)           ,   ,   ,   ,   ,   ,   ,   ,   , 10,   ,   ,   ,   ,   ,   ,   ,   ,   , 20,   ,   ,   ,   ,   ,   ,   ,   ,   , 30,   ,   ,   ,   ,   ,   ,   ,   ,   , 40,   ,   ,   ,   ,   ,   ,   ,   ,   , 50,   ,   ,   ,   ,   ,   ,   ,   ,   , 60,   ,   ,   ,   ,   ,   ,   ,   ,   , 70,   ,   ,   ,   ,   ,   ,   ,   ,   , 80,   ,   ,   ,   ,   ,   ,   ,   ,   , 90,   ,   ,   ,   ,   ,   ,   ,   ,   ,100,   ,   ,   ,   ,   ,   ,   ,   ,   ,110,   ,   ,   ,   ,   ,   ,   ,   ,   ,120,   ,   ,   ,   ,   ,   ,   ,   ,   ,130,   ,   ,   ,   ,   ,   ,   ,   ,   ,140,   ,   ,   ,   ,   ,   ,   ,   ,   ,150,   ,   ,   ,   ,   ,   ,   ,   ,   ,160,   ,   ,   ,   ,   ,   ,   ,   ,   ,170,   ,   ,   ,   ,   ,   ,   ,   ,   ,180,   ,   ,   ,   ,   ,   ,   ,   ,   ,190,   ,   ,   ,   ,   ,   ,   ,   ,   ,200,   ,   ,   ,   ,   ,   ,   ,   ,   ,210,   ,   ,   ,   ,   ,   ,   ,   ,   ,220,   ,   ,   ,   ,   ,   ,   ,   ,   ,230,   ,   ,   ,   ,   ,   ,   ,   ,   ,240,   ,   ,   ,   ,   ,   ,   ,   ,   ,250
            MAVLINK_MESSAGE_LENGTHS = uint8([  9, 31, 12,  0, 14, 28,  3, 32,  0,  0,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0, 20,  2, 25, 23, 30,101, 22, 26, 16, 14, 28, 32, 28, 28, 22, 22, 21,  6,  6, 37,  4,  4,  2,  2,  4,  2,  2,  3, 13, 12, 19, 17, 15, 15, 27, 25, 18, 18, 20, 20,  0,  0, 26,  0, 36,  0,  6,  4,  0, 21, 18,  0,  0,  0, 20,  0, 33,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 56, 42, 33,  0,  0,  0,  0,  0,  0,  0, 18, 32, 32, 20, 32,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 42,  8,  4, 12, 15, 13,  6, 15, 14,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36, 30, 18, 18, 51,  9,  3]');
           %MAVLINK_MESSAGE_CRCS    = uint8([ 50,124,137,  0,237,217,104,119,  0,  0,  0, 89,  0,  0,  0,  0,  0,  0,  0,  0,214,159,220,168, 24, 23,170,144, 67,115, 39,246,185,104,237,244,222,212,  9,254,230, 28, 28,132,221,232, 11,153, 41, 39,214,223,141, 33, 15,  3,100, 24,239,238,  0,  0,183,  0,130,  0,148, 21,  0, 52,124,  0,  0,  0, 20,  0,152,143,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,183, 63, 54,  0,  0,  0,  0,  0,  0,  0, 19,102,158,208, 56,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,134,219,208,188, 84, 22, 19, 21,134,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,204, 49,170, 44, 83, 46,247]');
    end
    if (   (header(1)==packetID) ...
        && (header(2)==MAVLINK_MESSAGE_LENGTHS(header(6)+1)) ...        %&& (header(4)==apID || header(4)==gsID || header(4)==bgID) ...        %&& (header(5)==cmIDgs || header(5)==cmIDap) ...
        )
        vhead = 1;
        %fprintf('Head:%s\n',sprintf('%02x,',header))
    else
        msg = sprintf('BH(%d):%s\t',idx,sprintf('%02x,',header));
        if ((header(1)~=packetID)), msg = sprintf('%s h[1] %02x!=%02x\t',msg,header(1),packetID); end
        if ((header(2)~=MAVLINK_MESSAGE_LENGTHS(header(6)+1))), msg = sprintf('%s h[2] %02x!=%02x\t',msg,header(2),MAVLINK_MESSAGE_LENGTHS(header(6)+1)); end
        if (header(4)~=apID && header(4)~=gsID && header(4)~=bgID), msg = sprintf('%s h[4] %02x!={%02x,%02x,%02x}\t',msg,header(4),apID,gsID,bgID); end
        if (header(5)~=cmIDgs && header(5)~=cmIDap), msg = sprintf('%s h[5] %02x!={%02x,%02x}',msg,header(5),cmIDgs,cmIDap); end
        disp(msg);
    end
return

function vchksum = vchecksum(data,bchksum)
    global packetID;
    global oldPacketID;
    global newPacketID;
    
    chksum = typecast(bchksum,'uint16');
    switch (packetID)
        case oldPacketID
            crc = checksum_v0_9(data);
            if (crc == chksum)
                vchksum = 1;
            else
                vchksum = 0;
%                 disp(sprintf('    *** ChecSum Error: Calculated[%05d] InPacket[%05d] ***',[crc chksum]))
            end
        case newPacketID
            crc = checksum_v1_0(data);
            if (crc == chksum)
                vchksum = 1;
            else
                vchksum = 0;
            end
        otherwise
            disp('ERROR: Unknown packet header')
            vchksum = 0;
    end
return
