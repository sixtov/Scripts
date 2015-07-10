%%
function PC104 = decodePC104AsciiFilesNew(dname)
global count;
    %% Find Data
    DataFile = dir(strcat(dname,'\*PC104.mat'));

    % if file already exist, skip this folder
    if (~isempty(DataFile))
        disp(sprintf('"%s%c%s" file already exists',dname,filesep,DataFile.name))
        return; 
    end
    
%     SignalList = dir(strcat(dname,'\SignalList*.xls'));
    BHMCorr = dir(strcat(dname,'\BHMCorrections*.xls'));
    CalList = dir(strcat(dname,'\CalSheet*.xls'));
    DataFiles  = dir(strcat(dname,'\*F100*.mat'));
    if (isempty(DataFiles)), disp(sprintf('No Data Files in "%s"',dname)); return; end
    if (isempty(CalList))  , disp(sprintf('Missing Calibration File in "%s"',dname)); return; end
    if (isempty(BHMCorr))  , disp(sprintf('Missing BHM Correction File in "%s"',dname)); return; end
    if (~isempty(CalList))
        if (length(CalList)>1)
            disp(sprintf('%s: Multiple SignalList files present.',dname))
        end
        
        disp(sprintf('Processing Data Files in "%s"',dname));
        
        %% Pull the BHM correction from xls file
        corFile = strcat(dname,filesep,BHMCorr(1).name);
        [cjunk,junk,c]=xlsread(corFile);
        idxN = strfind(c(1,:),'BHM Signal');
        idxG = strfind(c(1,:),'Gain');
        idxB = strfind(c(1,:),'Bias');
        N = length(idxN);
        k = [];
        g = [];
        b = [];
        for i=1:N
            if (idxN{i}==1), k = i; end
            if (idxG{i}==1), g = i; end
            if (idxB{i}==1), b = i; end
        end
        if (~isempty(k))
            Nsig = size(c,1);
            count = 0;
            for i=1:Nsig
                if (~any(isnan(c{i,k}))), count = count+1; end
            end
            Nsig = min(count-1,64);
            for i=1:Nsig
                sig.(c{i+1,k}).p = [c{i+1,g} c{i+1,b}];
            end
        end
        
        %% Pull the signal info from xls file
        %% Info includes name, calibration factors (gain , bias) and units
        sigFile = strcat(dname,filesep,CalList(1).name);
        [njunk,junk,r]=xlsread(sigFile,'DownlinkCal');
        idxN = strfind(r(1,:),'Name');
        idxG = strfind(r(1,:),'Gain');
        idxB = strfind(r(1,:),'Bias');
        idxU = strfind(r(1,:),'Out_Units');
        N = length(idxN);
        k = [];
        g = [];
        b = [];
        u = [];
        for i=1:N
            if (idxN{i}==1), k = i; end
            if (idxG{i}==1), g = i; end
            if (idxB{i}==1), b = i; end
            if (idxU{i}==1), u = i; end
        end
        if (~isempty(k))
            Nsig = size(r,1);
            count = 0;
            for i=1:Nsig
                if (~any(isnan(r{i,k}))), count = count+1; end
            end
            Nsig = min(count-1,64);
            sig.Names = cell(Nsig,1);
            sig.Gain  = cell(Nsig,1);
            sig.Bias  = cell(Nsig,1);
            sig.Units = cell(Nsig,1);
            for i=1:Nsig
                sig.Names{i} = r{i+1,k};
                sig.Gain{i}  = r{i+1,g};
                sig.Bias{i}  = r{i+1,b};
                sig.Units{i} = r{i+1,u};
            end
        end
        PC104.AD.time = [];
        for i=1:Nsig
            PC104.AD.(sig.Names{i}) = [];
        end
    end
    
    dfiles = dir(strcat(dname,'\*.mat'));
    if (isempty(dfiles)), return; end

    %disp(sprintf('Decoding %s',dname))
    M = length(dfiles);
    idx100 = [];
    idx101 = [];
    
    for i=1:M
        if (~isempty(strfind(dfiles(i).name,'F100')))
            idx100 = i;
        end
        if (~isempty(strfind(dfiles(i).name,'F101')))
            idx101 = i;
        end
    end
    
    if (isempty(idx100) && isempty(idx101)), return; end
    
    if (~isempty(idx100))
        %% Found Data Files, begin processing
        idx10x = findstr(dfiles(idx100).name,'F10');
        if ~isempty(idx10x)
            outFile = strcat(dname,filesep,dfiles(idx100).name(1:idx10x-1),'PC104.mat');
        end
        warning('off','MATLAB:load:variableNotFound');
        load(strcat(dname,'\',dfiles(idx100).name),'pc104');    
        warning('on','MATLAB:load:variableNotFound');
        if exist('pc104','var'), if (isfield(pc104,'newdata')), pc104.data = pc104.newdata; end;  end
        f100 = pc104.data;
        t100 = f100(:,end);
        C100 = min(32,size(f100,2)-1);
        ts100 = timeseries(f100(:,1:C100),t100);
%     else
%         f100 = [];
%         t100 = [];
    end
    if (~isempty(idx101))
        warning('off','MATLAB:load:variableNotFound');
        load(strcat(dname,'\',dfiles(idx101).name),'pc104');    
        warning('on','MATLAB:load:variableNotFound');
        if exist('pc104','var'), if (isfield(pc104,'newdata')), pc104.data = pc104.newdata; end;  end
        f101 = pc104.data;
        t101 = f101(:,end);
        C101 = min(32,size(f101,2)-1);
        ts101 = timeseries(f101(:,1:C101),t101);
%     else
%         f101 = [];
%         t101 = [];
    end
    if (isempty(idx100))
        time = unique(sort(t101));
        ts101 = resample(ts101,time,'zoh');
        PC104.AD.time = time;
        data = ts101.data;
        NP = 32;
    else
        if (isempty(idx101))
            time = unique(sort(t100));
            ts100 = resample(ts100,time,'zoh');
            PC104.AD.time = time;
            data = ts100.data;
            NP = 32;
        else
            if (length(t100)~=length(t101))
                disp('time vector length disparity');
            end
            time = unique(sort([t100; t101]));
            ts100 = resample(ts100,time,'zoh');
            ts101 = resample(ts101,time,'zoh');
            PC104.AD.time = time;
            data = [ts100.data ts101.data];
            NP = 64;
        end
    end
    
    for i=1:NP
        PC104.AD.(sig.Names{i}) = [PC104.AD.(sig.Names{i}); polyval([sig.Gain{i} sig.Bias{i}],data(:,i))];
    end
        
    fidx = setdiff(1:M,[idx100 idx101]);

    %% BHM Fields
    PC104.BHM.time    = [];
    PC104.BHM.soc1    = [];
    PC104.BHM.soc2    = [];
    PC104.BHM.soc3    = [];
    PC104.BHM.soc4    = [];
                
    %% $GPGGA Fields
    PC104.GPS.time    = [];
    PC104.GPS.UTC     = [];
    PC104.GPS.lat     = [];
    PC104.GPS.lon     = [];
    PC104.GPS.alt     = [];
    PC104.GPS.head    = [];

    %% $VNQMR Fields
    PC104.VN.time    = [];
    PC104.VN.q0      = [];
    PC104.VN.q1      = [];
    PC104.VN.q2      = [];
    PC104.VN.q3      = [];
    PC104.VN.m1      = [];
    PC104.VN.m2      = [];
    PC104.VN.m3      = [];
    PC104.VN.a1      = [];
    PC104.VN.a2      = [];
    PC104.VN.a3      = [];
    PC104.VN.r1      = [];
    PC104.VN.r2      = [];
    PC104.VN.r3      = [];
    PC104.VN.yaw     = [];
    PC104.VN.pitch   = [];
    PC104.VN.roll    = [];
    
    PC104.RCATS.time           = [];
    PC104.RCATS.packet         = [];
    PC104.RCATS.rpm            = [];
    PC104.RCATS.altitude       = [];
    PC104.RCATS.ias            = [];
    PC104.RCATS.cgLoad         = [];
    PC104.RCATS.alt_off        = [];
    PC104.RCATS.ambient        = [];
    PC104.RCATS.thrust         = [];
    PC104.RCATS.motortemp      = [];
    PC104.RCATS.batterytemp    = [];
    PC104.RCATS.sync           = [];
    PC104.RCATS.nc             = [];
    PC104.RCATS.frontmotorcurr = [];
    PC104.RCATS.aftmotorcurr   = [];
    
    for j=fidx
        warning('off','MATLAB:load:variableNotFound');
        ldfile = strcat(dname,'\',dfiles(j).name);
        disp(sprintf('Loading "%s"',ldfile))
        load(ldfile,'pc104');
        warning('on','MATLAB:load:variableNotFound');
        if exist('pc104','var')
            if (isfield(pc104,'newdata'))
                pc104.data = pc104.newdata;
            end
            N = size(pc104.data,1);  % Number of logged strings with number to skip until
            K = size(pc104.data,2);
            
            %% BHM data file
            idx302 = findstr(dfiles(j).name,'F302');
            if ~isempty(idx302)
                %%N = size(pc104.data,2);
                %%BHMtime = pc104.data(:,N);
                PC104.BHM.time = [PC104.BHM.time pc104.data(:,K)];
                PC104.BHM.soc1 = [PC104.BHM.soc1 pc104.data(:,3)];
                PC104.BHM.soc2 = [PC104.BHM.soc2 pc104.data(:,19)];
                PC104.BHM.soc3 = [PC104.BHM.soc3 pc104.data(:,35)];
                PC104.BHM.soc4 = [PC104.BHM.soc4 pc104.data(:,51)];
            else
                ddata = pc104.data(:,1:K-1);
                if ((max(ddata(:))>255) || (min(ddata(:))<0))
                    continue;
                end
                dtext = char(ddata);
                for i=1:N
                    time = pc104.data(i,K);
                    line = dtext(i,:);
                    
                    %% GPS Data
                    if (findstr('$GPGGA',line))
%                             disp(sprintf('%c:%s:',' ',line))
                        [UTC,lat,lon,alt] = parse_latlonalt(line);
                        PC104.GPS.time    = [PC104.GPS.time; time];
                        PC104.GPS.UTC     = [PC104.GPS.UTC; UTC];
                        PC104.GPS.lat     = [PC104.GPS.lat; lat];
                        PC104.GPS.lon     = [PC104.GPS.lon; lon];
                        PC104.GPS.alt     = [PC104.GPS.alt; alt];
                    else
                        
                        %% VN100 Data
                        if (findstr('$VNQMR',line))
%                                 disp(sprintf('%c:%s:',' ',line))
                            [q0 q1 q2 q3 m1 m2 m3 a1 a2 a3 r1 r2 r3] = parse_vnqmr(line);
                            if ~isempty(q0)
                                [yaw pitch roll] = quat2euler3([q0 q1 q2 q3]);
                                PC104.VN.time  = [PC104.VN.time;  time];
                                PC104.VN.q0    = [PC104.VN.q0;    q0];
                                PC104.VN.q1    = [PC104.VN.q1;    q1];
                                PC104.VN.q2    = [PC104.VN.q2;    q2];
                                PC104.VN.q3    = [PC104.VN.q3;    q3];
                                PC104.VN.m1    = [PC104.VN.m1;    m1];
                                PC104.VN.m2    = [PC104.VN.m2;    m2];
                                PC104.VN.m3    = [PC104.VN.m3;    m3];
                                PC104.VN.a1    = [PC104.VN.a1;    a1];
                                PC104.VN.a2    = [PC104.VN.a2;    a2];
                                PC104.VN.a3    = [PC104.VN.a3;    a3];
                                PC104.VN.r1    = [PC104.VN.r1;    r1];
                                PC104.VN.r2    = [PC104.VN.r2;    r2];
                                PC104.VN.r3    = [PC104.VN.r3;    r3];
                                PC104.VN.yaw   = [PC104.VN.yaw;   yaw];
                                PC104.VN.pitch = [PC104.VN.pitch; pitch];
                                PC104.VN.roll  = [PC104.VN.roll;  roll];
                            end
                        else
                            
                            %% RCATS data
                            if (findstr('TSP',line))
    %                             disp(sprintf('%c:%s:',' ',line))
                                rcat = parseRCATS(line);
                                PC104.RCATS.packet   = [PC104.RCATS.packet; rcat.packet];
                                PC104.RCATS.rpm      = [PC104.RCATS.rpm; rcat.rpm];
                                PC104.RCATS.altitude = [PC104.RCATS.altitude; rcat.altitude];
                                PC104.RCATS.ias      = [PC104.RCATS.ias; rcat.ias];
                                PC104.RCATS.cgLoad   = [PC104.RCATS.cgLoad; rcat.cgLoad];
                                PC104.RCATS.alt_off  = [PC104.RCATS.alt_off; rcat.alt_off];
                                PC104.RCATS.ambient  = [PC104.RCATS.ambient; rcat.ambient];

                                %% Calculated signals
                                PC104.RCATS.time     = [PC104.RCATS.time; time];
                                PC104.RCATS.thrust   = [PC104.RCATS.thrust; rcat.thrust];

                                %% Most current RCATS configuration
                                PC104.RCATS.motortemp      = [PC104.RCATS.motortemp; rcat.motortemp];
                                PC104.RCATS.batterytemp    = [PC104.RCATS.batterytemp; rcat.batterytemp];
                                PC104.RCATS.sync           = [PC104.RCATS.sync; rcat.sync];
                                PC104.RCATS.nc             = [PC104.RCATS.nc; rcat.nc];
                                PC104.RCATS.frontmotorcurr = [PC104.RCATS.frontmotorcurr; rcat.frontmotorcurr];
                                PC104.RCATS.aftmotorcurr   = [PC104.RCATS.aftmotorcurr; rcat.aftmotorcurr];
                            else
                                
                                %% Other unparsed Data
%                                     disp(sprintf('%c:%s:','*',line(2:25)))
%                                 if (findstr('**BHM**',line))
%                                     [e1 r1 s1 e2 r2 s2 e3 r3 s3 e4 r4 s4] = parse_BHM(line);
%                                     PC104.BHM.time = [PC104.BHM.time time];
%                                     PC104.BHM.soc1 = [PC104.BHM.soc1 pc104.data(:,3)];
%                                     PC104.BHM.soc2 = [PC104.BHM.soc2 pc104.data(:,19)];
%                                     PC104.BHM.soc3 = [PC104.BHM.soc3 pc104.data(:,35)];
%                                     PC104.BHM.soc4 = [PC104.BHM.soc4 pc104.data(:,51)];
%                                 end
                            end
                        end
                    end
                end
%                 end
            end
        end
    end

    if (isempty(PC104.GPS.lat))
%         disp('ERROR: GPS data NOT found!')
    else
        N = length(PC104.GPS.lat);
        PC104.GPS.head = zeros(N,1);
        for i=2:N
            PC104.GPS.head(i) = get_bearing(PC104.GPS.lat(i),PC104.GPS.lon(i),PC104.GPS.lat(i-1),PC104.GPS.lon(i-1));
        end
        PC104.GPS.head(1) = PC104.GPS.head(2);
    end
    
    %% Apply 2-point moving average and 
    %% second correction to battery voltages and currents
    PC104.AD.URA40V = PC104.AD.URA40V - PC104.AD.ULA20V;
    PC104.AD.LRF40V = PC104.AD.LRF40V - PC104.AD.LLF20V;
    
    PC104.AD.ULA20V = filter(0.5*[1 1],1,PC104.AD.ULA20V,PC104.AD.ULA20V(1)/2);
    PC104.AD.ULA20V = polyval(sig.ULA20V.p,PC104.AD.ULA20V);
    
    PC104.AD.URA40V = filter(0.5*[1 1],1,PC104.AD.URA40V,PC104.AD.URA40V(1)/2);
    PC104.AD.URA40V = polyval(sig.URA40V.p,PC104.AD.URA40V);
    
    PC104.AD.LLF20V = filter(0.5*[1 1],1,PC104.AD.LLF20V,PC104.AD.LLF20V(1)/2);
    PC104.AD.LLF20V = polyval(sig.LLF20V.p,PC104.AD.LLF20V);
    
    PC104.AD.LRF40V = filter(0.5*[1 1],1,PC104.AD.LRF40V,PC104.AD.LRF40V(1)/2);
    PC104.AD.LRF40V = polyval(sig.LRF40V.p,PC104.AD.LRF40V);
    
    PC104.AD.ULA20C = filter(0.5*[1 1],1,PC104.AD.ULA20C,PC104.AD.ULA20C(1)/2);
    PC104.AD.ULA20C = polyval(sig.ULA20C.p,PC104.AD.ULA20C);

    PC104.AD.URA40C = filter(0.5*[1 1],1,PC104.AD.URA40C,PC104.AD.URA40C(1)/2);
    PC104.AD.URA40C = polyval(sig.URA40C.p,PC104.AD.URA40C);
    
    PC104.AD.LLF20C = filter(0.5*[1 1],1,PC104.AD.LLF20C,PC104.AD.LLF20C(1)/2);
    PC104.AD.LLF20C = polyval(sig.LLF20C.p,PC104.AD.LLF20C);
    
    PC104.AD.LRF40C = filter(0.5*[1 1],1,PC104.AD.LRF40C,PC104.AD.LRF40C(1)/2);
    PC104.AD.LRF40C = polyval(sig.LRF40C.p,PC104.AD.LRF40C);
                    
    if (exist('outFile','var'))
        count = count + 1;
        PC104 = removeRepeatedData(PC104);
        PC104 = cleanStruct(PC104);
        disp(sprintf('%03d>  Saving %s',count,outFile))
        save(outFile,'PC104');
        bhm_func3(outFile);
    end
    return
    
    function S = removeRepeatedData(S)
        fields = fieldnames(S);
        if (isempty(fields)), return; end
        if (isfield(S,'time'))
            [b m n] = unique(S.time,'first');
            if (length(m)==length(S.time)), return; end
        end
        N = length(fields);
        for i=1:N
            if (isstruct(S.(fields{i}))), S.(fields{i}) = removeRepeatedData(S.(fields{i})); 
            else
                if (exist('m','var')==1), S.(fields{i}) = S.(fields{i})(m); end
            end
        end
    return
    
