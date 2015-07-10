function EDGE = timeSync(RCATS,PC104)
    %%  Process flight 4
    clear
    % cd 'C:\IVHM\AirStar work\Flight Test\2009-10 Smithfield II\Flight 4\RCATS';
    % %processRCATSdata ();
    load 'RCATS\RCATS.mat'
    % cd 'C:\IVHM\AirStar work\Flight Test\2009-10 Smithfield II\Flight 4\PC104';
    load 'PC104\new_FLT4_102009_1147.mat'
    % cd 'C:\IVHM\AirStar work\Flight Test\2009-10 Smithfield II\Flight 4\RCATS';

    %%  Find start of action
    slvFigure ('PC104 data starting point');
    clf
    % sine = pc104.data(:,34) - mean(pc104.data(:,34));
    % plot(pc104.data(:,73),sine)
    plot(pc104.data(:,73),pc104.data(:,34))
    hold all
    grid on
    % rcSync = RCATS.DATA.sync - mean(RCATS.DATA.sync);
    % plot( RCATS.DATA.time, rcSync , '-g' )
    plot( RCATS.DATA.time, RCATS.DATA.sync, 'r' )

    %% RCATS got turned off before PC104 in this post-flight procedure
    % this part is different for each flight.
    firstHi = find(RCATS.DATA.sync >0, 1, 'first');
    lastLo = find(RCATS.DATA.sync  == 0, 1,'last');
    lastHi = find(RCATS.DATA.sync >0, 1, 'last');
    if (lastLo < lastHi)  % use last low as start of RCATS data
        offset = RCATS.DATA.time(lastLo);
        clrIdx = lastLo;
    else
        offset = RCATS.DATA.time(firstHi);
        clrIdx = firstHi;
    end
    %tweek = .08;
    tweek = 0;
    offset = offset-tweek;

    %% save original sync signal and zero out all out of scope points
    oldSync = RCATS.DATA.sync;
    RCATS.DATA.sync(1:clrIdx) = 0;  % restore original signal before saving

    %%   plot pc104 vs rcats sync to determine offsets

    slvFigure ('PC104 vs RCATS sync');
    clf
    plot(pc104.data(:,73),pc104.data(:,34))
    hold on
    plot(RCATS.DATA.time-offset,RCATS.DATA.sync, '-or')
    grid on
    %%
    [nppc104,zctimespc104] = findZeroCrossings(pc104.data(:,73), pc104.data(:,34)-1.5);
    zcmarkspc104 = zeros(length(zctimespc104),1)+ max(pc104.data(34));
    stem(zctimespc104,zcmarkspc104.*4.8,'b')
    %%
    [nprcats,zctimesrcats] = findZeroCrossings(RCATS.DATA.time-offset, RCATS.DATA.sync-1.5);
    zcmarksrcats = zeros(length(zctimesrcats),1)+ max(RCATS.DATA.sync);
    stem(zctimesrcats,zcmarksrcats,'-*r')
    %%
    rcatstime = RCATS.DATA.time - offset;
    rcatntime = rcatstime;
    %find small of data set
    if (nppc104 > nprcats) %rcats got turned off early
        tmCycles = nprcats;
    else 
        tmCycles = nppc104;
    end
    for i=1:tmCycles-1
        %zctimesrcats(i:i+1)
        %zctimespc104(i:i+1)
        %[p,S] = polyfit(zctimesrcats(i:i+1), zctimespc104(i:i+1),1);
        %[timeslot] = find( zctimesrcats(i) < rcatstime & rcatstime <= zctimesrcats(i+1)  );
        p = polyfit(zctimesrcats(i:i+1), zctimespc104(i:i+1),1);
        [timeslot] = find( zctimesrcats(i) < rcatstime & rcatstime <= zctimesrcats(i+1)  );
        %length(timeslot)
        %[rcatntime(timeslot),delta] = polyval(p,rcatstime(timeslot),S);
        [rcatntime(timeslot)] = polyval(p,rcatstime(timeslot));
    end;

    %%  throw away extra times
    firstMatchedIdx = find(rcatntime >= 0, 1, 'first');
    lastMatchedIdx = timeslot(length(timeslot));

    f=firstMatchedIdx;
    l=lastMatchedIdx;

    %%  verify RCATS sync signal adjusted times against pc104 sine wave
    slvFigure('Original vs Adjusted RCATS sync');
    clf
    plot(pc104.data(:,73),pc104.data(:,34))
    hold on
    grid on
    plot(rcatntime(f:l),RCATS.DATA.sync(f:l), '-or')

    %% restore sync signal
    RCATS.DATA.sync = oldSync;

    %% copy data to new structure
    TMD.DATA = extractSection(RCATS.DATA,f:l);
    TMD.DATA.time = rcatntime(f:l);

    %% need to time match GPS structure using packet number cross over
    [c ia ib] = intersect(TMD.DATA.packet,RCATS.GPS.packet);
    TMD.GPS = extractSection(RCATS.GPS,ib);
    TMD.GPS.time = TMD.DATA.time(ia);

    %%  Check time alignment by comparing RCATS cgload vs pc104 cg accel z axis
    slvFigure ('Alignment check using Features');
    clf
    cgload = TMD.DATA.cgLoad - mean(TMD.DATA.cgLoad);
    plot(TMD.DATA.time, cgload)
    hold on
    amp = 3;
    cgz = pc104.data(:,32) - mean(pc104.data(:,32));
    plot(pc104.data(:,73),cgz.*amp, 'r')
    cgstr = pc104.data(:,5) - mean(pc104.data(:,5));
    plot(pc104.data(:,73),cgstr.*amp, 'g')
    grid on


    %% save packet
    save('RCATS_TMD', 'RCATS','TMD');
return