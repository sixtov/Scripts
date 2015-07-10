%%
function status = TestMavLinkScripts(dfile)
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
    else
        packetID = newPacketID;
        MavLink = initMavLink_v1_0();
    end
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

        p_in = extractPacket(data,adx(i),pfp);
        if (isempty(p_in))
            continue;
        end
        if (p_in.len == length(p_in.data))
             fprintf('message %d of %d : packet number %d\n',i,N,p_in.count);
             pnum = mod(p_in.count-1,256);   % substract one so when encode increments
                                            % it ends up with the same packet number
                                            % and the results can be compared
            dataL = L-adx(i);
            dataP = dataL/L;
            if (dataP<per)
                per = per-0.05;
                %fprintf('Packets=%d Data=%d %%left=%d %d(sec)in %d(sec) %s\n',pcnt,dataL,int16(100*dataP),floor(timestamp),floor(toc(tstart)),datestamp)
            end
            if ( (i<N) && (adx(i+1) < (adx(i)+16+double(p_in.len))) )
                didx = i+1; % forces code to skip if packetID byte is part of previous packet
            end
%             if (p.sysid==111)
%                 head = sprintf(' p={%d,%d,%d,%d,%d,%d}[',p.head,p.len,p.count,p.sysid,p.id,p.messid);
%                 body = sprintf('%02x,',p.data);
%                 chksum = sprintf(']{%02x,%02x};',p.chksum);
%                 disp([head body chksum]);
%             end
            pcnt = pcnt+1;
            
            MavLink_in = parseMavLinkPacketSLV(p_in.bytes);
            messageName = fieldnames(MavLink_in);
            
            p_ot = encodeMavLinkPacketSLV(MavLink_in.(messageName{1}));
            
            fprintf('%3.3d ', p_in.bytes); fprintf('\n');
            fprintf('%3.3d ', p_ot.bytes); fprintf('\n\n');
        end
    end
    fclose(pfp);

    disp('Done Processing')
    toc(tstart);
return
