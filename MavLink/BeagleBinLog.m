%%
function MavLink = BeagleBinLog(dfile)
    global dtime;
    global tsc;
    global timestamp;
    global t0;
    dtime = [];
    tsc = [];
    timestamp = 0;
    t0 = 0;
    pcnt = 1;
    disp(sprintf('Processing %s',dfile))
    pid = fopen(dfile,'r','ieee-be');
    data = fread(pid,inf,'uint8=>uint8');
    L = length(data);
    fclose(pid);
    
    if (L>0)
        MavLink = initMavLink();

        tic;
        ptoc = toc;
        per=1;
        idx = 1;
        while (idx<L)
            dataL = L-idx;
            dataP = dataL/L;
            if (dataP<per)
                per = per-0.05;
                ctoc = toc;
                disp(sprintf('Packets=%d Data=%d %%left=%d %d(sec)in %d(sec)',pcnt,dataL,int16(100*dataP),floor(timestamp),floor(ctoc-ptoc)))
            end

            [p idx] = extractPacket(data,idx);
            if (~isempty(p))
                pcnt = pcnt+1;
                MavLink = parseMavLinkPacketSLV(MavLink,p);
            end
        end

        %% Eliminate empty members
        MavLink = cleanStruct(MavLink);
        %% Convert to EU and match units across MavLink members
        MavLink = MavLink_EU_units(MavLink);

        disp('Done Processing')
        toc;
        rfile = sprintf('%s_mavLink.mat',dfile(1:end-5));
        disp('Creating timeseries structures')
        %%
        [MavLink_ts MavLink_tsc] = Struct2Timeseries(MavLink,'APM');
        %%
        disp(sprintf('Saving %s',rfile))
        save(rfile,'MavLink','MavLink_ts','MavLink_tsc','-v7.3');
        disp('Data Saved. Finished!')
        disp(' ')
%         plotStructure('MavLink',MavLink,[]);
    end
return

function S = cleanStruct(S)
    names = fieldnames(S);
    rmList = [];
    N = length(names);
    for i=1:N
        if isempty(S.(names{i}))
            rmList = [rmList; names(i)];
            disp(sprintf('Removing %s field',names{i}))
        end
    end
    S = rmfield(S,rmList);
return

function MavLink = parseMavLinkPacketSLV(MavLink,p)
    MavLink = parseMavLinkPacket_APM_2_27(MavLink,p);
    switch (p.messid)
        case 254 %__mavlink_statustext_t
            disp(strcat('DBG: ',char(MavLink.STATUSTEXT.text(end,:))))
        %% Ignore the following cases
        case 111 %__mavlink_analog_channels_t
        case 112 %__mavlink_analog_channels_t
        case  11 %__mavlink_set_mode_t
        case  12 %__mavlink_set_nav_mode_t
        case  35 %__mavlink_rc_channels_raw_t
        case  36 %__mavlink_rc_channels_scaled_t
        case  37 %__mavlink_servo_output_raw_t
        case  30 %__mavlink_attitude_t
        case  32 %__mavlink_gps_raw_t
        case  74 %__mavlink_vfr_hud_t
        case  28 %__mavlink_raw_imu_t
        case  34 %__mavlink_sys_status_t
        case  38 %__mavlink_scaled_pressure_t
        case 150 %__mavlink_sensor_offsets_t
        case  62 %__mavlink_nav_controller_output_t
        case  73 %__mavlink_global_position_int_t
        case   0 %__mavlink_heartbeat_t
        case   9 %__mavlink_action_ack_t
        case  10 %__mavlink_action_t
        case  21 %__mavlink_param_request_list_t
        case  22 %__mavlink_param_value_t
        case  23 %__mavlink_param_set_t
        case  27 %__mavlink_gps_status_t
        case  39 %__mavlink_waypoint_t
        case  40 %__mavlink_waypoint_request_t
        case  41 %__mavlink_waypoint_set_current_t
        case  42 %__mavlink_waypoint_current_t
        case  43 %__mavlink_waypoint_request_list_t
        case  44 %__mavlink_waypoint_count_t
        case  45 %__mavlink_waypoint_clear_all_t
        case  46 %__mavlink_waypoint_reached_t
        case  47 %__mavlink_waypoint_ack_t
        case  66 %__mavlink_request_data_stream_t
        case 152 %__mavlink_parse_meminfo_t
        case 160 %__mavlink_fence_point_t
        case 161 %__mavlink_fence_fetch_point_t
        case 162 %__mavlink_fence_status_t
        otherwise
            disp(sprintf('    Message (%d) Unhandled',p.messid))
    end
return
    
function [packet idx] = extractPacket(data,idx)
    vpacket = 0;
    N = length(data);
    %idx = idx+8; % This line is only needed to parse GCS log files
    if ((idx)>N)
        packet = [];
        idx = N+1;
        return
    end
    while (~vpacket)
        if (data(idx)==85)
            udx = 1;
        else
            udx = find(data(idx:end)==85,1,'first');
            if isempty(udx)
                packet = [];
                idx = N+1;
                return
            end
        end
        if (udx~=1)
            disp(sprintf('"U" found at %d, expected at 9',udx))
        end
        udx = udx+idx-1;
        if ((udx+1)>N)
            disp('Incomplete packet')
            packet = [];
            idx = N+1;
            return
        end
        ddx = udx-8;
        psx = udx+1;
        pex = udx+double(data(psx))+6-1;
        csx = pex+1;
        cex = csx+1;
        
        %% Show Packet
        disp(sprintf('%d ',data(udx:cex)'))
        
        if (csx>N || cex>N || psx>N || pex>N)
            packet = [];
            idx = N+1;
            return
        end

        if (checksum(data(psx:pex),data(csx:cex)))
            % 6-byte header {'U'|length|count|sysid|id|messid} + 
            packet.head   = data(idx);
            if (char(packet.head)~='U')
                disp(sprintf('Bad Packet: Received "%c" while expecting "U"',char(packet.head)))
            end
            packet.len    = data(idx+1);
            plen = double(packet.len);
            len = double(6 + packet.len + 2);
            packet.count  = data(idx+2);
            packet.sysid  = data(idx+3);
            packet.id     = data(idx+4);
            packet.messid = data(idx+5);

            % x-byte data + 
            packet.data   = data(idx+6:idx+6+plen-1);

            % 2-byte checksum
            packet.chksum = data(idx+6+plen:idx+6+plen+1);

            idx = idx+len;
            vpacket = 1;
        else
            disp('Failed CheckSum')
            idx = cex+1;
        end
    end
return

function vchksum = checksum(data,bchksum)
    N = length(data);
    b = uint8(0);
    ch = uint8(0);
    crc = uint16(65535);
    ooff = uint16(255);
    chksum = typecast(bchksum,'uint16');
    for i=1:N
        b = data(i);
        ch = bitxor(b,uint8(bitand(crc,ooff)));
        ch = uint8(bitxor(ch,bitshift(ch,4)));
        crc = uint16(bitxor(bitxor(bitxor(bitshift(crc,-8),bitshift(uint16(ch),8)),bitshift(uint16(ch),3)),bitshift(uint16(ch),-4)));
    end
    if (crc == chksum)
        vchksum = 1;
    else
        vchksum = 0;
    end
return
