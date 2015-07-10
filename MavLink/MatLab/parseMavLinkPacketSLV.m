function MavLink = parseMavLinkPacketSLV(p)
    packetID = p(1);
    switch (packetID)
        case 85 %% MavLink 0.9 message
            %MavLink = parseMavLinkPacket_APM_2_23(MavLink,p);
            MavLink = parseMavLink_v0_9_Packet(p);

        case 254 %% MavLink 1.0 message
            MavLink = parseMavLink_v1_0_Packet(p);

    end    
return
    
