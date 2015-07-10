%% Breaks up a data set into multiple segments
%%% (currently three pieces)

%%% First: Specify the corresponding dCase
%%%        and run the first cell

%%% Second: Choose good time to split the data
%%%         by looking at the graph and type
%%%         those times into the tid array in 
%%%         the second cell

clear
%%%% DEFINE your case (folder name)
dCase = 'SFDI_0g_12cyc_20x15_1rep_sine_4trials_042810_1652';

if strcmp(dCase,'')
    disp('Please define your dcase and run again');
else
    process_Case(dCase);
    %
    Fs = 200;
    Ts = 1/Fs;

    PC104exist  = 0;
    FOIDexist   = 0;
    SENSORexist = 0;

    flist = dir(sprintf('%s\\PC104.mat',dCase));
    if ~isempty(flist)
        load(sprintf('%s\\%s',dCase,flist(1).name));
        PC104exist = 1;
        tp = PC104.DATA.time;
    end

    flist = dir(sprintf('%s\\SENSOR.mat',dCase));
    if ~isempty(flist)
        load(sprintf('%s\\%s',dCase,flist(1).name));
        SENSORexist = 1;
        ts = SENSOR.time;
    end

    flist = dir(sprintf('%s\\FOID.mat',dCase));
    if ~isempty(flist)
        load(sprintf('%s\\%s',dCase,flist(1).name));
        FOIDexist = 1;
        tf = FOID.time;
    end

    [b,a] = butter(2,0.25);

    if SENSORexist
        y = filtfilt(b,a,SENSOR.disp);
        N = length(y);
        y = y-repmat(mean(y),N,1);

        lText = [{'uE (Inboard)'} {'uE (Mid\_Inboard)'} {'uE (Mid\_Outboard)'} {'uE (Outboard)'}];
        idx = 2:4;
        subplot(2,1,1)
        hold off
        plot(ts,y(:,idx))
        hold on
        xlabel('time (s)')
        ylabel('displacement (mm)')
        legend(lText(idx));

        subplot(2,1,2)
        idx = 2:4;
        for i=1:length(idx)
            [p(:,i) f] = psd(y(:,idx(i)));
        end
        hold off
        semilogy(f*Fs/2,p)
        hold on
        grid on
        xlabel('frequency (Hz)')
        ylabel('Mag')
        legend(lText(idx));
        xlim([0 25]);
    end

    figure
    plot(PC104.DATA.time, PC104.DATA.CGAZ)
    hold on
    plot(PC104.DATA.time, PC104.DATA.CANOBAZ, 'r')
end

%%
%%%% DEFINE your time index array (tid)
%    FORMAT: 
%               [seg1_start seg1_stop/seg2_start seg2_stop/seg3_start ... segn_stop];
%    EXAMPLE: 
%               [10 80 142 202 263];
%
%               Start_time      End_time
%    segment_1       10            80
%    segment_2       80           142
%    segment_3      142           202
%    segment_4      202           263
tid = [65 125 190 255 325];

if isempty(tid)
    disp('Please define your time index array (tid) and run again');
else
    rCnt = length(tid) - 1;
    hi = ones(size(tid))*max(ylim());
    stem(tid, hi, 'm');
    lo = ones(size(tid))*min(ylim());
    stem(tid, lo, 'm');
    
    if SENSORexist
        OSENSOR = SENSOR;
        for t = 1:rCnt

            idrange = find(OSENSOR.time>=tid(t)   & OSENSOR.time<tid(t+1));
            SENSOR = extractSection(OSENSOR,idrange);
            SENSOR.time = SENSOR.time - SENSOR.time(t);
            dname = sprintf('%s_%02d',dCase, t);
            flist = dir(dname);
            if isempty(flist)
                mkdir(dname);
            end
            save(sprintf('%s\\SENSOR.mat',dname),'SENSOR');
        end
    end

    if PC104exist
        OPC104 = PC104;
        for t = 1:rCnt
            idrange = find(OPC104.DATA.time>=tid(t)   & OPC104.DATA.time<tid(t+1));
            PC104 = extractSection(OPC104,idrange);
            PC104.DATA.time = PC104.DATA.time - PC104.DATA.time(t);
            dname = sprintf('%s_%02d',dCase, t);
            flist = dir(dname);
            if isempty(flist)
                mkdir(dname);
            end
            save(sprintf('%s\\PC104.mat',dname),'PC104');
        end
    end
end
