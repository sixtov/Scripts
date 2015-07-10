%% XML File Parse
function parse_APM_XML()
    global SWAP;
    SWAP = 0;       % SWAP=0; don't swap mavlink message parameters
                    % SWAP=1; swap mavlink message parameters as
                    %         recommended by the MavLink protocol.
                    %         where the fields in a message are sorted
                    %         in descending order according to the size
                    %         (in bytes) of their type. e.g. uint32's will
                    %         be sorted before int16's or int8's. fields of
                    %         the same size will maintain their order.
                    
    global LOCAL;
    LOCAL = 1;      % LOCAL=1; Java code doesn't include the StratWay import libraries
                    % LOCAL=0; Java code does include the StratWay import libraries
                    
    global VERSION;
    VERSION = 0.9;  % VERSION=0.9; Use MavLink verion 0.9
                    % VERSION=1.0; Use MavLink versio 1.0
                    
    Mess = [parseXML('slvMessage.xml'); parseXML('common_APM_2.27.xml'); parseXML('ardupilotmega_APM_2.27.xml')];
    if (~isempty(Mess))
        % Generates MavLink 0.9 code
        VERSION = 0.9;
        genScript(Mess);   
        genJavaCode(Mess);   
        genAPMCode(Mess);   
        genGSCode(Mess);
        disp(' ');
    end
    
    %Mess = [parseXML('slvMessage.xml'); parseXML('common_MAVLINK_1.0.xml'); parseXML('ardupilotmega_MAVLINK_1.0.xml')];
    Mess = [parseXML('MavLink1.0_common.xml'); parseXML('MavLink1.0_ardupilotmega.xml')];
    if (~isempty(Mess))
        % Generates MavLink 1.0 code
        VERSION = 1.0;
        genScript(Mess);   
        genJavaCode(Mess);   
        genAPMCode(Mess);   
        genGSCode(Mess);   
        disp(' ');
    end

return

%% Generate MATLab Script based on XML data
function genScript(Mess)
    global SWAP;
    global VERSION;
    if (SWAP)
        disp('Offset SWAPPING')
    end
    switch (VERSION)
        case 0.9
            %fp = fopen('parseMavLinkPacket_APM_2_23.m','w');
            fp = fopen('parseMavLink_0_9_Packet.m','w');
            fprintf(fp,'function S = parseMavLink_0_9_Packet(S,p)\n');
        case 1.0
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
%             fprintf(fp,sprintf('\t\t%d ...\n',Mess(i).fields.matByte{j}));
%         end
%         fprintf(fp,'\t\t];\n');
% 
%         %% type member
%         fprintf(fp,'\ttype = [ ...\n');
%         for j=1:N
%             fprintf(fp,sprintf('\t\t{''%s''} ...\n',Mess(i).fields.matType{j}));
%         end
%         fprintf(fp,'\t\t];\n');

        %% byte member
        fprintf(fp,'\tbyte = [ ');
        for j=1:N
            fprintf(fp,sprintf('%d ',Mess(i).fields.matByte{j}));
        end
        fprintf(fp,'];\n');

        %% type member
        fprintf(fp,'\ttype = [ ');
        for j=1:N
            fprintf(fp,sprintf('{''%s''} ',Mess(i).fields.matType{j}));
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
    
    switch (VERSION)
        case 0.9
            fp = fopen('initMavLink_0_9.m','w');
            fprintf(fp,'function MavLink = initMavLink_0_9()\n');
        case 1.0
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
    switch (VERSION)
        case 0.9
            disp('Done MatLab script for MavLink 0.9')
        case 1.0
            disp('Done MatLab script for MavLink 1.0')
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
return

%% Generate Java Code based on XML data
function genJavaCode(Mess)
    global SWAP;
    global VERSION;
    global LOCAL;
    if (SWAP)
        disp('Offset SWAPPING')
    end
    switch (VERSION)
        case 0.9
            dDir = 'Java\\Mav09';
        case 1.0
            dDir = 'Java\\Mav10';
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end

    %%% initialization
    %specialHandlingIDs = [25 32 73 111];
    
    %%% Generate function header
    K = length(Mess);
    msgWithSystem = [];
    msgWithComponent = [];
    for i=1:K   %%% For each MavLink message
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
%%%         packetSize = sum(cell2mat(Mess(i).fields.matByte));
        
%%%        specialFunction = ~isempty(intersect(ID,specialHandlingIDs));

        %%% Do MavLink to java types substitution
        JAVA.name = Mess(i).fields.name;
        JAVA.type = Mess(i).fields.javaType;
        JAVA.byte = Mess(i).fields.javaByte;
        JAVA.array = Mess(i).fields.Array;
        
        %%% Max name and type lengths
        ml = 0;
        tl = 0;
        needBB = 0;
        for j=1:N
            ml = max([ml length(JAVA.name{j})]);
            tl = max([tl length(JAVA.type{j})]);
            needBB = needBB || (JAVA.byte{j}>Mess(i).fields.byte{j});
        end
        ml = 4*ceil(ml/4);
        tl = 4*ceil(tl/4);
        tpad = JAVA.type;   %preallocates memory for tpad cell array
        mpad = JAVA.type;   %same as above
        for j=1:N
            tpad{j} = char(9*ones(1,ceil((tl-length(JAVA.type{j}))/4)));
            mpad{j} = char(9*ones(1,ceil((ml-length(Mess(i).fields.name{j}))/4)));
        end
    
%%% Function Header
        newf = sprintf('%s\\%s_class.java',dDir,Mess(i).name);
        fp = fopen(newf,'w');
        switch (VERSION)
            case 0.9
                fprintf(fp,'//MavLink 0.9\n\n');
            case 1.0
                fprintf(fp,'//MavLink 1.0\n\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        if (LOCAL)
            fprintf(fp,'//package gov.nasa.larc.AP;\n');
            fprintf(fp,'//import gov.nasa.larc.serial.Loggable;\n');
        else
            fprintf(fp,'package gov.nasa.larc.AP;\n');
            fprintf(fp,'import gov.nasa.larc.serial.Loggable;\n');
        end
%     if (sum(cell2mat(JAVA.byte)) ~= ...
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
        if (LOCAL)
            fprintf(fp,' //implements Loggable');
        else
            fprintf(fp,' implements Loggable');
        end
        fprintf(fp,'\n{\n');
        %%% Declare member variables
        %fprintf(fp,'\tHeader_class head;\n');
        fprintf(fp,'\tpublic static final int msgID = %d;\n',ID);
        for j=1:N
%             switch(JAVA.type{j})
%                 case 'byte[]'
%                     fprintf(fp,'\tpublic %s%s %s = new byte[%d];%s',JAVA.type{j}, tpad{j}, Mess(i).fields.name{j},JAVA.byte{j}, mpad{j});
%                 otherwise
%                     fprintf(fp,'\tpublic %s%s %s;%s '              ,JAVA.type{j}, tpad{j}, Mess(i).fields.name{j}, mpad{j});
%             end
            if (JAVA.array{j})
                fprintf(fp,'\tpublic %s[]%s %s = new %s[%d];%s',JAVA.type{j}, tpad{j}, Mess(i).fields.name{j},JAVA.type{j},JAVA.byte{j}, mpad{j});
            else
                fprintf(fp,'\tpublic %s%s %s;%s '              ,JAVA.type{j}, tpad{j}, Mess(i).fields.name{j}, mpad{j});
            end
            if ~isempty(Mess(i).fields.desc{j})
                fprintf(fp,'\t// ');
                fprintf(fp,Mess(i).fields.desc{j});
            end
            fprintf(fp,'\n');
        end
        fprintf(fp,'\n');
        fprintf(fp,'\tprivate packet rcvPacket;\n');
        fprintf(fp,'\tprivate packet sndPacket;\n\n');
        
%%% Constructor
        fprintf(fp,sprintf('\tpublic %s_class()\n\t{\n',Mess(i).name));
        fprintf(fp,'\t\trcvPacket = new packet(msgID);\n');
        fprintf(fp,'\t\tsndPacket = new packet(msgID);\n');
        if (intersect(i,msgWithSystem))
            fprintf(fp,'\t\ttarget_system = 1;\n');
        end
        if (intersect(i,msgWithComponent))
            fprintf(fp,'\t\ttarget_component = 1;\n');
        end
        fprintf(fp,'\t}\n\n');

%%% Copy Constructor
        fprintf(fp,sprintf('\tpublic %s_class(%s_class o)\n\t{\n',Mess(i).name,Mess(i).name));
        for j=1:N
            fprintf(fp,'\t\t%s = o.%s;\n',Mess(i).fields.name{j},Mess(i).fields.name{j});
        end
        fprintf(fp,'\t}\n\n');

%%% First Parse Function
        fprintf(fp,'\tpublic boolean parse(byte[] b)\n\t{\n');
        fprintf(fp,'\t\treturn parse(b, false);\n');
        fprintf(fp,'\t}\n\n');
%%% Second Parse Function
        fprintf(fp,'\tpublic boolean parse(byte[] b, boolean valid)\n\t{\n');
        fprintf(fp,'\t\trcvPacket.load(b);\n\n');
        %%% Begin parsing from array
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
        
        %%% define MavLink member lengths (in bytes)
        fprintf(fp,'\t\t\t// int[] mavLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',Mess(i).fields.byte{j});
            else
                fprintf(fp,'%d, ',Mess(i).fields.byte{j});
            end
        end
        fprintf(fp,'};\n');

        %%% define java variable lengths (in bytes)
        fprintf(fp,'\t\t\t// int[] javLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',JAVA.byte{j});
            else
                fprintf(fp,'%d, ',JAVA.byte{j});
            end
        end
        fprintf(fp,'};\n\n');

%         fprintf(fp,'\t\t\trcvPacket.pBuf.position(packet.DATA_OFFSET);     // Skip the packet header\n');
        for j=1:N
            mpad = char(9*ones(1,ceil((ml+1-length(Mess(i).fields.name{j}))/4)));
            vname = Mess(i).fields.name{j};
            
            if (JAVA.array{j})
                if ((JAVA.byte{j} == Mess(i).fields.byte{j}) || (JAVA.byte{j} == JAVA.array{j}*Mess(i).fields.byte{j}))
                    fprintf(fp,'\t\t\trcvPacket.getByte(%s, 0, %d);\n',vname,JAVA.byte{j});
                else
                    fprintf(fp,'//\tERROR\tParsing ''%s'' array of ''%s'' from ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j});
                    fprintf('//\tERROR\tParsing ''%s'' array of ''%s'' from ''%s'' in MESSAGE: ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j},Mess(i).name);
                end
            else
                if (JAVA.byte{j} == Mess(i).fields.byte{j})
                    switch(JAVA.type{j})
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
                            %fprintf(fp,'\t\t\trcvPacket.getByte(%s, 0, %d);\n',vname,JAVA.byte{j});
                            fprintf(fp,'//\tERROR\tParsing ''%s'' a ''%s'' from a ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j});
                            fprintf('//\tERROR\tParsing ''%s'' a ''%s'' from a ''%s'' in MESSAGE: ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j},Mess(i).name);
                    end
                else
                    switch(JAVA.type{j})
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
                            fprintf(fp,'//\tERROR\tParsing ''%s'' a ''%s'' from a ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j});
                            fprintf('//\tERROR\tParsing ''%s'' a ''%s'' from a ''%s'' in MESSAGE: ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j},Mess(i).name);
                    end
                end
            end
        end

        %%% Close function
        fprintf(fp,'\t\t}\n');
        fprintf(fp,'\t\treturn(pstatus);\n');
        fprintf(fp,'\t}\n\n');

%%% Now begins the FIRST encode section
        fprintf(fp,'\tpublic byte[] encode()\n\t{\n');
        fprintf(fp,'\t\treturn encode(\n');
        for j=1:N
            if (j==1)
                if (j==msgWithSystemIdx)
                    fprintf(fp,'\t\t\t\t\t  (%s)1\n',JAVA.type{j});
                elseif (j==msgWithComponentIdx)
                    fprintf(fp,'\t\t\t\t\t  (%s)1\n',JAVA.type{j});
                else
                    fprintf(fp,'\t\t\t\t\t  %s\n',Mess(i).fields.name{j});
                end
            else
                if (j==msgWithSystemIdx)
                    fprintf(fp,'\t\t\t\t\t ,(%s)1\n',JAVA.type{j});
                elseif (j==msgWithComponentIdx)
                    fprintf(fp,'\t\t\t\t\t ,(%s)1\n',JAVA.type{j});
                else
                    fprintf(fp,'\t\t\t\t\t ,%s\n',Mess(i).fields.name{j});
                end
            end
        end
        fprintf(fp,sprintf( '\t\t\t\t\t );\n'));
        fprintf(fp,'\t}\n\n');

%%% Now begins the optional SECOND encode section
        if (~isempty([msgWithSystemIdx msgWithComponentIdx]) && (N>length([msgWithSystemIdx msgWithComponentIdx])))
            fprintf(fp,'\tpublic byte[] encode(\n');
            first = 1;
            for j=1:N
                if (first)
                    if (~any(intersect(j,[msgWithSystemIdx msgWithComponentIdx])))
                        if (JAVA.array{j})
                            fprintf(fp,'\t\t\t\t\t\t %s[] v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                        else
                            fprintf(fp,'\t\t\t\t\t\t %s v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                        end
                        first = 0;
                    end
                else
                    if (~any(intersect(j,[msgWithSystemIdx msgWithComponentIdx])))
                        if (JAVA.array{j})
                            fprintf(fp,'\t\t\t\t\t\t,%s[] v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                        else
                            fprintf(fp,'\t\t\t\t\t\t,%s v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                        end
                    end
                end
            end
            fprintf(fp,sprintf( '\t\t\t\t\t\t)\n\t{\n'));

            fprintf(fp,'\t\treturn encode(\n');
            for j=1:N
                if (j==1)
                    if (j==msgWithSystemIdx)
                        fprintf(fp,'\t\t\t\t\t    (%s)1\n',JAVA.type{j});
                    elseif (j==msgWithComponentIdx)
                        fprintf(fp,'\t\t\t\t\t    (%s)1\n',JAVA.type{j});
                    else
                        fprintf(fp,'\t\t\t\t\t  v_%s\n',Mess(i).fields.name{j});
                    end
                else
                    if (j==msgWithSystemIdx)
                        fprintf(fp,'\t\t\t\t\t ,  (%s)1\n',JAVA.type{j});
                    elseif (j==msgWithComponentIdx)
                        fprintf(fp,'\t\t\t\t\t ,  (%s)1\n',JAVA.type{j});
                    else
                        fprintf(fp,'\t\t\t\t\t ,v_%s\n',Mess(i).fields.name{j});
                    end
                end
            end
            fprintf(fp,sprintf( '\t\t\t\t\t );\n'));
            fprintf(fp,'\t}\n\n');
        end

%%% Now begins the THIRD encode section
        fprintf(fp,'\tpublic byte[] encode(\n');
        for j=1:N
            if (j==1)
                if (JAVA.array{j})
                    ftext = sprintf('\t\t\t\t\t\t %s[] v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                else
                    ftext = sprintf('\t\t\t\t\t\t %s v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                end
            else
                if (JAVA.array{j})
                    ftext = sprintf('\t\t\t\t\t\t,%s[] v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                else
                    ftext = sprintf('\t\t\t\t\t\t,%s v_%s\n',JAVA.type{j},Mess(i).fields.name{j});
                end
            end
            fprintf(fp,'%s',ftext);
        end
        fprintf(fp,sprintf( '\t\t\t\t\t\t)\n\t{\n'));
        
        %%% Body of encode function
        %fprintf(fp,'\t\tpacket pkt = new packet(msgID);\n');
%         if(needBB)
%             fprintf(fp,'\t\tbyte[] temp = {0,0,0,0,0,0,0,0};\n');
%             fprintf(fp,'\t\tByteBuffer BB = ByteBuffer.wrap(temp);\n\n');
%         end
%         fprintf(fp,'\t\tbyte[] msg = new byte[%d];\t// includes header and checksum\n',packetSize+8);
%         fprintf(fp,'\t\tByteBuffer p = ByteBuffer.wrap(msg);\n\n');

        %%% define MavLink member lengths (in bytes)
        fprintf(fp,'\t\t// int[] mavLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',Mess(i).fields.byte{j});
            else
                fprintf(fp,'%d, ',Mess(i).fields.byte{j});
            end
        end
        fprintf(fp,'};\n');

        %%% define java variable lengths (in bytes)
        fprintf(fp,'\t\t// int[] javLen = {');
        for j=1:N
            if (j==N)
                fprintf(fp,'%d',JAVA.byte{j});
            else
                fprintf(fp,'%d, ',JAVA.byte{j});
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
            vname = Mess(i).fields.name{j};
            if (JAVA.array{j})
                if ((JAVA.byte{j} == Mess(i).fields.byte{j}) || (JAVA.byte{j} == JAVA.array{j}*Mess(i).fields.byte{j}))
                    fprintf(fp,'\t\tsndPacket.putByte(v_%s,0,%d);',JAVA.name{j},JAVA.byte{j});
                else
                    fprintf(fp,'//\tERROR\tEncoding ''%s'' array of ''%s'' from ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j});
                    fprintf('//\tERROR\tEncoding ''%s'' array of ''%s'' from ''%s'' in MESSAGE: ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j},Mess(i).name);
                end
            else
                if (JAVA.byte{j} == Mess(i).fields.byte{j})
                    switch(JAVA.type{j})
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
                            %fprintf(fp,'\t\tsndPacket.putByte(v_%s,0,%d);',Mess(i).fields.name{j},Mess(i).fields.byte{j});
                            fprintf(fp,'//\tERROR\tEncoding ''%s'' a ''%s'' from a ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j});
                            fprintf('//\tERROR\tEncoding ''%s'' a ''%s'' from a ''%s'' in MESSAGE: ''%s''\n',vname,JAVA.type{j},Mess(i).fields.type{j},Mess(i).name);
                    end
                else
                    switch(JAVA.type{j})
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
                            fprintf(fp,'//\tERROR\tEncoding ''%s'' a ''%s'' from a ''%s''\n',vname,Mess(i).fields.type{j},JAVA.type{j});
                            fprintf('//\tERROR\tEncoding ''%s'' a ''%s'' from a ''%s'' in MESSAGE: ''%s''\n',vname,Mess(i).fields.type{j},JAVA.type{j},Mess(i).name);
                    end
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

        
%%% Loggable
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
        
        
%%%        
        fprintf(fp,'}\n'); %% End of MavLink Class
        fclose(fp); fp = [];
    end   % For each MavLink message
    

%%% Generate the MavLink Class
    fp = fopen(sprintf('%s\\APData.java',dDir),'w');
    if (~LOCAL)
        fprintf(fp,'package gov.nasa.larc.AP;\n\n');
    end
    %fprintf(fp,'import java.nio.ByteBuffer;\n\n');
    fprintf(fp,'/**\n * @author svazquez\n *\n */\n');
    fprintf(fp,'public class APData\n{\n');

    %%% Max name and type lengths
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
    
%%%
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
    
%%% Init function
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
    
%%% List All Messages, All parameters
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
    
%%% 
    fprintf(fp,'}\n');
    fclose(fp);
    
%%% Header Object
    fp = fopen(sprintf('%s\\MavHeader.java',dDir),'w');
    if (~LOCAL)
        fprintf(fp,'package gov.nasa.larc.AP;\n\n');
    end
    %fprintf(fp,'import java.nio.ByteBuffer;\n\n');
    fprintf(fp,'public class MavHeader\n');
    fprintf(fp,'{\n');

    %%% Generate Message Length Array
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
    
    %%%
%     fprintf(fp,'\tstatic final short HEADER_SIZE = 6;\n');
%     fprintf(fp,'\tstatic final short CHKSUM_SIZE = 2;\n');
%     fprintf(fp,'\tstatic final byte  MAV_MARKER  = (byte) 85;\n');
%     fprintf(fp,'\tstatic final byte  BEAGLE_ID   = (byte)103;\n');
%     fprintf(fp,'\tstatic final byte  AP_ID       = (byte)  1;\n');
%     fprintf(fp,'\tstatic final byte  XBEE_ID     = (byte)255;\n');
%     fprintf(fp,'\tstatic final byte  COMP_ID     = (byte)  1;\n');
    
    %%%
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

    %%% Contruct Header from byte[]. 
    %%% Usually implies that a packet is being RECEIVED!
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
    
    %%% Contruct a Header for a Message with ID "mid"
    %%% Usually implies constructing a packet to be SENT!
%     fprintf(fp,'\tpublic MavHeader(byte mid)\n\t{\n');
%     fprintf(fp,'\t\tvHeader = true;\n');
%     fprintf(fp,'\t\tmsgHead = MAV_MARKER;\n');
%     fprintf(fp,'\t\tmsgLen  = MsgLengthArray[getMsgID(mid)];\n');
%     fprintf(fp,'\t\tmsgSeq  = SndSeq++;\n');
%     fprintf(fp,'\t\tmsgSid  = BEAGLE_ID;\n');
%     fprintf(fp,'\t\tmsgCid  = COMP_ID;\n');
%     fprintf(fp,'\t\tmsgGid  = mid;\n');
%     fprintf(fp,'\t}\n\n');
    
    %%% Identifies a valid RECEIVED header
%     fprintf(fp,'\tpublic boolean isValid(byte[] hdr)\n\t{\n');
%     fprintf(fp,'\t\tif (hdr.length<HEADER_SIZE)\treturn(false);\n');
%     fprintf(fp,'\t\treturn ((hdr[0]==MAV_MARKER)\n');
%     fprintf(fp,'\t\t      &&(hdr[1]==MsgLengthArray[getMsgID(hdr)])\n');
%     fprintf(fp,'\t\t      &&(hdr[3]==AP_ID)||(hdr[3]==XBEE_ID)||(hdr[3]==BEAGLE_ID)\n');
%     fprintf(fp,'\t\t      &&(hdr[4]==COMP_ID));\n');
%     fprintf(fp,'\t}\n\n');
    %%%
%     fprintf(fp,'\tpublic boolean isValid()\n\t{\n');
%     fprintf(fp,'\t\treturn(vHeader);\n');
%     fprintf(fp,'\t}\n\n');
    
    %%% Returns the header as a byte array
%     fprintf(fp,'\tpublic byte[] getHeader()\n\t{\n');
%     fprintf(fp,'\t\tbyte[] hdr = {msgHead,msgLen,msgSeq,msgSid,msgCid,msgGid};\n');
%     fprintf(fp,'\t\treturn(hdr);\n');
%     fprintf(fp,'\t}\n\n');
    
    %%%
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

%%% MavLink CheckSum Class
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
    
    switch (VERSION)
        case 0.9
            disp('Done JAVA code for MavLink 0.9')
        case 1.0
            disp('Done JAVA code for MavLink 1.0')
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
return

%% Generate APM Code based on XML data
function genAPMCode(Mess)
    global SWAP;
    global VERSION;
    if (SWAP)
        disp('Offset SWAPPING')
    end
    switch (VERSION)
        case 0.9
            %dDir = 'G:\\ArduRepo\\libraries\\GCS_MAVLink\\include\\common';
            dDir = 'AP\\include\\common';
        case 1.0
            %dDir = 'G:\\ArduRepo\\libraries\\GCS_MAVLink\\include_v1.0\\common';
            dDir = 'AP\\include_v1.0\\common';
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
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
        IDX=Mess(i).fields.idx;
        
        packetSize = sum(cell2mat(Mess(i).fields.apmByte));
        
        %% Message Length Array
        MAVLINK_MESSAGE_LENGTHS(ID+1) = packetSize;
        MAVLINK_MESSAGE_INFO{ID+1} = sprintf('MAVLINK_MESSAGE_INFO_%s',Mess(i).name);
        
        %% Do MavLink to APM types substitution
        APM.name = Mess(i).fields.name;
        APM.type = Mess(i).fields.apmType;
        APM.byte = Mess(i).fields.apmByte;
        APM.desc = Mess(i).fields.desc;
        APM.array = Mess(i).fields.Array;
        APM.uoffset = Mess(i).fields.uoffset;
        APM.soffset = Mess(i).fields.soffset;
        
%         %% Include file Array
%         fprintf(mif,sprintf('#include "./mavlink_msg_%s.h"\n',lower(Mess(i).name)));
% 
        %% Function Header
        newf = sprintf('%s\\mavlink_msg_%s.h',dDir,lower(Mess(i).name));
        fp = fopen(newf,'w');
        fprintf(fp,sprintf('// MESSAGE %s PACKING\n',Mess(i).name));
        fprintf(fp,'// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53\n\n');
        %fprintf(fp,sprintf('// Generated from parse_APM_XML.m on %s\n\n',datestr(clock)));
        
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s %d \n\n',Mess(i).name,ID));
        
        %% define structure for message
        fprintf(fp,sprintf('typedef struct __mavlink_%s_t \n',lower(Mess(i).name)));
        fprintf(fp,'{ \n');
        for j=1:N
            if (APM.array{j})
                if (SWAP)
                    fprintf(fp,'  %s %s[%d];  ///< %s\n',APM.type{IDX(j)}, APM.name{IDX(j)}, APM.array{IDX(j)}, APM.desc{IDX(j)});
                else
                    fprintf(fp,'  %s %s[%d];  ///< %s\n',APM.type{j}     , APM.name{j}     , APM.array{j}     , APM.desc{j});
                end
            else
                if (SWAP)
                    fprintf(fp,'  %s %s;  ///< %s\n',APM.type{IDX(j)}, APM.name{IDX(j)}, APM.desc{IDX(j)});
                else
                    fprintf(fp,'  %s %s;  ///< %s\n',APM.type{j}     , APM.name{j}     , APM.desc{j});
                end
            end
        end
        fprintf(fp,sprintf('} mavlink_%s_t;\n\n',lower(Mess(i).name)));
        
        %% define Message Length
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s_LEN %d\n',Mess(i).name,packetSize));
        fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%d_LEN %d\n\n',ID,packetSize));
        
        %% define CRC Message Length
        if (VERSION == 1.0)
            crcSize = 0;    %% dummy CRC size, needs to be determined
            fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%s_CRC %d\n',Mess(i).name,crcSize));
            fprintf(fp,sprintf('#define MAVLINK_MSG_ID_%d_CRC %d\n\n',ID,crcSize));
        end
        
        %% define Message INFO structure
        fprintf(fp,sprintf('#define MAVLINK_MESSAGE_INFO_%s \\\\\n{ \\\\\n',Mess(i).name));
        fprintf(fp,sprintf('  "%s", \\\\\n',Mess(i).name));
        fprintf(fp,sprintf('  %d, \\\\\n',N));
        fprintf(fp,sprintf('  { \\\\\n'));
%         voff = 0;
        for j=1:N
            if (SWAP)
                fprintf(fp,sprintf('    { "%s", NULL, MAVLINK_TYPE_%s, %d, %d, offsetof(mavlink_%s_t, %s) }, \\\\\n', APM.name{IDX(j)}, upper(APM.type{IDX(j)}), APM.array{IDX(j)}, APM.soffset(IDX(j)), lower(Mess(i).name), APM.name{IDX(j)}));
            else
                fprintf(fp,sprintf('    { "%s", NULL, MAVLINK_TYPE_%s, %d, %d, offsetof(mavlink_%s_t, %s) }, \\\\\n', APM.name{j}     , upper(APM.type{j})     , APM.array{j}     , APM.uoffset(j)     , lower(Mess(i).name), APM.name{j}));
            end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
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
%         voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
            if (APM.array{j} > 0)
                if (SWAP)
                    fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)},APM.array{IDX(j)}));
                else
                    fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}     ,APM.array{j}));
                end
            else
                if (SWAP)
                    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)}));
                else
                    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}));
                end
            end
            %end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
        end

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'#else\n');
        fprintf(fp,sprintf('\tmavlink_%s_t packet;\n',lower(Mess(i).name)));
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\tpacket.%s = 2;\n',APM.name{j}));
            %else
            if (APM.array{j} > 0)
                if (SWAP)
                    fprintf(fp,sprintf('\tmav_array_memcpy(packet.%s, %s, sizeof(%s)*%d);\n',APM.name{IDX(j)},APM.name{IDX(j)},APM.type{IDX(j)},APM.array{IDX(j)}));
                else
                    fprintf(fp,sprintf('\tmav_array_memcpy(packet.%s, %s, sizeof(%s)*%d);\n',APM.name{j},APM.name{j},APM.type{j},APM.array{j}));
                end
            else
                if (SWAP)
                    fprintf(fp,sprintf('\tpacket.%s = %s;\n',APM.name{IDX(j)},APM.name{IDX(j)}));
                else
                    fprintf(fp,sprintf('\tpacket.%s = %s;\n',APM.name{j},APM.name{j}));
                end
            end
            %end
        end

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'#endif\n');

        fprintf(fp,sprintf('\n\tmsg->msgid = MAVLINK_MSG_ID_%s;\n',Mess(i).name));
        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\treturn mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\treturn mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\treturn mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
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
%         voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)},APM.array{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}     ,APM.array{j}));
                    end
                else
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}));
                    end
                end
            %end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
        end

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
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

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,sprintf('\n\tmemcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'#endif\n');

        fprintf(fp,sprintf('\n\tmsg->msgid = MAVLINK_MSG_ID_%s;\n',Mess(i).name));
        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\treturn mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\treturn mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\treturn mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'}\n\n');
        
        %% Function Header - mavlink_msg_xxx_encode
        fprintf(fp,'/**\n');
        fprintf(fp,sprintf(' * @brief Encode a %s struct into a message\n',lower(Mess(i).name)));
        fprintf(fp,' *\n');
        fprintf(fp,' * @param system_id ID of this system\n');
        fprintf(fp,' * @param component_id ID of this component (e.g. 200 for IMU)\n');
        fprintf(fp,' * @param msg The MAVLink message to compress the data into\n');
        fprintf(fp,' * @param %s C-struct to read the message contents from\n',lower(Mess(i).name));
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
        if (VERSION == 1.0)
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
        end
        
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
%%  Original function
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
%         voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)},APM.array{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}     ,APM.array{j}));
                    end
                else
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}));
                    end
                end
            %end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
        end

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
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

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\n\t_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n\n');
%%  New function
        fprintf(fp,sprintf('static inline void mavlink_msg_wID_%s_send(\n',lower(Mess(i).name)));
        fprintf(fp,'\t mavlink_channel_t chan\n');
        fprintf(fp,'\t,uint8_t sID\n');
        fprintf(fp,'\t,uint8_t cID\n');
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
%         voff = 0;
        for j=1:N
            %if ((ID==0) && (j==N)) %% Heartbeat Message special processing
            %    fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, 2);\n',APM.type{j},voff));
            %else
                if (APM.array{j} > 0)
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)},APM.array{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s_array(buf, %d, %s, %d);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}     ,APM.array{j}));
                    end
                else
                    if (SWAP)
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{IDX(j)},APM.soffset(IDX(j)),APM.name{IDX(j)}));
                    else
                        fprintf(fp,sprintf('\t_mav_put_%s(buf, %d, %s);\n',APM.type{j}     ,APM.uoffset(j)     ,APM.name{j}));
                    end
                end
            %end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
        end

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, buf, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
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

        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
            case 1.0
                fprintf(fp,'#if MAVLINK_CRC_EXTRA\n');
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN, MAVLINK_MSG_ID_%s_CRC);\n',Mess(i).name,Mess(i).name,Mess(i).name));
                fprintf(fp,'#else\n');
                fprintf(fp,sprintf('\n\t_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_%s, (const char*)&packet, MAVLINK_MSG_ID_%s_LEN);\n',Mess(i).name,Mess(i).name));
                fprintf(fp,'#endif\n');
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        fprintf(fp,'#endif\n');
        fprintf(fp,'}\n\n');
%%
        fprintf(fp,'#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS\n\n');
        
        %% Function Header - MESSAGE xxx UNPACKING
        fprintf(fp,sprintf('// MESSAGE %s UNPACKING\n\n',Mess(i).name));
%         voff = 0;
        for j=1:N
            fprintf(fp,'/**\n');
            fprintf(fp,sprintf(' * @brief Get field %s from %s message\n',APM.name{j},lower(Mess(i).name)));
            fprintf(fp,' *\n');
            fprintf(fp,sprintf(' * @return %s\n',APM.desc{j}));
            fprintf(fp,' */\n');
            if (APM.array{j} > 0)
                fprintf(fp,sprintf('static inline %s mavlink_msg_%s_get_%s(const mavlink_message_t* msg, %s* %s)\n',APM.type{j},lower(Mess(i).name),APM.name{j},APM.type{j},APM.name{j}));
                fprintf(fp,'{\n');
                fprintf(fp,sprintf('	return _MAV_RETURN_%s_array(msg,%s,%d,%d);\n',APM.type{j},APM.name{j},APM.array{j},APM.uoffset(j)));
                fprintf(fp,'}\n\n');
            else
                fprintf(fp,sprintf('static inline %s mavlink_msg_%s_get_%s(const mavlink_message_t* msg)\n',APM.type{j},lower(Mess(i).name),APM.name{j}));
                fprintf(fp,'{\n');
                fprintf(fp,sprintf('	return _MAV_RETURN_%s(msg,%d);\n',APM.type{j},APM.uoffset(j)));
                fprintf(fp,'}\n\n');
            end
%             if (SWAP)
%                 voff = voff + APM.byte{IDX(j)};
%             else
%                 voff = voff + APM.byte{j};
%             end
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
    
    switch (VERSION)
        case 0.9
            disp('Done AP code for MavLink 0.9')
        case 1.0
            disp('Done AP code for MavLink 1.0')
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
return

%% Generate GroundStation Code based on XML data
function genGSCode(Mess)
    global SWAP;
    global VERSION;
    if (SWAP)
        disp('Offset SWAPPING')
    end
    %dDir = 'G:\\ArduRepo\\ArdupilotMegaPlanner';
    dDir = 'ArdupilotMegaPlanner';
    if (isempty(dir(dDir)))
        mkdir(dDir);
    end
    switch (VERSION)
        case 0.9
            newf = sprintf('%s\\MAVLinkTypes0.9_patch.cs',dDir);
        case 1.0
            newf = sprintf('%s\\MAVLinkTypes1.0_patch.cs',dDir);
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
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
    switch (VERSION)
        case 0.9
            fprintf(fp,'    public byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {');
        case 1.0
            fprintf(fp,'    public static readonly byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {');
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
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
        switch (VERSION)
            case 0.9
                MAVLINK_MESSAGE_INFO{ID+1} = sprintf('\t\t\ttypeof( __mavlink_%s_t),\t\t\t// message %d\n',lower(Mess(i).name),ID);
            case 1.0
                MAVLINK_MESSAGE_INFO{ID+1} = sprintf('\t\t\ttypeof( mavlink_%s_t),\t\t\t// message %d\n',lower(Mess(i).name),ID);
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
        
        %% Do MavLink to APM types substitution
        GCS.name = Mess(i).fields.name;
        GCS.type = Mess(i).fields.gcsType;
        GCS.byte = Mess(i).fields.gcsByte;
        GCS.desc = Mess(i).fields.desc;
        GCS.array = Mess(i).fields.Array;
        
        %% Function Header
        switch (VERSION)
            case 0.9
                fprintf(fp,sprintf('\tpublic const byte MAVLINK_MSG_ID_%s = %d;\n',Mess(i).name,ID));
                fprintf(fp,sprintf('\tpublic const byte MAVLINK_MSG_ID_%s_LEN = %d;\n',Mess(i).name,packetSize));
                fprintf(fp,sprintf('\t[StructLayout(LayoutKind.Sequential,Pack=1)]\n'));
                fprintf(fp,sprintf('\tpublic struct __mavlink_%s_t\n',lower(Mess(i).name)));
                fprintf(fp,sprintf('\t{\n'));
                for j=1:N
                    if (GCS.array{j} > 0)
                        fprintf(fp,'\t\t[MarshalAs(\n\t\t\tUnmanagedType.ByValArray,\n\t\t\tSizeConst=%d)]\n',GCS.array{j});
                        fprintf(fp,'\t\tpublic %s[] %s; /// %s\n',GCS.type{j}, GCS.name{j}, GCS.desc{j});
                    else
                        fprintf(fp,'\t\tpublic %s %s; /// %s\n',GCS.type{j}, GCS.name{j}, GCS.desc{j});
                    end
                end
                fprintf(fp,sprintf('\t};\n\n'));
            case 1.0
                fprintf(fp,sprintf('\t[StructLayout(LayoutKind.Sequential,Pack=1, Size=%d)]\n',packetSize));
                fprintf(fp,sprintf('\tpublic struct mavlink_%s_t\n',lower(Mess(i).name)));
                fprintf(fp,sprintf('\t{\n'));
                for j=1:N
                    if (GCS.array{j})
                        fprintf(fp,'\t\t[MarshalAs(\n\t\t\tUnmanagedType.ByValArray,\n\t\t\tSizeConst=%d)]\n',GCS.array{j});
                        fprintf(fp,'\t\tpublic %s[] %s; /// %s\n',GCS.type{j}, GCS.name{j}, GCS.desc{j});
                    else
                        fprintf(fp,'\t\tpublic %s %s; /// %s\n',GCS.type{j}, GCS.name{j}, GCS.desc{j});
                    end
                end
                fprintf(fp,sprintf('\t};\n\n'));
            otherwise
                disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
                return
        end
    end

    switch (VERSION)
        case 0.9
            fprintf(fp,'\tType[] mavstructs = new Type[] {\n');
        case 1.0
            fprintf(fp,'\tpublic static readonly Type[] MAVLINK_MESSAGE_INFO = new Type[] {\n');
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
    for i=1:256
        fprintf(fp,MAVLINK_MESSAGE_INFO{i});
    end
    fprintf(fp,'\t};\n');

    fclose(fp); fp = [];
    
    switch (VERSION)
        case 0.9
            disp('Done GCS code for MavLink 0.9')
        case 1.0
            disp('Done GCS code for MavLink 1.0')
        otherwise
            disp('Invalid MavLink version: valid cases are 0.9 and 1.0');
            return
    end
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
            Mess(k+1).fields = parseType(Mess(k+1).fields,n+1);
        end
        Mess(k+1).fields = MavLinkSort(Mess(k+1).fields);
        if (Mess(k+1).fields.needSwap)
            fprintf('%s message needs swap\n',Mess(k+1).name);
        end
    end   
    Mess = Mess(:);
return

%%
function Mess = MavLinkSort(Mess)
    %[~, Mess.idx] = sort(cell2mat(Mess.byte),'descend');
    [junk, Mess.idx] = sort(cell2mat(Mess.byte),'descend');
    N = length(Mess.idx);
%     Mess.soffset = [0; cumsum(cell2mat(Mess.byte(Mess.idx(1:N-1))))];
%     Mess.offset  = [0; cumsum(cell2mat(Mess.byte(1:N-1)))];
%     Mess.poffset(Mess.idx) = Mess.soffset;
%     Mess.poffset = Mess.poffset(:);
%     disp([Mess.soffset Mess.offset Mess.poffset])
    Mess.soffset = [0; cumsum(cell2mat(Mess.byte(Mess.idx(1:N-1))))];
    Mess.soffset(Mess.idx) = Mess.soffset;
    Mess.uoffset  = [0; cumsum(cell2mat(Mess.byte(1:N-1)))];
    Mess.needSwap = ~all(Mess.soffset==Mess.uoffset);
%     disp([Mess.soffset Mess.uoffset])
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
function fields = parseType(fields,n)
    if (isempty(fields.type{n}))
        fields.type{n} = 'NONE';
        fields.byte{n} = 0;
        return
    end

    mult = 1;
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
        fields.Array{n} = mult;
        %% debug statement to show declaration of arrays
        %disp([fields.name{n} ' is of type: ' fields.type{n}])
    else
        fields.Array{n} = 0;
    end
    
%     if (isempty(ttype))
%         fields.type{n} = fields.type{n};
%     end
    
    switch(ttype)
		case 'int8'
			fields.byte{n}     = 1; %mult;
			fields.matType{n}  = 'int8';
			fields.matByte{n}  = mult;
			fields.javaType{n} = 'byte';
			fields.javaByte{n} = mult;
			fields.apmType{n}  = 'int8_t';
			fields.apmByte{n}  = mult;
			fields.gcsType{n}  = 'byte';
			fields.gcsByte{n}  = mult;
		case 'int16'
			fields.byte{n}     = 2; %*mult;
			fields.matType{n}  = 'int16';
			fields.matByte{n}  = 2*mult;
			fields.javaType{n} = 'short';
			fields.javaByte{n} = 2*mult;
			fields.apmType{n}  = 'int16_t';
			fields.apmByte{n}  = 2*mult;
			fields.gcsType{n}  = 'short';
			fields.gcsByte{n}  = 2*mult;
		case 'int32'
			fields.byte{n}     = 4; %*mult;
			fields.matType{n}  = 'int32';
			fields.matByte{n}  = 4*mult;
			fields.javaType{n} = 'int';
			fields.javaByte{n} = 4*mult;
			fields.apmType{n}  = 'int32_t';
			fields.apmByte{n}  = 4*mult;
			fields.gcsType{n}  = 'int';
			fields.gcsByte{n}  = 4*mult;
		case 'uint8'
			fields.byte{n}     = 1; %mult;
			fields.matType{n}  = 'uint8';
			fields.matByte{n}  = mult;
			fields.javaType{n} = 'short';
			fields.javaByte{n} = 2*mult;
			fields.apmType{n}  = 'uint8_t';
			fields.apmByte{n}  = mult;
			fields.gcsType{n}  = 'byte';
			fields.gcsByte{n}  = mult;
		case 'char'
			fields.byte{n}     = 1; %mult;
			fields.matType{n}  = 'uint8';
			fields.matByte{n}  = mult;
			fields.javaType{n} = 'byte';
			fields.javaByte{n} = mult;
			fields.apmType{n}  = 'char';
			fields.apmByte{n}  = mult;
			fields.gcsType{n}  = 'byte';
			fields.gcsByte{n}  = mult;
		case 'uint16'
			fields.byte{n}     = 2; %*mult;
			fields.matType{n}  = 'uint16';
			fields.matByte{n}  = 2*mult;
			fields.javaType{n} = 'int';
			fields.javaByte{n} = 4*mult;
			fields.apmType{n}  = 'uint16_t';
			fields.apmByte{n}  = 2*mult;
			fields.gcsType{n}  = 'ushort';
			fields.gcsByte{n}  = 2*mult;
		case 'uint32'
			fields.byte{n}     = 4; %*mult;
			fields.matType{n}  = 'uint32';
			fields.matByte{n}  = 4*mult;
			fields.javaType{n} = 'long';
			fields.javaByte{n} = 8*mult;
			fields.apmType{n}  = 'uint32_t';
			fields.apmByte{n}  = 4*mult;
			fields.gcsType{n}  = 'uint';
			fields.gcsByte{n}  = 4*mult;
		case 'uint64'
			fields.byte{n}     = 8; %*mult;
			fields.matType{n}  = 'uint64';
			fields.matByte{n}  = 8*mult;
			fields.javaType{n} = 'long';
			fields.javaByte{n} = 8*mult;
			fields.apmType{n}  = 'uint64_t';
			fields.apmByte{n}  = 8*mult;
			fields.gcsType{n}  = 'ulong';
			fields.gcsByte{n}  = 8*mult;
		case 'float'
			fields.byte{n}     = 4; %*mult;
			fields.matType{n}  = 'single';
			fields.matByte{n}  = 4*mult;
			fields.javaType{n} = 'float';
			fields.javaByte{n} = 4*mult;
			fields.apmType{n}  = 'float';
			fields.apmByte{n}  = 4*mult;
			fields.gcsType{n}  = 'float';
			fields.gcsByte{n}  = 4*mult;
		case 'array'
			%fields.byte{n}     = 1; %mult;
			fields.byte{n}     = mult;
			fields.matType{n}  = 'uint8';
			fields.matByte{n}  = mult;
			fields.javaType{n} = 'byte';
			fields.javaByte{n} = mult;
			fields.apmType{n}  = 'uint8_t';
			fields.apmByte{n}  = mult;
			fields.gcsType{n}  = 'byte';
			fields.gcsByte{n}  = mult;
        otherwise
            fprintf('ERROR: Unknown Variable type: %s=>%s\n',fields.type{n},ttype)
    end
    
return
