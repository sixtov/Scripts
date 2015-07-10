function packet = extractPacket(data,idx,pfp)
    global pdate;
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
    
    if (~checkHeader(data(idx:idx+5),idx))
        return;
    end
    
    if (~vchecksum(data(psx:pex),data(csx:cex)))
        %fprintf('*%d,%d,%d,%d,%d,%d]{',data(idx:idx+5))
        %fprintf('0x%0x ',data(idx+6:idx+min([20 cex-idx])))
        %fprintf('} checksum failed\n')
        return
    end
    
    % 8-byte date + 
    packet.packetID = packetID;
    if (ddx<1)
        packet.date = uint8(zeros(1,8));
    else
        packet.date   = data(ddx:ddx+7);
    end
    pdate = packet.date;

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
    packet.bytes = [packet.head; ...
                    packet.len; ...
                    packet.count; ...
                    packet.sysid; ...
                    packet.id; ...
                    packet.messid; ...
                    packet.data; ...
                    packet.chksum];

    fprintf(pfp,'[%2d,%3d,%3d,%3d,%3d,%3d]{ ',data(idx:idx+5));
    fprintf(pfp,'0x%02x ',data(idx+6:cex));
    fprintf(pfp,'}\n');
return

function vhead = checkHeader(header,idx)
    global packetID;
    global oldPacketID;
    global newPacketID;
    
    vhead = 0;
    
    switch (packetID)
        case oldPacketID
            MAVLINK_MESSAGE_LENGTHS = uint8(getMavLinkMessageLengthArray_v0_9());   %%uint8([5, 4, 8, 14, 8, 28, 3, 32, 0, 2, 3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 19, 2, 23, 21, 0, 37, 26, 101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36, 4, 4, 2, 2, 4, 2, 2, 3, 14, 12, 18, 16, 8, 27, 25, 18, 18, 24, 24, 0, 0, 0, 26, 16, 36, 5, 6, 56, 26, 21, 18, 0, 0, 18, 20, 20, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 8, 4, 12, 15, 13, 6, 15, 14, 0, 12, 3, 8, 28, 36, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 14, 14, 51, 5]);
        case newPacketID
            MAVLINK_MESSAGE_LENGTHS = uint8(getMavLinkMessageLengthArray_v1_0());   %%uint8([9, 31, 12, 0, 14, 28, 3, 32, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 20, 2, 25, 23, 30, 101, 22, 26, 16, 14, 28, 32, 28, 28, 22, 22, 21, 6, 6, 37, 4, 4, 2, 2, 4, 2, 2, 3, 13, 12, 19, 17, 15, 15, 27, 25, 18, 18, 20, 20, 9, 34, 26, 46, 36, 0, 6, 4, 0, 21, 18, 0, 0, 0, 20, 0, 33, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 56, 42, 33, 0, 0, 0, 0, 0, 0, 0, 26, 32, 32, 20, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 8, 4, 12, 15, 13, 6, 15, 14, 0, 12, 3, 8, 28, 44, 3, 9, 22, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 30, 18, 18, 51, 9, 0]);
    end
    
    messLength = MAVLINK_MESSAGE_LENGTHS(header(6)+1);
    if ((header(1)==packetID) && (header(2)==messLength))
        vhead = 1;
        %fprintf('Head:%s\n',sprintf('%02x,',header))
%     else
%         if (messLength ~= 0)
%             msg = sprintf('BH(%d):%s\t',idx,sprintf('%02x,',header));
%             if ((header(1)~=packetID)), msg = sprintf('%s h[1] %02x!=%02x\t',msg,header(1),packetID); end
%             if ((header(2)~=messLength)), msg = sprintf('%s h[2] %02x!=%02x\t',msg,header(2),messLength); end
%             disp(msg);
%         end
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
