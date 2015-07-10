function processPC104data()
    %%% Process PC104 data files
    pc104_file = dir('*.mat');

    if ~isempty(pc104_file)
        N = length(pc104_file);
        for i=1:N
            if ~strcmp(pc104_file(i).name,'PC104.mat')
                load(pc104_file(i).name,'pc104');
                if exist('pc104','var')
                    PC104 = mapPC104Channels(pc104);
                    save('PC104.mat','PC104');
                    break
                end
            end
        end
    end
return

function PC104 = mapPC104Channels(pc104)
    chan_file = dir('channelMap.csv');
    if ~isempty(chan_file)
        channelMap = decodeMapping(chan_file.name);
        idx = find(channelMap.idx);
        PC104.des = [];
        for i=1:length(idx)
            PC104.DATA.(channelMap.nam{idx(i)}) = pc104.data(:,channelMap.idx(idx(i)));
            PC104.des = [PC104.des; {channelMap.des{idx(i)}}];
        end
        PC104.DATA.sync = sin(2*pi*0.5*PC104.DATA.time)+1.5; %pc104.data(:,71);
        PC104.des = [PC104.des; {'Synchronizing sine wave'}];
    end
return

function channelMap = decodeMapping(chan_file)
    fid=fopen(chan_file);
    if fid == -1
        disp(sprintf('Could not open ''%s''',chan_file))
        return
    end
    channelMap.idx = [];
    channelMap.nam = [];
    channelMap.des = [];
    while 1
        tline = fgetl(fid);
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
                    nam = myTok;
                case 3  % description
                    des = myTok;
                otherwise
                    disp(sprintf('%s - Unknown token',myTok))
            end
        end
    end
    channelMap.idx = [channelMap.idx; idx];
    channelMap.nam = [channelMap.nam; {nam}];
    channelMap.des = [channelMap.des; {des}];
return

