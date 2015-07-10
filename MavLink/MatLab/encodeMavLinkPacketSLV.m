function p = encodeMavLinkPacketSLV(S)
    p.head = uint8(0);
    p.len = uint8(0);
    p.count = uint8(0);
    p.sysid = uint8(0);
    p.id = uint8(0);
    p.messid = uint8(0);
    p.data = uint8(0);
    p.chksum = uint8(0);
    switch (S.h_head)
        case 85 %% MavLink 0.9 message
            %MavLink = parseMavLinkPacket_APM_2_23(MavLink,p);
            p.bytes = encodeMavLink_v0_9_Packet(S)';
            
        case 254 %% MavLink 1.0 message
            p.bytes = encodeMavLink_v1_0_Packet(S)';
            
    end
    p.head   = uint8(p.bytes(1));
    p.len    = uint8(p.bytes(2));
    p.count  = uint8(p.bytes(3));
    p.sysid  = uint8(p.bytes(4));
    p.id     = uint8(p.bytes(5));
    p.messid = uint8(p.bytes(6));
    p.data   = uint8(p.bytes(7:end-2));
    p.chksum = uint8(p.bytes(end-1:end));
return
    
