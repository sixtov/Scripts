function SyncRCATSandPC104(fnum,RCATS_file,PC104_file)
    %% Load PC104 and RCATS data for same Flight
    %fnum = 08;
    %PC104_file = 'PC104_EDGE540R2_FLT08.mat';
    %RCATS_file = 'RCATS_Flight_08_trimmed_071610.mat';
    if isnumeric(fnum)
        FLIGHT = sprintf('FLIGHT_%02d',fnum);
    else
        FLIGHT = fnum;
    end
    load(PC104_file);
    load(RCATS_file);

    %% Remove Bad GPS Points and Plot
    idx = find(PC104.GPS.lon ~= 0);
    GPS.PC104 = extractSection(PC104.GPS,idx);
    idx = find(RCATS.GPS.lon ~= 0);
    GPS.RCATS = extractSection(RCATS.GPS,idx);

    hold off
    plot(GPS.PC104.utc,GPS.PC104.lon,':bo')
    hold on
    plot(GPS.RCATS.utc,-GPS.RCATS.lon,':r.')

    %% Select Mid-Array PC104 GPS utc Time
    p.idx = ceil(length(PC104.GPS.utc)/2);
    p.utc = PC104.GPS.utc(p.idx);
    p.time = PC104.GPS.time(p.idx);

    %% Find corresponding point in RCATS
    r.idx = find(RCATS.GPS.utc == p.utc);
    r.utc = RCATS.GPS.utc(r.idx);
    r.time = RCATS.GPS.time(r.idx);

    %% Set RCATS time to match PC104 time
    off = p.time-r.time;
    RCATS.DATA.time = RCATS.DATA.time + off;
    RCATS.GPS.time  = RCATS.GPS.time  + off;

    EDGE.RCATS = RCATS;
    EDGE.PC104 = PC104;

    %%
    save(sprintf('EDGE_%s.mat',FLIGHT),'EDGE');

    %% Check Results
    hold off
    plot(EDGE.PC104.RAW.time,EDGE.PC104.RAW.ADC45/0.019-141,'b')
    hold on
    plot(EDGE.RCATS.DATA.time,EDGE.RCATS.DATA.frontmotorcurr,'r')
    grid on
return
