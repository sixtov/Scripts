%% XML File Parse
function parse_APM_XML()
    %Mess = [parseXML('slvMessage.xml'); parseXML('common_MAVLINK_1.0.xml'); parseXML('ardupilotmega_MAVLINK_1.0.xml')];
    Mess = [parseXML('MavLink1.0_common.xml'); parseXML('MavLink1.0_ardupilotmega.xml')];
    if (~isempty(Mess))
        genScript(Mess,1);   
        genJavaCode(Mess,1);   
        genAPMCode(Mess,1);   
        genGSCode(Mess,1);   
    end

    Mess = [parseXML('slvMessage.xml'); parseXML('common_APM_2.27.xml'); parseXML('ardupilotmega_APM_2.27.xml')];
    if (~isempty(Mess))
        genScript(Mess,0);   
        genJavaCode(Mess,0);   
        genAPMCode(Mess,0);   
        genGSCode(Mess,0);   
    end
return

%% Generate MATLab Script based on XML data
function genScript(Mess,version)
    switch (version)
        case 0
            %fp = fopen('parseMavLinkPacket_APM_2_23.m','w');
            fp = fopen('parseMavLink_0_9_Packet.m','w');
            fprintf(fp,'function S = parseMavLink_0_9_Packet(S,p)\n');
        case 1
            fp = fopen('parseMavLink_1_0_Packet.m','w');
            fprintf(fp,'function S = parseMavLink_1_0_Packet(S,p)\n');
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
    fprintf(fp,'\tswitch(p.messid)\n');
    K = length(Mess);
    for i=1:K
        fprintf(fp,sprintf('\t\tcase %s\n',Mess(i).id));
        fprintf(fp,sprintf('%s',Mess(i).cdesc));
        fprintf(fp,sprintf('\t\t\tS.%s = parse_%s(S.%s,p);\n',Mess(i).name,Mess(i).name,Mess(i).name));
    end
    fprintf(fp,'\t\totherwise\n');
    fprintf(fp,'\t\t\tdisp(sprintf(''Unknown Message: id[%%d]'',p.messid))\n');
    fprintf(fp,'\tend\n');
    fprintf(fp,'return\n');
    for i=1:K
        fprintf(fp,'\n');
        fprintf(fp,sprintf('%%%%%%%%  case: %s\n',Mess(i).id));
        fprintf(fp,sprintf('%s',Mess(i).fdesc));
        fprintf(fp,sprintf('function S = parse_%s(S,p)\n',Mess(i).name));
        N = size(Mess(i).fields.name,1);

        %% name member
        fprintf(fp,'\tname = [ ...\n');
        ml = 0;
        for j=1:N
            ml = max([ml length(Mess(i).fields.name{j})]);
        end
        ml = 4*ceil(ml/4);

        for j=1:N
            padL = ceil((ml-length(Mess(i).fields.name{j}))/4);
            pad = char(9*ones(1,padL));
            fprintf(fp,sprintf('\t\t{''%s''}%s ... ',Mess(i).fields.name{j},pad));
            if ~isempty(Mess(i).fields.desc{j})
                fprintf(fp,'%%%% ');
                fprintf(fp,Mess(i).fields.desc{j});
            end
            fprintf(fp,'\n');
        end
        fprintf(fp,'\t\t];\n');

%         %% byte member
%         fprintf(fp,'\tbyte = [ ...\n');
%         for j=1:N
%             fprintf(fp,sprintf('\t\t%d ...\n',Mess(i).fields.byte{j}));
%         end
%         fprintf(fp,'\t\t];\n');
% 
%         %% type member
%         fprintf(fp,'\ttype = [ ...\n');
%         for j=1:N
%             fprintf(fp,sprintf('\t\t{''%s''} ...\n',Mess(i).fields.type{j}));
%         end
%         fprintf(fp,'\t\t];\n');

        %% byte member
        fprintf(fp,'\tbyte = [ ');
        for j=1:N
            fprintf(fp,sprintf('%d ',Mess(i).fields.byte{j}));
        end
        fprintf(fp,'];\n');

        %% type member
        fprintf(fp,'\ttype = [ ');
        for j=1:N
            fprintf(fp,sprintf('{''%s''} ',Mess(i).fields.type{j}));
        end
        fprintf(fp,'];\n');
        
        fprintf(fp,'\tif (sum(byte) == p.len)\n');
        fprintf(fp,'\t\tS = buildStruct(S,byte,name,type,p);\n');
        fprintf(fp,'\telse\n');
        fprintf(fp,'\t\tdisp(''bytes in packet did not match structure size'')\n');
        fprintf(fp,'\tend\n');

        fprintf(fp,'return\n\n');
    end
    fclose(fp);
    
    switch (version)
        case 0
            fp = fopen('initMavLink_0_9.m','w');
            fprintf(fp,'function MavLink = initMavLink_0_9()\n');
        case 1
            fp = fopen('initMavLink_1_0.m','w');
            fprintf(fp,'function MavLink = initMavLink_1_0()\n');
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
    for i=1:K
        %fprintf(fp,sprintf('\tMavLink.%s = struct();\n',Mess(i).name));
        fprintf(fp,sprintf('\tMavLink.%s = [];\n',Mess(i).name));
    end
    fprintf(fp,'return\n');

    fclose(fp);
    disp('Done!!!!')
return

%% Generate Java Code based on XML data
function genJavaCode(Mess,LOCAL)
%     if (LOCAL)
%         dDir = 'Java\\packet';
%     else
%         dDir = 'Java\\AP';
%     end
    if (LOCAL)
        dDir = 'Java\\Mav10';
    else
        dDir = 'Java\\Mav09';
    end
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end

%% initialization
    %specialHandlingIDs = [25 32 73 111];
    
    %% Generate function header
    K = length(Mess);
    msgWithSystem = [];
    msgWithComponent = [];
    for i=1:K   % For each MavLink message
        msgWithSystemBool = strcmp('target_system',Mess(i).fields.name);
        msgWithSystemIdx = find(msgWithSystemBool);
        if (any(msgWithSystemBool))
            msgWithSystem = [msgWithSystem; i];
        end
        msgWithComponentBool = strcmp('target_component',Mess(i).fields.name);
        msgWithComponentIdx = find(msgWithComponentBool);
        if (any(strcmp('target_component',Mess(i).fields.name)))
            msgWithComponent = [msgWithComponent; i];
        end
        N = size(Mess(i).fields.name,1);
        ID = sscanf(Mess(i).id,'%d');
%         packetSize = sum(cell2mat(Mess(i).fields.byte));
        
%        specialFunction = ~isempty(intersect(ID,specialHandlingIDs));

        %% Do MavLink to java types substitution
        java.name = Mess(i).fields.name;
        java.type = Mess(i).fields.type;
        java.byte = Mess(i).fields.byte;
        for j=1:N
            switch(Mess(i).fields.type{j})
                case 'single'
                    Mess(i).fields.type{j} = 'float';
                    java.type{j} = 'float';
                case 'int64'
                    Mess(i).fields.type{j} = 'long';
                    java.type{j} = 'long';
                case 'int32'
                    Mess(i).fields.type{j} = 'int';
                    java.type{j} = 'int';
                case 'int16'
                    Mess(i).fields.type{j} = 'short';
                    java.type{j} = 'short';
                case 'int8'
                    switch(Mess(i).fields.byte{j})
                        case 1
                            Mess(i).fields.type{j} = 'byte';
                            java.type{j} = 'byte';
                        otherwise
                            Mess(i).fields.type{j} = sprintf('byte[]');
                            java.type{j} = sprintf('byte[]');
                    end
                case 'uint64'
                    Mess(i).fields.type{j} = 'long';
                    java.type{j} = 'long';
                case 'uint32'
                    Mess(i).fields.type{j} = 'int';
                    java.type{j} = 'long';
                    java.byte{j} = 2*Mess(i).fields.byte{j};
                case 'uint16'
                    Mess(i).fields.type{j} = 'short';
                    java.type{j} = 'int';
                    java.byte{j} = 2*Mess(i).fields.byte{j};
                case 'uint8'
                    switch(Mess(i).fields.byte{j})
                        case 1
                            Mess(i).fields.type{j} = 'byte';
                            java.type{j} = 'short';
                            java.byte{j} = 2*Mess(i).fields.byte{j};
                        otherwise
                            Mess(i).fields.type{j} = sprintf('byte[]');
                            java.type{j} = sprintf('byte[]');
                            java.byte{j} = Mess(i).fields.byte{j};
                    end
                otherwise
                    disp(sprintf(' ''%s'' type may not have java equivalent',Mess(i).fields.type{j}))
            end
        end

        %% Max name and type lengths
        ml = 0;
        tl = 0;
        needBB = 0;
        for j=1:N
            ml = max([ml length(java.name{j})]);
            tl = max([tl length(java.type{j})]);
            needBB = needBB || java.byte{j}>Mess(i).fields.byte{j};
        end
        ml = 4*ceil(ml/4);
        tl = 4*ceil(tl/4);
        tpad = java.type;   %preallocates memory for tpad cell array
        mpad = java.type;   %same as above
        for j=1:N
            tpad{j} = char(9*ones(1,ceil((tl-length(java.type{j}))/4)));
            mpad{j} = char(9*ones(1,ceil((ml-length(Mess(i).fields.name{j}))/4)));
        end
    
%% Function Header
        newf = sprintf('%s\\%s_class.java',dDir,Mess(i).name);
        fp = fopen(newf,'w');
    if (LOCAL)
        fprintf(fp,'//MavLink 1.0\n\n');
    else
        fprintf(fp,'//MavLink 0.9\n\n');
    end
        fprintf(fp,'package gov.nasa.larc.AP;\n\n');
        fprintf(fp,'import gov.nasa.larc.serial.Loggable;\n');
%     if (sum(cell2mat(java.byte)) ~= ...
%         sum(cell2mat(Mess(i).fields.byte)))
%         fprintf(fp,'import java.nio.ByteBuffer;\n');
%         fprintf(fp,'import java.nio.ByteOrder;\n\n');
%     end
        fprintf(fp,'\n/**\n');
        fprintf(fp,sprintf('Message ID: %s(%d)\n',Mess(i).name,ID));
        fprintf(fp,'--------------------------------------\n');
        fprintf(fp,sprintf('%s',Mess(i).fdesc));
        fprintf(fp,'--------------------------------------\n');
        fprintf(fp,'*/\n');

        %fprintf(fp,'public class %s_class extends MavCheckSum\n{\n',Mess(i).name);
        fprintf(fp,'public class %s_class',Mess(i).name);
        if (~LOCAL)
            fprintf(fp,' implements Loggable');
        else
            fprintf(fp,' //implements Loggable');
        end
        fprintf(fp,'\n{\n');
        %% Declare member variables
        %fprintf(fp,'\tHeader_class head;\n');
        fprintf(fp,'\tpublic static final int msgID = %d;\n',ID);
        for j=1:N
            switch(java.type{j})
                case 'byte[]'
                    fprintf(fp,'\tpublic %s%s %s = new byte[%d];%s',java.type{j}, tpad{j}, Mess(i).fields.name{j},java.byte{j}, mpad{j});
                otherwise
                    fprintf(fp,'\tpublic %s%s %s;%s '              ,java.type{j}, tpad{j}, Mess(i).fields.name{j}, mpad{j});
            end
            if ~isempty(Mess(i).fields.desc{j})
                fprintf(fp,'\t// ');
                fprintf(fp,Mess(i).fields.desc{j});
            end
            fprintf(fp,'\n');
        end
        fprintf(fp,'\n');
        if (LOCAL)
            fprintf(fp,'\tprivate packet rcvPacket;\n');
            fprintf(fp,'\tprivate packet sndPacket;\n\n');
        else
            fprintf(fp,'\tprivate packet rcvPacket;\n');
            fprintf(fp,'\tprivate packet sndPacket;\n\n');
        end
        
%% Constructor
        fprintf(fp,sprintf('\tpublic %s_class()\n\t{\n',Mess(i).name));
        if (LOCAL)
            fprintf(fp,'\t\trcvPacket = new packet(msgID);\n');
            fprintf(fp,'\t\tsndPacket = new packet(msgID);\n');
        else
            fprintf(fp,'\t\trcvPacket = new packet(msgID);\n');
            fprintf(fp,'\t\tsndPacket = new packet(msgID);\n');
        end
        if (intersect(i,msgWithSystem))
            fprintf(fp,'\t\ttarget_system = 1;\n');
        end
        if (intersect(i,msgWithComponent))
            fprintf(fp,'\t\ttarget_component = 1;\n');
        end
        fprintf(fp,'\t}\n\n');

%% Copy Constructor
        fprintf(fp,sprintf('\tpublic %s_class(%s_class o)\n\t{\n',Mess(i).name,Mess(i).name));
        for j=1:N
            fprintf(fp,'\t\t%s = o.%s;\n',Mess(i).fields.name{j},Mess(i).fields.name{j});
        end
        fprintf(fp,'\t}\n\n');

%% First Parse Function
        fprintf(fp,'\tpublic boolean parse(byte[] b)\n\t{\n');
        fprintf(fp,'\t\treturn parse(b, false);\n');
        fprintf(fp,'\t}\n\n');
%% Second Parse Function
        fprintf(fp,'\tpublic boolean parse(byte[] b, boolean valid)\n\t{\n');
        fprintf(fp,'\t\trcvPacket.load(b);\n\n');
        %% Begin parsing from array
        fprintf(fp,'\t\tboolean pstatus = valid || rcvPacket.isPacket();\n');
        fprintf(fp,'\t\tif (pstatus)\n');
        fprintf(fp,'\t\t{\n');

%         fprintf(fp,'\t\t\t//head.updateRcvSeq();\n\n');
        fprintf(fp,'\t\t\trcvPacket.updateSeqNum();\n\n');
%         if(needBB)
%             fprintf(fp,'\t\t\tbyte[] temp = {0,0,0,0,0,0,0,0};\n');
%             fprintf(fp,'\t\t\tByteBuffer BB = ByteBuffer.wrap(temp);\n\n');
%         end
%         fprintf(fp,'\t\t\tByteBuffer p = ByteBuffer.wrap(packet);\n');
        
        %% define MavLink member lengths (in bytes)
        fprintf(fp,'\t\t\t// int[] mavLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',Mess(i).fields.byte{j});
            else
                fprintf(fp,'%d, ',Mess(i).fields.byte{j});
            end
        end
        fprintf(fp,'};\n');

        %% define java variable lengths (in bytes)
        fprintf(fp,'\t\t\t// int[] javLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',java.byte{j});
            else
                fprintf(fp,'%d, ',java.byte{j});
            end
        end
        fprintf(fp,'};\n\n');

%         fprintf(fp,'\t\t\trcvPacket.pBuf.position(packet.DATA_OFFSET);     // Skip the packet header\n');
        for j=1:N
            mpad = char(9*ones(1,ceil((ml+1-length(Mess(i).fields.name{j}))/4)));
            vname = Mess(i).fields.name{j};
            if (java.byte{j} == Mess(i).fields.byte{j})
                switch(java.type{j})
                    case 'byte'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.pBuf.get();\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getByte();\n',vname,mpad);
                    case 'short'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.pBuf.getShort();\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getShort();\n',vname,mpad);
                    case 'int'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.pBuf.getInt();\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getInt();\n',vname,mpad);
                    case 'long'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.pBuf.getLong();\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getLong();\n',vname,mpad);
                    case 'float'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.pBuf.getFloat();\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getFloat();\n',vname,mpad);
                    otherwise
                        %fprintf(fp,'\t\t\trcvPacket.pBuf.get(%s, 0, %d);\n',vname,Mess(i).fields.byte{j});
                        fprintf(fp,'\t\t\trcvPacket.getByte(%s, 0, %d);\n',vname,Mess(i).fields.byte{j});
                end
            else
                switch(java.type{j})
                    case 'short'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.BB.putLong(0,0L).put(0,rcvPacket.pBuf.get()).getShort(0);\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getShortB();\n',vname,mpad);
                    case 'int'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.BB.putLong(0,0L).putShort(0,rcvPacket.pBuf.getShort()).getInt(0);\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getIntS();\n',vname,mpad);
                    case 'long'
                        %fprintf(fp,'\t\t\t%s%s= rcvPacket.BB.putLong(0,0L).putInt(0,rcvPacket.pBuf.getInt()).getLong(0);\n',vname,mpad);
                        fprintf(fp,'\t\t\t%s%s= rcvPacket.getLongI();\n',vname,mpad);
                    otherwise
                        %%fprintf(fp,'\t// Don''t know how to handle this case\n\t// %s = buf.get????();\n',vname);
                        fprintf(fp,'//\tERROR\tParsing a ''%s'' from a ''%s''\n',java.type{j},Mess(i).fields.type{j});
                end
%                 fprintf(fp,'\tBB.putLong(0,0L);\n');
            end
        end

        %% Close function
        fprintf(fp,'\t\t}\n');
        fprintf(fp,'\t\treturn(pstatus);\n');
        fprintf(fp,'\t}\n\n');

%% Now begins the FIRST encode section
        fprintf(fp,'\tpublic byte[] encode()\n\t{\n');
        fprintf(fp,'\t\treturn encode(\n');
        for j=1:N
            if (j==1)
                if (j==msgWithSystemIdx)
                    fprintf(fp,'\t\t\t\t\t  (%s)1\n',java.type{j});
                elseif (j==msgWithComponentIdx)
                    fprintf(fp,'\t\t\t\t\t  (%s)1\n',java.type{j});
                else
                    fprintf(fp,'\t\t\t\t\t  %s\n',Mess(i).fields.name{j});
                end
            else
                if (j==msgWithSystemIdx)
                    fprintf(fp,'\t\t\t\t\t ,(%s)1\n',java.type{j});
                elseif (j==msgWithComponentIdx)
                    fprintf(fp,'\t\t\t\t\t ,(%s)1\n',java.type{j});
                else
                    fprintf(fp,'\t\t\t\t\t ,%s\n',Mess(i).fields.name{j});
                end
            end
        end
        fprintf(fp,sprintf( '\t\t\t\t\t );\n'));
        fprintf(fp,'\t}\n\n');

%% Now begins the optional SECOND encode section
        if (~isempty([msgWithSystemIdx msgWithComponentIdx]) && (N>length([msgWithSystemIdx msgWithComponentIdx])))
            fprintf(fp,'\tpublic byte[] encode(\n');
            first = 1;
            for j=1:N
                if (first)
                    if (~any(intersect(j,[msgWithSystemIdx msgWithComponentIdx])))
                        fprintf(fp,'\t\t\t\t\t\t %s v_%s\n',java.type{j},Mess(i).fields.name{j});
                        first = 0;
                    end
                else
                    if (~any(intersect(j,[msgWithSystemIdx msgWithComponentIdx])))
                        fprintf(fp,'\t\t\t\t\t\t,%s v_%s\n',java.type{j},Mess(i).fields.name{j});
                    end
                end
            end
            fprintf(fp,sprintf( '\t\t\t\t\t\t)\n\t{\n'));

            fprintf(fp,'\t\treturn encode(\n');
            for j=1:N
                if (j==1)
                    if (j==msgWithSystemIdx)
                        fprintf(fp,'\t\t\t\t\t    (%s)1\n',java.type{j});
                    elseif (j==msgWithComponentIdx)
                        fprintf(fp,'\t\t\t\t\t    (%s)1\n',java.type{j});
                    else
                        fprintf(fp,'\t\t\t\t\t  v_%s\n',Mess(i).fields.name{j});
                    end
                else
                    if (j==msgWithSystemIdx)
                        fprintf(fp,'\t\t\t\t\t ,  (%s)1\n',java.type{j});
                    elseif (j==msgWithComponentIdx)
                        fprintf(fp,'\t\t\t\t\t ,  (%s)1\n',java.type{j});
                    else
                        fprintf(fp,'\t\t\t\t\t ,v_%s\n',Mess(i).fields.name{j});
                    end
                end
            end
            fprintf(fp,sprintf( '\t\t\t\t\t );\n'));
            fprintf(fp,'\t}\n\n');
        end

%% Now begins the THIRD encode section
        fprintf(fp,'\tpublic byte[] encode(\n');
        for j=1:N
            if (j==1)
                ftext = sprintf('\t\t\t\t\t\t %s v_%s\n',java.type{j},Mess(i).fields.name{j});
            else
                ftext = sprintf('\t\t\t\t\t\t,%s v_%s\n',java.type{j},Mess(i).fields.name{j});
            end
            fprintf(fp,'%s',ftext);
        end
        fprintf(fp,sprintf( '\t\t\t\t\t\t)\n\t{\n'));
        
        %% Body of encode function
        %fprintf(fp,'\t\tpacket pkt = new packet(msgID);\n');
%         if(needBB)
%             fprintf(fp,'\t\tbyte[] temp = {0,0,0,0,0,0,0,0};\n');
%             fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.wrap(temp);\n\n');
%         end
%         fprintf(fp,'\t\tbyte[] msg = new byte[%d];\t// includes header and checksum\n',packetSize+8);
%         fprintf(fp,'\t\tByteBuffer p = ByteBuffer.wrap(msg);\n\n');

        %% define MavLink member lengths (in bytes)
        fprintf(fp,'\t\t// int[] mavLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',Mess(i).fields.byte{j});
            else
                fprintf(fp,'%d, ',Mess(i).fields.byte{j});
            end
        end
        fprintf(fp,'};\n');

        %% define java variable lengths (in bytes)
        fprintf(fp,'\t\t// int[] javLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',java.byte{j});
            else
                fprintf(fp,'%d, ',java.byte{j});
            end
        end
        fprintf(fp,'};\n\n');
%         fprintf(fp,'\t\t// encode the header for Message ID: %d\n',ID);
%         fprintf(fp,'\t\tMavHeader head = new MavHeader((byte)%d);\n',ID);
%         fprintf(fp,'\t\tp.put(head.getHeader(),0,MavHeader.HEADER_SIZE);\n\n');

%         fprintf(fp,'\t\tsndPacket.pBuf.position(packet.DATA_OFFSET);\n');
        fprintf(fp,'\t\tsndPacket.setSndSeq();\n\n');
        fprintf(fp,'\t\tsndPacket.resetDataIdx();\n');
        for j=1:N
            if (Mess(i).fields.byte{j} == java.byte{j})
                switch(java.type{j})
                    case 'byte'
                        %fprintf(fp,'\t\tsndPacket.pBuf.put(v_%s);',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putByte(v_%s);',Mess(i).fields.name{j});
                    case 'short'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putShort(v_%s);',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putShort(v_%s);',Mess(i).fields.name{j});
                    case 'int'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putInt(v_%s);',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putInt(v_%s);',Mess(i).fields.name{j});
                    case 'long'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putLong(v_%s);',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putLong(v_%s);',Mess(i).fields.name{j});
                    case 'float'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putFloat(v_%s);',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putFloat(v_%s);',Mess(i).fields.name{j});
                    otherwise
                        %fprintf(fp,'\t\tsndPacket.pBuf.put(v_%s,0,%d);',Mess(i).fields.name{j},Mess(i).fields.byte{j});
                        fprintf(fp,'\t\tsndPacket.putByte(v_%s,0,%d);',Mess(i).fields.name{j},Mess(i).fields.byte{j});
                end
            else
                switch(java.type{j})
                    case 'short'
                        %fprintf(fp,'\t\tsndPacket.pBuf.put(sndPacket.BB.putShort(0,v_%s).get(0));',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putByteS(v_%s);',Mess(i).fields.name{j});
                    case 'int'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putShort(sndPacket.BB.putInt(0,v_%s).getShort(0));',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putShortI(v_%s);',Mess(i).fields.name{j});
                    case 'long'
                        %fprintf(fp,'\t\tsndPacket.pBuf.putInt(sndPacket.BB.putLong(0,v_%s).getInt(0));',Mess(i).fields.name{j});
                        fprintf(fp,'\t\tsndPacket.putIntL(v_%s);',Mess(i).fields.name{j});
                    otherwise
                        %%fprintf(fp,'\t// Don''t know how to handle this case\n\t// %s = buf.get????();\n',vname);
                        fprintf(fp,'//\tERROR\tEncoding a ''%s'' from a ''%s''\n',Mess(i).fields.type{j},java.type{j});
                end
            end
            fprintf(fp,'\t// Add "%s" parameter\n',Mess(i).fields.name{j});
        end

        fprintf(fp,'\n\t\t// encode the checksum\n');
        fprintf(fp,'\n\t\tsndPacket.putChkSum();\n');
%         fprintf(fp,'\t\tp.order(java.nio.ByteOrder.LITTLE_ENDIAN);\n');
%         fprintf(fp,'\t\tp.putShort(MavCheckSum.getChecksum(msg));\n');
        
        fprintf(fp,'\n\t\treturn sndPacket.getPacket();\n');
%         fprintf(fp,'\n\t\treturn sndPacket.sndPacket;\n');
%         fprintf(fp,'\n\t\treturn msg;\n');
        fprintf(fp,'\t}\n\n');

        
%% Loggable
    fprintf(fp,'\tpublic String getLogHeader()\n');
    fprintf(fp,'	{\n');
    fprintf(fp,'		String param = (\n');
    fprintf(fp,'				  "  time"\n');
% 				+ ", insert var name"
    for j=1:N
        fprintf(fp,' 				+ ", %s_%s"\n',Mess(i).name,Mess(i).fields.name{j});
    end
    fprintf(fp,'				);\n');
    fprintf(fp,'		return param;\n');
    fprintf(fp,'	}\n\n');

    fprintf(fp,'    public String getLogData()\n');
    fprintf(fp,'	{\n');
    fprintf(fp,'		String param = (\n');
    fprintf(fp,'				System.currentTimeMillis()\n');
% 				+ ", " + var ...
    for j=1:N
        fprintf(fp,' 				+ ", " + %s\n',Mess(i).fields.name{j});
    end
    fprintf(fp,'				);\n');
    fprintf(fp,'		return param;\n');
    fprintf(fp,'	}\n');
        
        
%%        
        fprintf(fp,'}\n'); %% End of MavLink Class
        fclose(fp); fp = [];
    end   % For each MavLink message
    

%% Generate the MavLink Class
    fp = fopen(sprintf('%s\\APData.java',dDir),'w');
    if (~LOCAL)
        fprintf(fp,'package gov.nasa.larc.AP;\n\n');
    end
    %fprintf(fp,'import java.nio.ByteBuffer;\n\n');
    fprintf(fp,'/**\n * @author svazquez\n *\n */\n');
    fprintf(fp,'public class APData\n{\n');

    %% Max name and type lengths
    ml = 0;
    for i=1:K
        ml = max([ml length(Mess(i).name)]);
    end
    ml = 4*ceil((ml+17)/4);

    for i=1:K   % For each MavLink message
        %mpad = char(20*ones(1,ml+1-length(Mess(i).name)));
        ntabs = ceil((ml-(length(Mess(i).name)+24))/4);
        mpad = char(9*ones(1,ntabs));
        %%disp(sprintf('%s %d',Mess(i).name,length(mpad)));
        fprintf(fp,'\tpublic static %s_class%s\t%s%s\t= new %s_class();%s\t// (%s)\n',Mess(i).name,mpad,Mess(i).name,mpad,Mess(i).name,mpad,Mess(i).id);
    end
    
%%
    fprintf(fp,'\n\tpublic static boolean processPacket(byte[] pkt, boolean valid)\n');
    fprintf(fp,'\t{\n');
    fprintf(fp,'\t\tswitch(pkt[5])\n');
    fprintf(fp,'\t\t{\n');
    for i=1:K
        fprintf(fp,'\t\t\tcase (byte)%s:',Mess(i).id);
        %fprintf(fp,'\t\t\t\t%s = new %s_class();\n',Mess(i).name,Mess(i).name);
        fprintf(fp,'\treturn(%s.parse(pkt, valid));\n',Mess(i).name);
    end
    fprintf(fp,'\t\t\tdefault:\n\t\t\t\treturn(false);\n');
    fprintf(fp,'\t\t}\n');
    fprintf(fp,'\t}\n');
    
%% Init function
    fprintf(fp,'\n\tpublic static void initMessages()\n');
    fprintf(fp,'\t{\n');
    for i=1:K
        if (intersect(i,msgWithSystem))
            fprintf(fp,'\t\t%s.target_system = 1;\n',Mess(i).name);
        end
        if (intersect(i,msgWithComponent))
            fprintf(fp,'\t\t%s.target_component = 1;\n',Mess(i).name);
        end
    end
    fprintf(fp,'\t}\n');
    
%% List All Messages, All parameters
%     fprintf(fp,'/*\n');
%     for i=1:K
%         N = size(Mess(i).fields.name,1);
%         ml = 0;
%         for j=1:N
%             ml = max(ml,8+length(Mess(i).fields.name{j}));
%         end
%         ml = 4*(ceil(ml/4));
%         fprintf(fp,'\t%s\t%s\n',Mess(i).name,Mess(i).fdesc);
%         N = size(Mess(i).fields.name,1);
%         for j=1:N
%             padL = ceil((ml-length(Mess(i).fields.name{j}))/4);
%             pad = char(9*ones(1,padL));
%             fprintf(fp,'\t\t%s%s%s\n',Mess(i).fields.name{j},pad,Mess(i).fields.desc{j});
%         end
%     end
%     fprintf(fp,'*/\n');
    
%% 
    fprintf(fp,'}\n');
    fclose(fp);
    
%% Header Object
    fp = fopen(sprintf('%s\\MavHeader.java',dDir),'w');
    if (~LOCAL)
        fprintf(fp,'package gov.nasa.larc.AP;\n\n');
    end
    %fprintf(fp,'import java.nio.ByteBuffer;\n\n');
    fprintf(fp,'public class MavHeader\n');
    fprintf(fp,'{\n');

    %% Generate Message Length Array
    jSize = zeros(1,256);
    K = length(Mess);
    for i=1:K   % For each MavLink message
        idx = 1+sscanf(Mess(i).id,'%d');
        jSize(idx) = sum(cell2mat(Mess(i).fields.byte));
    end
    fprintf(fp,'\t//                                          {');
    for i=1:256
        if (mod(i-1,10)==0)
            fprintf(fp,'%3d,',i-1);
        else
            if (i==256)
                fprintf(fp,'   ');
            else
                fprintf(fp,'   ,');
            end
        end
    end
    fprintf(fp,'};\n');
    fprintf(fp,'\tpublic static final byte[] MsgLengthArray = {');
    for i=1:256
        if (i==256)
            fprintf(fp,'%3d',jSize(i));
        else
            fprintf(fp,'%3d,',jSize(i));
        end
    end
    fprintf(fp,'};\n\n');
    
    %%
%     fprintf(fp,'\tstatic final short HEADER_SIZE = 6;\n');
%     fprintf(fp,'\tstatic final short CHKSUM_SIZE = 2;\n');
%     fprintf(fp,'\tstatic final byte  MAV_MARKER  = (byte) 85;\n');
%     fprintf(fp,'\tstatic final byte  BEAGLE_ID   = (byte)103;\n');
%     fprintf(fp,'\tstatic final byte  AP_ID       = (byte)  1;\n');
%     fprintf(fp,'\tstatic final byte  XBEE_ID     = (byte)255;\n');
%     fprintf(fp,'\tstatic final byte  COMP_ID     = (byte)  1;\n');
    
    %%
%     fprintf(fp,'\n\tboolean vHeader;\n');
%     fprintf(fp,'\tbyte msgHead;\n');
%     fprintf(fp,'\tbyte msgLen;\n');
%     fprintf(fp,'\tbyte msgSeq;\n');
%     fprintf(fp,'\tbyte msgSid;\n');
%     fprintf(fp,'\tbyte msgCid;\n');
%     fprintf(fp,'\tbyte msgGid;\n\n');
%     fprintf(fp,'\tstatic byte RcvSeq;\n');
%     fprintf(fp,'\tstatic byte PreRcvSeq;\n');
%     fprintf(fp,'\tstatic byte SndSeq = 0;\n\n');

    %% Contruct Header from byte[]. 
    %% Usually implies that a packet is being RECEIVED!
%     fprintf(fp,'\tpublic MavHeader(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tvHeader = isValid(hdr);\n');
%     fprintf(fp,'\t\tif (!vHeader)\treturn;\n\n');
%     fprintf(fp,'\t\tmsgHead = hdr[0];\n');
%     fprintf(fp,'\t\tmsgLen  = hdr[1];\n');
%     fprintf(fp,'\t\tmsgSeq  = hdr[2];\n');
%     fprintf(fp,'\t\tmsgSid  = hdr[3];\n');
%     fprintf(fp,'\t\tmsgCid  = hdr[4];\n');
%     fprintf(fp,'\t\tmsgGid  = hdr[5];\n');
%     fprintf(fp,'\t\tPreRcvSeq = RcvSeq;\n');
%     fprintf(fp,'\t\tRcvSeq    = msgSeq;\n');
%     fprintf(fp,'\t}\n\n');
    
    %% Contruct a Header for a Message with ID "mid"
    %% Usually implies constructing a packet to be SENT!
%     fprintf(fp,'\tpublic MavHeader(byte mid)\n\t{\n');
%     fprintf(fp,'\t\tvHeader = true;\n');
%     fprintf(fp,'\t\tmsgHead = MAV_MARKER;\n');
%     fprintf(fp,'\t\tmsgLen  = MsgLengthArray[getMsgID(mid)];\n');
%     fprintf(fp,'\t\tmsgSeq  = SndSeq++;\n');
%     fprintf(fp,'\t\tmsgSid  = BEAGLE_ID;\n');
%     fprintf(fp,'\t\tmsgCid  = COMP_ID;\n');
%     fprintf(fp,'\t\tmsgGid  = mid;\n');
%     fprintf(fp,'\t}\n\n');
    
    %% Identifies a valid RECEIVED header
%     fprintf(fp,'\tpublic boolean isValid(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tif (hdr.length<HEADER_SIZE)\treturn(false);\n');
%     fprintf(fp,'\t\treturn ((hdr[0]==MAV_MARKER)\n');
%     fprintf(fp,'\t\t      &&(hdr[1]==MsgLengthArray[getMsgID(hdr)])\n');
%     fprintf(fp,'\t\t      &&(hdr[3]==AP_ID)||(hdr[3]==XBEE_ID)||(hdr[3]==BEAGLE_ID)\n');
%     fprintf(fp,'\t\t      &&(hdr[4]==COMP_ID));\n');
%     fprintf(fp,'\t}\n\n');
    %%
%     fprintf(fp,'\tpublic boolean isValid()\n\t{\n');
%     fprintf(fp,'\t\treturn(vHeader);\n');
%     fprintf(fp,'\t}\n\n');
    
    %% Returns the header as a byte array
%     fprintf(fp,'\tpublic byte[] getHeader()\n\t{\n');
%     fprintf(fp,'\t\tbyte[] hdr = {msgHead,msgLen,msgSeq,msgSid,msgCid,msgGid};\n');
%     fprintf(fp,'\t\treturn(hdr);\n');
%     fprintf(fp,'\t}\n\n');
    
    %%
%     fprintf(fp,'\tpublic short getMsgHead(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[0]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgHead()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgHead).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgLength(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[1]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgLength()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgLen).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgLength(short idx)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,MsgLengthArray[idx]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getFullLength()\n\t{\n');
%     fprintf(fp,'\t\treturn (short)(getMsgLength()+HEADER_SIZE+CHKSUM_SIZE);\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getFullLength(short idx)\n\t{\n');
%     fprintf(fp,'\t\treturn (short)(getMsgLength(idx)+HEADER_SIZE+CHKSUM_SIZE);\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgSeq(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[2]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgSeq()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgSeq).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgSysID(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[3]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgSysID()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgSid).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgCompID(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[4]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgCompID()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgCid).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgID(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr[5]).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgID()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,msgGid).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getMsgID(byte hdr)\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,hdr).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     
%     fprintf(fp,'\tpublic short getRcvSeq()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,RcvSeq).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
%     fprintf(fp,'\tpublic short getPreRcvSeq()\n\t{\n');
%     fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.allocate(2);\n');
%     fprintf(fp,'\t\treturn (BB.putShort(0,(short)0).put(0,PreRcvSeq).getShort(0));\n');
%     fprintf(fp,'\t}\n\n');
    
    fprintf(fp,'}\n');
    fclose(fp); fp = [];

%% MavLink CheckSum Class
%     fp = fopen(sprintf('%s\\src\\MavCheckSum.java',dDir),'w');
%     if (~LOCAL)
%         fprintf(fp,'package gov.nasa.larc.MavLink_0_9;\n\n');
%     end
%     fprintf(fp,'import java.nio.ByteBuffer;\n\n');
%     fprintf(fp,'public class MavCheckSum\n');
%     fprintf(fp,'{\n');
% %     fprintf(fp,'\tprotected byte[] temp = {0,0,0,0,0,0,0,0};\n');
% %     fprintf(fp,'\tprotected ByteBuffer t = ByteBuffer.wrap(temp);\n\n');
% 
%     %%
%     fprintf(fp,'\tpublic static boolean isValid(byte[] pkt)\n');
%     fprintf(fp,'\t{\n');
%     fprintf(fp,'\t\tshort crc;\n');
%     fprintf(fp,'\t\tshort pktCRC;\n');
%     fprintf(fp,'\t\tByteBuffer pktb = ByteBuffer.wrap(pkt);\n\n');
%     fprintf(fp,'\t\tbyte N = (byte)pkt.length;\n');
%     fprintf(fp,'\t\tpktCRC = pktb.getShort(N-2);\n');
%     fprintf(fp,'\t\tcrc = getChecksum(pkt);\n');
%     fprintf(fp,'\t\treturn (boolean)(pktCRC==crc);\n');
%     fprintf(fp,'\t}\n\n');
%     
%     %%  Generate getChecksum function
%     fprintf(fp,'\t//=====================================================================================//\n');
%     fprintf(fp,'\t/**\n');
%     fprintf(fp,'\t * compute the checksum for a given message.  Use the indicated number of bytes starting\n');
%     fprintf(fp,'\t * at the second byte.\n');
%     fprintf(fp,'\t * @param msg\n');
%     fprintf(fp,'\t * @return checksum: 2 byte checksum\n');
%     fprintf(fp,'\t */\n');
%     fprintf(fp,'\t//=====================================================================================//\n');
%     fprintf(fp,'\tpublic static short getChecksum(byte[] data) \n');
%     fprintf(fp,'\t{\n');
%     fprintf(fp,'\t    int N   = data.length;\n');
%     fprintf(fp,'\t    byte b  = 0x00;\n');
%     fprintf(fp,'\t    byte ch = 0x00;\n');
%     fprintf(fp,'\t    short crc  = (short) 0xffff;\n');
% %     fprintf(fp,'\t    short ooff = (short) 0x00ff;    //255;\n');
%     fprintf(fp,'\t    short tempcrc = 0x0000;\n');
%     fprintf(fp,'\t    for (int i=1; i<N-2; i++)\n');
%     fprintf(fp,'\t    {\n');
%     fprintf(fp,'\t        b = data[i];\n');
%     fprintf(fp,'\t        ch = (byte) (b  ^  ((byte)(crc & 0x00ff) ))  ;\n');
%     fprintf(fp,'\t        ch = (byte) ((ch ^ (ch << 4) ));\n');
%     fprintf(fp,'\t        tempcrc = (short) (crc >> 8);\n');
%     fprintf(fp,'\t        tempcrc = (short) (tempcrc & 0x00ff);\n');
%     fprintf(fp,'\t        short a1 = (short) ((short)ch << 8);\n');
%     fprintf(fp,'\t        short a2 = (short) (tempcrc ^ a1);\n');
%     fprintf(fp,'\t        short a3 = (short) ((short)ch << 3);\n');
%     fprintf(fp,'\t        short a3a = (short) (a3 & 0x07ff);\n');
%     fprintf(fp,'\t        short a4 = (short) (a2 ^ a3a);\n');
%     fprintf(fp,'\t        short a5 = (short) ((short)ch >> 4);\n');
%     fprintf(fp,'\t        short a6 = (short) ((short) a5 & 0x000f);\n');
%     fprintf(fp,'\t        crc = (short) (a4 ^ a6);\n');
%     fprintf(fp,'\t    }\n\n');
% %     fprintf(fp,'\t    t.putShort(0,crc);\n');
% %     fprintf(fp,'\t    data[N++] = t.get(1);\n');
% %     fprintf(fp,'\t    data[N++] = t.get(0);\n');
% %     fprintf(fp,'\t    t.putLong(0,zero); // sets ByteBuffer t back to zero\n\n');
%     fprintf(fp,'\t    return crc;\n');
%     fprintf(fp,'\t}\n');
%     fprintf(fp,'}\n\n');
%     fclose(fp); fp = [];
% 
% % function crc = checksum_v0_9(data)
% %     MAVLINK_MESSAGE_LENGTHS = uint8([3, 4, 8, 14, 8, 28, 3, 32, 0, 2, 3, 2, 2, 0, 0, 0, 0, 0, 0, 0, 19, 2, 23, 21, 0, 37, 26, 101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36, 4, 4, 2, 2, 4, 2, 2, 3, 14, 12, 18, 16, 8, 27, 25, 18, 18, 24, 24, 0, 0, 0, 26, 16, 36, 5, 6, 56, 26, 21, 18, 0, 0, 18, 20, 20, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 42, 8, 4, 12, 15, 13, 6, 15, 14, 0, 12, 3, 8, 28, 36, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 14, 14, 51, 5]');
% %     MAVLINK_MESSAGE_CRCS = uint8([72, 39, 190, 92, 191, 217, 104, 119, 0, 219, 60, 186, 10, 0, 0, 0, 0, 0, 0, 0, 89, 159, 162, 121, 0, 149, 222, 110, 179, 136, 66, 126, 185, 147, 112, 252, 162, 215, 229, 128, 9, 106, 101, 213, 4, 229, 21, 214, 215, 14, 206, 50, 157, 126, 108, 213, 95, 5, 127, 0, 0, 0, 57, 126, 130, 119, 193, 191, 236, 158, 143, 0, 0, 104, 123, 131, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 155, 0, 0, 0, 0, 0, 0, 0, 0, 0, 143, 29, 208, 188, 118, 242, 19, 97, 233, 0, 18, 68, 136, 205, 42, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 178, 224, 60, 106, 7]');
% %     N = length(data);
% %     b = uint8(0);
% %     ch = uint8(0);
% %     crc = uint16(65535);
% %     ooff = uint16(255);
% %     for i=1:N
% %         b = data(i);
% %         ch = bitxor(b,uint8(bitand(crc,ooff)));
% %         ch = uint8(bitxor(ch,bitshift(ch,4)));
% %         crc = uint16(bitxor(bitxor(bitxor(bitshift(crc,-8),bitshift(uint16(ch),8)),bitshift(uint16(ch),3)),bitshift(uint16(ch),-4)));
% %     end
% % return
    
    disp('Done!!!!')
return

%% Generate APM Code based on XML data
function genAPMCode(Mess,version)
    if (version)
        %dDir = 'G:\\ArduRepo\\libraries\\GCS_MAVLink\\include_v1.0\\common';
        dDir = 'GCS_MAVLink\\include_v1.0\\common';
    else
        %dDir = 'G:\\ArduRepo\\libraries\\GCS_MAVLink\\include\\common';
        dDir = 'GCS_MAVLink\\include\\common';
    end
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end
    %dDir = 'APM\\ap';
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end

    %% initialization
    %% Generate function header
    K = length(Mess);
    MAVLINK_MESSAGE_LENGTHS = zeros(1,256);
    MAVLINK_MESSAGE_INFO = cell(1,256);
    for i=1:256
        MAVLINK_MESSAGE_INFO{i} = '{NULL}';
    end
    
    for i=1:K   % For each MavLink message
        N = size(Mess(i).fields.name,1);
        ID = sscanf(Mess(i).id,'%d');
        packetSize = sum(cell2mat(Mess(i).fields.byte));
        
        %% Message Length Array
        MAVLINK_MESSAGE_LENGTHS(ID+1) = packetSize;
        MAVLINK_MESSAGE_INFO{ID+1} = sprintf('MAVLINK_MESSAGE_INFO_%s',Mess(i).name);
        
        %% Do MavLink to APM types substitution
        APM.name = Mess(i).fields.name;
        APM.type = Mess(i).fields.rawtype;
        APM.byte = Mess(i).fields.byte;
        APM.desc = Mess(i).fields.desc;
        APM.array = APM.byte;
        
        for j=1:N
            %% Cleanup some types e.g. arrays, etc
            udx = strfind(APM.type{j},'_');
            odx = strfind(APM.type{j},'[');
            if (~isempty(udx) && length(udx)>1)
                APM.type{j} = APM.type{j}(1:udx(2)-1);
            else
                if ~isempty(odx)
                    APM.type{j} = APM.type{j}(1:odx-1);
                end
            end
            switch(APM.type{j})
                case 'char'
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'int8_t'
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'int16_t'
                    if (APM.array{j}==2), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/2; end
                case 'int32_t'
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'int64_t'
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                case 'array'
                    switch (ID)
                        case 22
                            APM.type{j} = 'int8_t';
                        otherwise
                            APM.type{j} = 'uint8_t';
                    end
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'uint8'
                    APM.type{j} = 'uint8_t';
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'uint8_t'
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'uint16_t'
                    if (APM.array{j}==2), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/2; end
                case 'uint32_t'
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'uint64_t'
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                case 'float'
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'double'
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                otherwise
                    disp(sprintf(' ''%s'' type may not have APM equivalent',APM.type{j}))
            end
        end

%         %% Include file Array
%         fprintf(mif,sprintf('#include "./mavlink_msg_%s.h"\n',lower(Mess(i).name)));
% 
        %% Function Header
        newf = sprintf('%s\\mavlink_msg_%s.h',dDir,lower(Mess(i).name));
        fp = fopen(newf,'w');
        fprintf(fp,sprintf('// MESSAGE %s PACKING\n',Mess(i).name));
        fprintf(fp,sprintf('// Generated from parse_APM_XML.m on %s\n\n',datestr(clock)));
        
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s %d \n\n',Mess(i).name,ID));
        
        %% define structure for message
        fprintf(fp,sprintf('typedef struct __mavlink_%s_t \n',lower(Mess(i).name)));
        fprintf(fp,'{ \n');
        for j=1:N
            if (APM.array{j} > 0)
                fprintf(fp,'  %s %s[%d];  ///< %s\n',APM.type{j}, APM.name{j}, APM.array{j}, APM.desc{j});
            else
                fprintf(fp,'  %s %s;  ///< %s\n',APM.type{j}, APM.name{j}, APM.desc{j});
            end
        end
        fprintf(fp,sprintf('} mavlink_%s_t;\n\n',lower(Mess(i).name)));
        
        %% define Message Length
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s_LEN %d\n',Mess(i).name,packetSize));
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%d_LEN %d\n\n',ID,packetSize));
        
        %% define CRC Message Length
        if (version)
            crcSize = 0;    %% dummy CRC size, needs to be determined
            fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s_CRC %d\n',Mess(i).name,crcSize));
            fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%d_CRC %d\n\n',ID,crcSize));
        end
        
        %% define Message INFO structure
        fprintf(fp,sprintf('#define MAVLINK_MESSAGE_INFO_%s \\\\\n{ \\\\\n',Mess(i).name));
        fprintf(fp,sprintf('  "%s", \\\\\n',Mess(i).name));
        fprintf(fp,sprintf('  %d, \\\\\n',N));
        fprintf(fp,sprintf('  { \\\\\n'));
        voff = 0;
        for j=1:N
            if (version)
                fprintf(fp,sprintf('    { "%s", NULL, MAVLINK_TYPE_%s, %d, %d, offsetof(mavlink_%s_t, %s) }, \\\\\n', APM.name{j}, upper(APM.type{j}), APM.array{j}, voff, lower(Mess(i).name), APM.name{j}));
            else
                fprintf(fp,sprintf('    { "%s", NULL, MAVLINK_TYPE_%s, %d, %d, offsetof(mavlink_%s_t, %s) }, \\\\\n', APM.name{j}, upper(APM.type{j}), APM.array{j}, voff, lower(Mess(i).name), APM.name{j}));
            end
            voff = voff + APM.byte{j};
        end
        fprintf(fp,sprintf('  } \\\\\n'));
        fprintf(fp,sprintf('}\n\n'));
        
        %% Function Header - mavlink_msg_xxx_pack
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Pack a %s message\n',lower(Mess(i).name)));
        fprintf(fp,' * @param system_id ID of this system\n');
        fprintf(fp,' * @param component_id ID of this component (e.g. 200 for IMU)\n');
        fprintf(fp,' * @param msg The MAVLink message to compress the data into\n');
        fprintf(fp,' *\n');
        for j=1:N
            fprintf(fp,sprintf(' * @param %s %s\n', APM.name{j}, APM.desc{j}));
        end
        fprintf(fp,' * @return length of the message in bytes (excluding serial stream start sign)\n');
        fprintf(fp,' */\n');
        %% Function Declaration
        fprintf(fp,sprintf('static inline uint16_t mavlink_msg_%s_pack(\n',lower(Mess(i).name)));
        fprintf(fp,'\t uint8_t system_id\n\t,uint8_t component_id\n\t,mavlink_message_t* msg\n');
        for j=1:N
            %if ((ID~=0) || ((ID==0)&&(j<N))) %% Heartbeat Message special processing
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t,const %s* %s\n', APM.type{j}, APM.name{j}));
                else
                    fprintf(fp,sprintf('\t,%s %s\n', APM.type{j}, APM.name{j}));
                end
            %end
        end
        fprintf(fp,'\t)\n{\n');
        %% Function Body
        fprintf(fp,'#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS\n');
        fprintf(fp,sprintf('\tchar buf[MAVLINK_MSG_ID_%s_LEN];\n',Mess(i).name));
        voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j},voff,APM.name{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j},voff,APM.name{j}));
                end
            %end
            voff = voff + APM.byte{j};
        end

        if (version)
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        else
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        end
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\tmavlink_%s_t packet;\n',lower(Mess(i).name)));
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\tpacket.%s = 2;\n',APM.name{j}));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\tmav_array_memcpy(packet.%s, %s, sizeof(%s)*%d);\n',APM.name{j},APM.name{j},APM.type{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\tpacket.%s = %s;\n',APM.name{j},APM.name{j}));
                end
            %end
        end

        if (version)
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        else
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        end
        fprintf(fp,'#endif\n');

        fprintf(fp,sprintf('\n\tmsg->msgid = MAVLINK_MSG_ID_%s;\n',Mess(i).name));
        fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
        fprintf(fp,sprintf('\treturn mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name));
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\treturn mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n\n');
        
        %% Function Header - mavlink_msg_xxx_pack_chan
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Pack a %s message on a channel\n',lower(Mess(i).name)));
        fprintf(fp,' * @param system_id ID of this system\n');
        fprintf(fp,' * @param component_id ID of this component (e.g. 200 for IMU)\n');
        fprintf(fp,' * @param chan The MAVLink channel this message was sent over\n');
        fprintf(fp,' * @param msg The MAVLink message to compress the data into\n');
        fprintf(fp,' *\n');
        for j=1:N
            fprintf(fp,sprintf(' * @param %s %s\n', APM.name{j}, APM.desc{j}));
        end
        fprintf(fp,' * @return length of the message in bytes (excluding serial stream start sign)\n');
        fprintf(fp,' */\n');
        %% Function Declaration
        fprintf(fp,sprintf('static inline uint16_t mavlink_msg_%s_pack_chan(\n',lower(Mess(i).name)));
        fprintf(fp,'\t uint8_t system_id\n\t,uint8_t component_id\n\t,uint8_t chan\n\t,mavlink_message_t* msg\n');
        for j=1:N
            %if ((ID~=0) || ((ID==0)&&(j<N))) %% Heartbeat Message special processing
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t,const %s* %s\n', APM.type{j}, APM.name{j}));
                else
                    fprintf(fp,sprintf('\t,%s %s\n', APM.type{j}, APM.name{j}));
                end
            %end
        end
        fprintf(fp,'\t)\n{\n');
        %% Function Body
        fprintf(fp,'#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS\n');
        fprintf(fp,sprintf('\tchar buf[MAVLINK_MSG_ID_%s_LEN];\n',Mess(i).name));
        voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j},voff,APM.name{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j},voff,APM.name{j}));
                end
            %end
            voff = voff + APM.byte{j};
        end

        if (version)
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        else
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        end
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\tmavlink_%s_t packet;\n',lower(Mess(i).name)));
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\tpacket.%s = 2;\n',APM.name{j}));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\tmav_array_memcpy(packet.%s, %s, sizeof(%s)*%d);\n',APM.name{j},APM.name{j},APM.type{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\tpacket.%s = %s;\n',APM.name{j},APM.name{j}));
                end
            %end
        end

        if (version)
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        else
            fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        end
        fprintf(fp,'#endif\n');

        fprintf(fp,sprintf('\n\tmsg->msgid = MAVLINK_MSG_ID_%s;\n',Mess(i).name));
        fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
        fprintf(fp,sprintf('\treturn mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name));
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\treturn mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n\n');
        
        %% Function Header - mavlink_msg_xxx_encode
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Encode a %s struct into a message\n',lower(Mess(i).name)));
        fprintf(fp,' *\n');
        fprintf(fp,' * @param system_id ID of this system\n');
        fprintf(fp,' * @param component_id ID of this component (e.g. 200 for IMU)\n');
        fprintf(fp,' * @param msg The MAVLink message to compress the data into\n');
        fprintf(fp,' * @param vfr_hud C-struct to read the message contents from\n');
        fprintf(fp,' */\n');
        %% Function Declaration
        fprintf(fp,sprintf('static inline uint16_t mavlink_msg_%s_encode(\n',lower(Mess(i).name)));
        fprintf(fp,'\t uint8_t system_id\n\t,uint8_t component_id\n\t,mavlink_message_t* msg\n');
        fprintf(fp,sprintf('\t,const mavlink_%s_t* %s\n',lower(Mess(i).name),lower(Mess(i).name)));
        fprintf(fp,'\t)\n{\n');
        %% Function Body
        fprintf(fp,sprintf('\treturn mavlink_msg_%s_pack(\n',lower(Mess(i).name)));
        fprintf(fp,'\t system_id\n\t,component_id\n\t,msg\n');
        for j=1:N
            %if ((ID~=0) || ((ID==0)&&(j<N))) %% Heartbeat Message special processing
                fprintf(fp,sprintf('\t,%s->%s\n',lower(Mess(i).name),APM.name{j}));
            %end
        end
        fprintf(fp,'\t);\n}\n\n');

        %% Function Header - mavlink_msg_xxx_encode_chan
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Encode a %s struct on a channel\n',lower(Mess(i).name)));
        fprintf(fp,' *\n');
        fprintf(fp,' * @param system_id ID of this system\n');
        fprintf(fp,' * @param component_id ID of this component (e.g. 200 for IMU)\n');
        fprintf(fp,' * @param chan The MAVLink channel this message will be sent over\n');
        fprintf(fp,' * @param msg The MAVLink message to compress the data into\n');
        fprintf(fp,' * @param %s C-struct to read the message contents from\n',lower(Mess(i).name));
        fprintf(fp,' */\n');
        %% Function Declaration
        fprintf(fp,sprintf('static inline uint16_t mavlink_msg_%s_encode_chan(\n',lower(Mess(i).name)));
        fprintf(fp,'\t uint8_t system_id\n\t,uint8_t component_id\n\t,uint8_t chan\n\t,mavlink_message_t* msg\n');
        fprintf(fp,sprintf('\t,const mavlink_%s_t* %s\n',lower(Mess(i).name),lower(Mess(i).name)));
        fprintf(fp,'\t)\n{\n');
        %% Function Body
        fprintf(fp,sprintf('\treturn mavlink_msg_%s_pack_chan(\n',lower(Mess(i).name)));
        fprintf(fp,'\t system_id\n\t,component_id\n\t,chan\n\t,msg\n');
        for j=1:N
            %if ((ID~=0) || ((ID==0)&&(j<N))) %% Heartbeat Message special processing
                fprintf(fp,sprintf('\t,%s->%s\n',lower(Mess(i).name),APM.name{j}));
            %end
        end
        fprintf(fp,'\t);\n}\n\n');
        
        %% Function Header - mavlink_msg_xxx_send
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Send a %s message\n',lower(Mess(i).name)));
        fprintf(fp,' * @param chan The MAVLink channel to send this message\n');
        fprintf(fp,' *\n');
        for j=1:N
            fprintf(fp,sprintf(' * @param %s %s\n', APM.name{j}, APM.desc{j}));
        end
        fprintf(fp,' */\n');
        %% Function Declaration
        fprintf(fp,'#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS\n\n');
        fprintf(fp,sprintf('static inline void mavlink_msg_%s_send(\n',lower(Mess(i).name)));
        fprintf(fp,'\t mavlink_channel_t chan\n');
        for j=1:N
            %if ((ID~=0) || ((ID==0)&&(j<N))) %% Heartbeat Message special processing
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t,const %s* %s\n', APM.type{j}, APM.name{j}));
                else
                    fprintf(fp,sprintf('\t,%s %s\n', APM.type{j}, APM.name{j}));
                end
            %end
        end
        fprintf(fp,'\t)\n{\n');
        %% Function Body
        fprintf(fp,'#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS\n');
        fprintf(fp,sprintf('\tchar buf[MAVLINK_MSG_ID_%s_LEN];\n',Mess(i).name));
        voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j},voff,APM.name{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j},voff,APM.name{j}));
                end
            %end
            voff = voff + APM.byte{j};
        end

        fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
        fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
        fprintf(fp,'#endif\n');
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\tmavlink_%s_t packet;\n',lower(Mess(i).name)));
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\tpacket.%s = 2;\n',APM.name{j}));
            %else
                if (APM.array{j} > 0)
                    fprintf(fp,sprintf('\tmav_array_memcpy(packet.%s, %s, sizeof(%s)*%d);\n',APM.name{j},APM.name{j},APM.type{j},APM.array{j}));
                else
                    fprintf(fp,sprintf('\tpacket.%s = %s;\n',APM.name{j},APM.name{j}));
                end
            %end
        end

        fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
        fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
        fprintf(fp,'#endif\n');
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n\n');
        fprintf(fp,'#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS\n\n');
        
        %% Function Header - MESSAGE xxx UNPACKING
        fprintf(fp,sprintf('// MESSAGE %s UNPACKING\n\n',Mess(i).name));
        voff = 0;
        for j=1:N
            fprintf(fp,'/**\n');
            fprintf(fp,sprintf(' * @brief Get field %s from %s message\n',APM.name{j},lower(Mess(i).name)));
            fprintf(fp,' *\n');
            fprintf(fp,sprintf(' * @return %s\n',APM.desc{j}));
            fprintf(fp,' */\n');
            if (APM.array{j} > 0)
                fprintf(fp,sprintf('static inline %s mavlink_msg_%s_get_%s(const mavlink_message_t* msg, %s* %s)\n',APM.type{j},lower(Mess(i).name),APM.name{j},APM.type{j},APM.name{j}));
                fprintf(fp,'{\n');
                fprintf(fp,sprintf('	return _MAV_RETURN_%s_array(msg,%s,%d,%d);\n',APM.type{j},APM.name{j},APM.array{j},voff));
                fprintf(fp,'}\n\n');
            else
                fprintf(fp,sprintf('static inline %s mavlink_msg_%s_get_%s(const mavlink_message_t* msg)\n',APM.type{j},lower(Mess(i).name),APM.name{j}));
                fprintf(fp,'{\n');
                fprintf(fp,sprintf('	return _MAV_RETURN_%s(msg,%d);\n',APM.type{j},voff));
                fprintf(fp,'}\n\n');
            end
            voff = voff + APM.byte{j};
        end

        %% Function Header - mavlink_msg_xxx_decode
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Decode a %s message into a struct\n',lower(Mess(i).name)));
        fprintf(fp,' *\n');
        fprintf(fp,' * @param msg The message to decode\n');
        fprintf(fp,sprintf(' * @param %s C-struct to decode the message contents into\n',lower(Mess(i).name)));
        fprintf(fp,' */\n');
        fprintf(fp,sprintf('static inline void mavlink_msg_%s_decode(const mavlink_message_t* msg, mavlink_%s_t* %s)\n',lower(Mess(i).name),lower(Mess(i).name),lower(Mess(i).name)));
        fprintf(fp,'{\n');
        fprintf(fp,'#if MAVLINK_NEED_BYTE_SWAP\n');
        for j=1:N
            if (APM.array{j} > 0)
                fprintf(fp,sprintf('	mavlink_msg_%s_get_%s(msg, %s->%s);\n',lower(Mess(i).name),APM.name{j},lower(Mess(i).name),APM.name{j}));
            else
                fprintf(fp,sprintf('	%s->%s = mavlink_msg_%s_get_%s(msg);\n',lower(Mess(i).name),APM.name{j},lower(Mess(i).name),APM.name{j}));
            end
        end
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('	memcpy(%s, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_%s_LEN);\n',lower(Mess(i).name),Mess(i).name));
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n');

        %% Function End
        %%        
        fclose(fp); fp = [];
    end   % For each MavLink message
       
    %% End Messages
    
    %% Create supporting files
    newf = sprintf('%s\\common_MsgLength.h',dDir);
    mif = fopen(newf,'w');
    fprintf(mif,'/*\n');
    fprintf(mif,'                                {');
    for i=1:256
        if (i==1)
            fprintf(mif,sprintf('%3d',i-1));
        else
            fprintf(mif,sprintf(',%3d',i-1));
        end
    end
    fprintf(mif,'}\n');
	fprintf(mif,'#define MAVLINK_MESSAGE_LENGTHS {  3,  4,  8, 14,  8, 28,  3, 32,  0,  2,  3,  2,  2,  0,  0,  0,  0,  0,  0,  0, 19,  2, 23, 21,  0, 37, 26,101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36,  4,  4,  2,  2,  4,  2,  2,  3, 14, 12, 18, 16,  8, 27, 25, 18, 18, 24, 24,  0,  0,  0, 26, 16, 36,  5,  6, 56, 26, 21, 18,  0,  0, 18, 20, 20,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 18,  0,  0,  0,  0,  0,  0,  0,  0,  0, 40, 72,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 30, 14, 14, 51,  5}\n');
	fprintf(mif,'*/\n');
    fprintf(mif,'#define MAVLINK_MESSAGE_LENGTHS {');
    for i=1:256
        if (i==1)
            fprintf(mif,sprintf('%3d',MAVLINK_MESSAGE_LENGTHS(i)));
        else
            fprintf(mif,sprintf(',%3d',MAVLINK_MESSAGE_LENGTHS(i)));
        end
    end
    fprintf(mif,'}\n');
    
    fprintf(mif,'#define MAVLINK_MESSAGE_INFO {');
    for i=1:256
        if (i==1)
            fprintf(mif,sprintf('%s',MAVLINK_MESSAGE_INFO{i}));
        else
            fprintf(mif,sprintf(',%s',MAVLINK_MESSAGE_INFO{i}));
        end
    end
    fprintf(mif,'}\n');
    fclose(mif); mif = [];
    
    %% Include file Array
    %% File to contain list mavlink message include files
%     Mess = [parseXML('slvMessage.xml'); parseXML('common_APM_2.27.xml')];
    N = length(Mess);
    newf = sprintf('%s\\common_include.h',dDir);
    mif = fopen(newf,'w');
    for i=1:N
        fprintf(mif,sprintf('#include "./mavlink_msg_%s.h"\n',lower(Mess(i).name)));
    end
    fclose(mif); mif = [];
    
    
    disp('Done!!!!')
return

%% Generate GroundStation Code based on XML data
function genGSCode(Mess,version)
    %dDir = 'G:\\ArduRepo\\ArdupilotMegaPlanner';
    dDir = 'ArdupilotMegaPlanner';
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end
    if (version)
        newf = sprintf('%s\\MAVLinkTypes1.0_patch.cs',dDir);
    else
        newf = sprintf('%s\\MAVLinkTypes0.9_patch.cs',dDir);
    end
    fp = fopen(newf,'w');

    %% Generate Message Length Array
    K = length(Mess);
    MAVLINK_MESSAGE_LENGTHS = zeros(1,256);
    MAVLINK_MESSAGE_CRC = zeros(1,256);
    MAVLINK_MESSAGE_INFO = cell(1,256);
    for i=1:256
        MAVLINK_MESSAGE_INFO{i} = sprintf('\t\t\tnull,\t\t\t //message %d\n',i-1);
    end
    
    for i=1:K
        ID = sscanf(Mess(i).id,'%d');
        packetSize = sum(cell2mat(Mess(i).fields.byte));
        MAVLINK_MESSAGE_LENGTHS(ID+1) = packetSize;
    end
    fprintf(fp,'    //                                                 {');
    for i=1:256
        if (i==1)
            fprintf(fp,sprintf('%3d',i-1));
        else
            fprintf(fp,sprintf(',%3d',i-1));
        end
    end
    fprintf(fp,'}\n');
    if (version)
        fprintf(fp,'    public static readonly byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {');
    else
        fprintf(fp,'    public byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {');
    end
    for i=1:256
        if (i==1)
            fprintf(fp,sprintf('%3d',MAVLINK_MESSAGE_LENGTHS(i)));
        else
            fprintf(fp,sprintf(',%3d',MAVLINK_MESSAGE_LENGTHS(i)));
        end
    end
    fprintf(fp,'};\n');
    
    %%
    for i=1:K   % For each MavLink message
        N = size(Mess(i).fields.name,1);
        ID = sscanf(Mess(i).id,'%d');
        packetSize = sum(cell2mat(Mess(i).fields.byte));
        
        %% Message Length Array
        MAVLINK_MESSAGE_LENGTHS(ID+1) = packetSize;
        if (version)
            MAVLINK_MESSAGE_INFO{ID+1} = sprintf('\t\t\ttypeof( mavlink_%s_t),\t\t\t// message %d\n',lower(Mess(i).name),ID);
        else
            MAVLINK_MESSAGE_INFO{ID+1} = sprintf('\t\t\ttypeof( __mavlink_%s_t),\t\t\t// message %d\n',lower(Mess(i).name),ID);
        end
        
        %% Do MavLink to APM types substitution
        APM.name = Mess(i).fields.name;
        APM.type = Mess(i).fields.type;
        APM.byte = Mess(i).fields.byte;
        APM.desc = Mess(i).fields.desc;
        APM.array = APM.byte;
        
        for j=1:N
%             %% Cleanup some types e.g. arrays, etc
%             udx = strfind(APM.type{j},'_');
%             odx = strfind(APM.type{j},'[');
%             if (~isempty(udx) && length(udx)>1)
%                 APM.type{j} = APM.type{j}(1:udx(2)-1);
%             else
%                 if ~isempty(odx)
%                     APM.type{j} = APM.type{j}(1:odx-1);
%                 end
%             end
            switch(APM.type{j})
                case 'char'
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'int8'
                     APM.type{j} = 'byte';
                   if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'int16'
                    APM.type{j} = 'short';
                    if (APM.array{j}==2), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/2; end
                case 'int32'
                    APM.type{j} = 'int';
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'int64_t'
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                case 'array'
                    switch (ID)
                        case 22
                            APM.type{j} = 'byte';
                        otherwise
                            APM.type{j} = 'byte';
                    end
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'uint8'
                    APM.type{j} = 'byte';
                    if (APM.array{j}==1), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/1; end
                case 'uint16'
                    APM.type{j} = 'ushort';
                    if (APM.array{j}==2), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/2; end
                case 'uint32'
                    APM.type{j} = 'uint';
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'uint64'
                    APM.type{j} = 'ulong';
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                case 'single'
                    APM.type{j} = 'float';
                    if (APM.array{j}==4), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/4; end
                case 'double'
                    if (APM.array{j}==8), APM.array{j} = 0; else APM.array{j} = APM.byte{j}/8; end
                otherwise
                    disp(sprintf(' ''%s'' type may not have APM equivalent',APM.type{j}))
            end
        end

        %% Function Header
        if (version)
            fprintf(fp,sprintf('\t[StructLayout(LayoutKind.Sequential,Pack=1, Size=%d)]\n',packetSize));
            fprintf(fp,sprintf('\tpublic struct mavlink_%s_t\n',lower(Mess(i).name)));
            fprintf(fp,sprintf('\t{\n'));
            for j=1:N
                if (APM.array{j} > 0)
                    fprintf(fp,'\t\t[MarshalAs(\n\t\t\tUnmanagedType.ByValArray,\n\t\t\tSizeConst=%d)]\n',APM.array{j});
                    fprintf(fp,'\t\tpublic %s[] %s; /// %s\n',APM.type{j}, APM.name{j}, APM.desc{j});
                else
                    fprintf(fp,'\t\tpublic %s %s; /// %s\n',APM.type{j}, APM.name{j}, APM.desc{j});
                end
            end
            fprintf(fp,sprintf('\t};\n\n'));
        else
            fprintf(fp,sprintf('\tpublic const byte MAVLINK_MSG_ID_%s = %d;\n',Mess(i).name,ID));
            fprintf(fp,sprintf('\tpublic const byte MAVLINK_MSG_ID_%s_LEN = %d;\n',Mess(i).name,packetSize));
            fprintf(fp,sprintf('\t[StructLayout(LayoutKind.Sequential,Pack=1)]\n'));
            fprintf(fp,sprintf('\tpublic struct __mavlink_%s_t\n',lower(Mess(i).name)));
            fprintf(fp,sprintf('\t{\n'));
            for j=1:N
                if (APM.array{j} > 0)
                    fprintf(fp,'\t\t[MarshalAs(\n\t\t\tUnmanagedType.ByValArray,\n\t\t\tSizeConst=%d)]\n',APM.array{j});
                    fprintf(fp,'\t\tpublic %s[] %s; /// %s\n',APM.type{j}, APM.name{j}, APM.desc{j});
                else
                    fprintf(fp,'\t\tpublic %s %s; /// %s\n',APM.type{j}, APM.name{j}, APM.desc{j});
                end
            end
            fprintf(fp,sprintf('\t};\n\n'));
        end
    end

    if (version)
        fprintf(fp,'\tpublic static readonly Type[] MAVLINK_MESSAGE_INFO = new Type[] {\n');
    else
        fprintf(fp,'\tType[] mavstructs = new Type[] {\n');
    end
    for i=1:256
        fprintf(fp,MAVLINK_MESSAGE_INFO{i});
    end
    fprintf(fp,'\t};\n');

    fclose(fp); fp = [];
    
    
    disp('Done!!!!')
return

%%
function Mess = parseXML(file)
    xDoc = xmlread(file);
    allEnums = xDoc.getElementsByTagName('enum');
    allMessages = xDoc.getElementsByTagName('message');
    K = allMessages.getLength;
    for k = 0:K-1       % Note that the item list index is zero-based.
        dMess = allMessages.item(k);
        dAtt = dMess.getAttributes;
        attrib = dAtt.item(1);
        Mess(k+1).name = char(attrib.getValue);
        attrib = dAtt.item(0);
        Mess(k+1).id   = char(attrib.getValue);
        dList = dMess.getElementsByTagName('description');
        if (dList.getLength > 0)
            Mess(k+1).fdesc = cleanupDesc(char(dList.item(0).getFirstChild.getData),0);
            Mess(k+1).cdesc = cleanupDesc(char(dList.item(0).getFirstChild.getData),1);
        else
            Mess(k+1).fdesc = '% No Description provided\n';
            Mess(k+1).cdesc = '% No Description provided\n';
        end

        fList = allMessages.item(k).getElementsByTagName('field');
        N = fList.getLength;
        allocCell = cell(N, 1);
        Mess(k+1).fields.name = allocCell;
        Mess(k+1).fields.type = allocCell;
        Mess(k+1).fields.desc = allocCell;
        Mess(k+1).fields.byte = allocCell;

        for n=0:N-1
            dField = fList.item(n);
            dAtt = dField.getAttributes;
            s = 0;
            while (~isempty(dAtt.item(s)))
                attrib = dAtt.item(s);
                Mess(k+1).fields.(char(attrib.getName)){n+1} = char(attrib.getValue);
                s = s+1;
            end
            Mess(k+1).fields.desc{n+1} = cleanupField(char(dField.getFirstChild.getData));
        end
        Mess(k+1).fields.rawtype = Mess(k+1).fields.type;
        for n=0:N-1
            [Mess(k+1).fields.type{n+1} Mess(k+1).fields.byte{n+1}] = parseType(Mess(k+1).fields.type{n+1});
        end
        Mess(k+1).sfields = MavLinkSort(Mess(k+1).fields);
    end   
    Mess = Mess(:);
return

%%
function sMess = MavLinkSort(Mess)
    [~, idx] = sort(cell2mat(Mess.byte),'descend');
    sMess.name = Mess.name(idx);
    sMess.type = Mess.type(idx);
    sMess.desc = Mess.desc(idx);
    sMess.byte = Mess.byte(idx);
    sMess.rawtype = Mess.rawtype(idx);
return

%%
function str = cleanupDesc(dstr,indentFlag)
    if (indentFlag), indent = '\t\t\t'; c=' '; else indent = ''; c='~ '; end
 
    tf = isstrprop(dstr, 'cntrl');
    dstr(tf) = ' ';
    idx = strfind(dstr,'%');
    if ~isempty(idx)
        N = length(idx);
        nstr = dstr;
        for i=1:N
            nstr = [nstr(1:idx(i)) '%' nstr(idx(i)+1:end)];
            idx = idx+1;
        end
        dstr = nstr;
    end
    idx = find(isstrprop(dstr, 'wspace'));
    ldx = find(diff(mod(idx,80))<0)+1;
    list = reshape(sort([1 idx(ldx) idx(ldx)+1 length(dstr)]),2,[])';
    N = size(list,1);
    nstr = ['%%' c dstr(list(1,1):list(1,2)) '\n'];
    for i=2:N
        nstr = [nstr indent '%%%%' c dstr(list(i,1):list(i,2)) '\n'];
    end
    str = [indent '%%' nstr];
return

%%
function str = cleanupField(dstr)
    tf = isstrprop(dstr, 'cntrl');
    dstr(tf) = ' ';
    idx = strfind(dstr,'%');
    if ~isempty(idx)
        N = length(idx);
        nstr = dstr;
        for i=1:N
            nstr = [nstr(1:idx(i)) '%' nstr(idx(i)+1:end)];
            idx = idx+1;
        end
        dstr = nstr;
    end
    str = dstr;
return

%%
function fields = parseType(fields)
    if (isempty(fields.type))
        fields.type = 'NONE';
        fields.byte = 0;
        return
    end

    mult = 1;
    fields.byte = 1;
    udx = strfind(fields.type{n},'_');
    odx = strfind(fields.type{n},'[');
    cdx = strfind(fields.type{n},']');
    if ~isempty(udx)
        ttype = fields.type{n}(1:udx(1)-1);
    else
        if ~isempty(odx)
            ttype = fields.type{n}(1:odx-1);
        else
            ttype = fields.type{n};
        end
    end
    if (~isempty(odx) && ~isempty(cdx))
        mult = sscanf(fields.type{n}(odx+1:cdx-1),'%d');
    end
    
    if (isempty(ttype))
        fields.type = fields.type{n};
    end
    
    switch(ttype)
        case 'char'
            fields.type = 'uint8'; %ttype;
            fields.byte = mult;
        case 'int8'
            fields.type = ttype;
            fields.byte = mult;
        case 'uint8'
            fields.type = ttype;
            fields.byte = mult;
        case 'int16'
            fields.type = ttype;
            fields.byte = 2*mult;
        case 'uint16'
            fields.type = ttype;
            fields.byte = 2*mult;
        case 'int32'
            fields.type = ttype;
            fields.byte = 4*mult;
        case 'uint32'
            fields.type = ttype;
            fields.byte = 4*mult;
        case 'int64'
            fields.type = ttype;
            fields.byte = 8*mult;
        case 'uint64'
            fields.type = ttype;
            fields.byte = 8*mult;
        case 'array'
            fields.type = 'uint8';
            fields.byte = mult;
        case 'float'
            fields.type = 'single';
            fields.byte = 4*mult;
        otherwise
            disp(sprintf('Variable type: %s',ttype))
%             type = ttype;
%             byte = mult;
    end
    
return

