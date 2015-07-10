function AHRS = decodeAHRS(AHRSlog)
global fid;
    disp('DECODE STARTS:')
    session = 1;
    disp(sprintf('SESSION %d',session))
    fid=fopen(AHRSlog);
    if fid == -1
        disp(sprintf('Could not open ''%s''',AHRSlog))
        return
    end
    header = cleanHeader(fgetl(fid));
    AHRS = emptyAHRS(header);
    while 1
        tline = fgetl(fid);
        if ~ischar(tline),   break,   end
        if ~isempty(tline)
            AHRS = parseAHRS(tline,AHRS);
        end
    end
    fclose(fid);
return

function header = cleanHeader(tokList)
    cnt = 0;
    while 1
        [token tokList] = strtok(tokList,',');
        if isempty(token),  break;  end
        token = token(find(isstrprop(token, 'alphanum')));
        cnt = cnt+1;
        lheader{cnt} = token;
    end
    header = lheader(1:cnt-1);
return

function AHRS = emptyAHRS(header)
    N = length(header);
    for i=1:N
        AHRS.(header{i}) = [];
    end
    AHRS.time = [];
return

function AHRS = parseAHRS(tline,AHRS)
    ldata = sscanf(tline,'%f,')';
    if (ldata(1))
        %disp(tline)
        N = length(ldata);
        elem = fieldnames(AHRS);
        for i=1:N
            AHRS.(elem{i}) = [AHRS.(elem{i}); ldata(i)];
        end
        nAHRS = length(AHRS.hour);
        AHRS.time = [AHRS.time; AHRS.hour(nAHRS)*3600+AHRS.minute(nAHRS)*60+AHRS.second(nAHRS)+(AHRS.orderinsec(nAHRS)-1)/20];
    else
        disp(tline)
    end
return

