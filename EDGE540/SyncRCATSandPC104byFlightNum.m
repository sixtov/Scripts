function SyncRCATSandPC104byFlightNum(fnum)
    if isnumeric(fnum)
        dNum = sprintf('%02d',fnum);
    end
    FLIGHT = strcat('FLIGHT_',dNum);
    
    pFile = dir(sprintf('PC104*%s*.mat',dNum));
    PC104_file = pFile(1).name;
    rFile = dir(sprintf('RCATS*%s*.mat',dNum));
    RCATS_file = rFile(1).name;
    
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
    %plot(EDGE.PC104.RAW.time,EDGE.PC104.RAW.ADC45/0.019-141,'b')
    plot(EDGE.PC104.EU.time,EDGE.PC104.EU.altitude,'b')
    hold on
    %plot(EDGE.RCATS.DATA.time,EDGE.RCATS.DATA.frontmotorcurr,'r')
    plot(EDGE.RCATS.DATA.time,EDGE.RCATS.DATA.altitude,'r')
    grid on
    pause(1)
return
