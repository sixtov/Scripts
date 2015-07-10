function channelMap = decodeMapping(chan_file)
    fid=fopen(chan_file);
    if fid == -1
        disp(sprintf('Could not open ''%s''',chan_file))
        return
    end
    channelMap.idx = [];
    channelMap.raw = [];
    channelMap.eu = [];
    channelMap.des = [];
    channelMap.gain = [];
    channelMap.bias = [];
    while 1
        tline = fgetl(fid);
        %disp(tline)
        if ~ischar(tline),   break,   end
        if ~isempty(tline)
            channelMap = parseMAP(tline,channelMap);
        end
    end
    fclose(fid);
return

function channelMap = parseMAP(tline,channelMap)
    tokIdx = [0 find(tline==',') length(tline)+1];
    tokSize = diff(tokIdx)-1;
    numTok = length(tokSize);
    for i=1:numTok
        if tokSize(i)>0
            myTok = tline(tokIdx(i)+1:tokIdx(i)+tokSize(i));
            switch(i)
                case 1  % idx
                    idx = sscanf(myTok,'%d');
                case 2  % name
                    raw = myTok;
                case 3  % name
                    eu = myTok;
                case 4  % description
                    des = myTok;
                case 5  % name
                    gain = sscanf(myTok,'%g');
                case 6  % name
                    bias = sscanf(myTok,'%g');
                otherwise
                    %disp(sprintf('%s - Unknown token',myTok))
            end
        end
    end
    if ~isempty(idx)
        channelMap.idx  = [channelMap.idx;  idx];
        channelMap.raw  = [channelMap.raw;  {raw}];
        channelMap.eu   = [channelMap.eu;   {eu}];
        channelMap.des  = [channelMap.des;  {des}];
        channelMap.gain = [channelMap.gain; gain];
        channelMap.bias = [channelMap.bias; bias];
    end
return

