function oldDecodeRCATS(RCATSlog)
session = 1;
oPacket = 0;
nPacket = 0;
%froot = RCATSlog(1:find(RCATSlog=='.')-1);
%global fid;
fid=fopen(RCATSlog);
eid=fopen(strcat(RCATSlog(1:end-4),'_Error.txt'),'w');
if fid == -1
    disp(sprintf('Could not open ''%s''',RCATSlog))
    return
end
RCATS = [];
GPS = emptyGPS();
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    if ~isempty(tline)
        %disp(tline)
        expr =  [{'TSP'}; {'\$GPGGA'}; {'\$GPVTG'}];
        [start_idx, end_idx, extents, matches, tokens, names, splits] = regexp(tline,expr);
        N = length(matches);
        idxList = [];
        headerList = {};
        for i=1:N
            idxList = [idxList start_idx{i}];
            headerList = [headerList matches{i}];
        end
        
        if isempty(idxList), continue, end
        
        [idxList sidx] = sort(idxList);
        headerList = headerList(sidx)';
        idxList = sort([idxList idxList(2:end)-1 length(tline)]);
        idxList = reshape(idxList,2,[])';
        N = length(headerList);
        aline = tline;
        for i=1:N
            tline = aline(idxList(i,1):idxList(i,2));
            disp(tline)
            switch(headerList{i})
                case 'TSP'
                    ldata = sscanf(tline,'TSP%dA%fB%fC%dD%dE%fF%fG%fH%fI%fJ%fK%dL%f')';
                    if length(ldata) == 13
                        nPacket = ldata(1);
                        if nPacket < oPacket
                            saveSession(RCATSlog,session,RCATS,GPS);
                            session = session+1;
                            RCATS = []; GPS = emptyGPS();
                        end
                        RCATS = [RCATS; ldata];
                        oPacket = nPacket;
                    else
                        %disp(sprintf('FAILED decode----> "%s"',tline));
                        fprintf(eid,sprintf('%s\n',tline));
                    end
                case '$GPGGA'
                    GPGGA = parseGPGGA(tline);
                    GPGGA.packet = nPacket;
                case '$GPVTG'
                    GPVTG = parseGPVTG(tline);
            end
        end
        if (exist('GPGGA','var') && exist('GPVTG','var'))
            GPS = mergeStruct(GPS, combineStruct(GPGGA,GPVTG));
            clear GPGGA GPVTG;
        end
    end
end
saveSession(RCATSlog,session,RCATS,GPS);
fclose(fid);
fclose(eid);
return

function saveSession(file,session,rdata,gdata)
    RCATS = [];
    DATA = [];
    GPS = emptyGPS();
    if ~isempty(rdata)
        froot = file(1:find(file=='.')-1);
        RCATS.version  = 'Jan 21 2011';
        RCATS.source = file;
        RCATS.file     = sprintf('%s_Session%d.mat',froot,session);
        disp(sprintf('\ndecodeRCATS version dated "%s"',RCATS.version));
        
    %% Default RCATS channels
        DATA.packet   = rdata(:,1);
        DATA.rpm      = rdata(:,4);
        DATA.altitude = rdata(:,5);
        DATA.ias      = rdata(:,6);
        DATA.cgLoad   = rdata(:,8);
        DATA.alt_off  = rdata(:,12);
        DATA.ambient  = rdata(:,13);

    %% Calculated signals
        DATA.time     = (DATA.packet-DATA.packet(1))/10;
        %DATA.thrust   = 0.37*rdata(:,9)+25.7;
        DATA.thrust    = 6.74e-8*(DATA.rpm.^2.3020);   %% 26x10 Prop
        %DATA.thrust   = 3.19e-8*(DATA.rpm.^2.3627);   %% 24x12 Prop
        %DATA.thrust   = 1.69e-8*(DATA.rpm.^2.5080);   %% 28x10 Prop
        
        plotUserChannels(rdata(:,[2 3 7 9 10 11]));
        
    %% User defined channels
        if exist('RCATS_user.m','file')
            disp('Found local "RCATS_user.m" file');
            RCATS_user();
        else
            disp('Local "RCATS_user.m" file not found');
        %% Most current RCATS configuration
            RCATS.config = 'Most Current';
            DATA.motortemp      = rdata(:, 2);              % temp1
            DATA.batterytemp    = rdata(:, 3);              % temp2
            DATA.sync           = rdata(:, 7);              % voltage
            DATA.nc             = rdata(:,9);               % current
            DATA.frontmotorcurr = (rdata(:,10)-2.5)/0.019;  % I/0 1
            DATA.aftmotorcurr   = (rdata(:,11)-2.5)/0.019;  % I/O 2

        %% RCATS configuration on Jul 12 2010
%             RCATS.config = 'Jul 12 2010';
%             DATA.motortemp      = rdata(:, 2);              % temp1
%             DATA.batterytemp    = rdata(:, 3);              % temp2
%             DATA.sync           = rdata(:, 7);              % voltage
%             DATA.thrust         = 0.37*rdata(:,9)+25.7;     % current
%             DATA.frontmotorcurr = (rdata(:,10)-2.5)/0.019;  % I/0 1
%             DATA.aftmotorcurr   = (rdata(:,11)-2.5)/0.019;  % I/O 2

        %% RCATS configuration on Jun 30 2010
%             RCATS.config = 'Jun 30 2010';
%             DATA.motortemp      = rdata(:, 2);                  % temp1
%             DATA.batterytemp    = rdata(:, 3);                  % temp2
%             %DATA.voltage       = rdata(:, 7);                  % voltage
%             DATA.thrust         = 0.37*rdata(:,9)+25.7;         % current
%             DATA.frontmotorcurr = (rdata(:,10)-2.4861)/0.019;   % I/0 1
%             DATA.aftmotorcurr   = (rdata(:,11)-2.5014)/0.019;   % I/O 2

        %% RCATS configuration on Jun 01 2010
%             RCATS.config = 'Prop Test';
%             DATA.temp1          = rdata(:, 2);              % temp1
%             %DATA.temp2         = rdata(:, 3);              % temp2
%             %DATA.voltage       = rdata(:, 7);              % voltage
%             DATA.current        = rdata(:, 9)*(37/19);      % current (Amp100 instead of Amp25)
%             DATA.sync           = rdata(:,10);              % I/O 1
%             DATA.thrust         = rdata(:,11)*10;           % I/O 2

        %% RCATS configuration prior to Jun 01 2010
%             RCATS.config = 'Original';
%             DATA.temp1    = rdata(:, 2);        % temp1
%             DATA.temp2    = rdata(:, 3);        % temp2
%             DATA.voltage  = rdata(:, 7);        % voltage
%             %DATA.current  = rdata(:, 9);       % current
%             DATA.sync     = rdata(:,10);        % I/0 1
%             DATA.thrust   = rdata(:,11)*10;     % I/O 2
        end

       disp(sprintf('Using "%s" configuration',RCATS.config));
       if ~isempty(gdata)
            GPS = gdata;
        end

        [DATA GPS] = slvFixTime(DATA,GPS);
        RCATS.DATA = DATA;
        RCATS.GPS = GPS;
        save(RCATS.file,'RCATS');
        dfile = sprintf('%s_Raw%d.mat',froot,session);
        save(dfile,'file','rdata');
    end
return

function plotUserChannels(data)
    slvFigure('RCATS User Channels');
    h(1)=subplot(3,2,1); plot(data(:,1)); vtitle('[A2] temp1'); grid on;
    h(2)=subplot(3,2,2); plot(data(:,2)); vtitle('[B3] temp2'); grid on;
    h(3)=subplot(3,2,3); plot(data(:,3)); vtitle('[F7] voltage'); grid on;
    h(4)=subplot(3,2,4); plot(data(:,4)); vtitle('[H9] current'); grid on;
    h(5)=subplot(3,2,5); plot(data(:,5)); vtitle('[I10] IO_1'); grid on;
    h(6)=subplot(3,2,6); plot(data(:,6)); vtitle('[J11] IO_2'); grid on;
    linkaxes(h,'x');
return

function GPS = emptyGPS()
% $GPGGA Data
    GPS.packet       = [];
    GPS.time         = [];
    GPS.utc          = [];
    GPS.hour         = [];
    GPS.min          = [];
    GPS.sec          = [];
    GPS.lat          = [];
    GPS.latDir       = [];
    GPS.lon          = [];
    GPS.lonDir       = [];
    GPS.q            = [];
    GPS.numSat       = [];
    GPS.hzDil        = [];
    GPS.alt          = [];
    GPS.altUnits     = [];
    GPS.geodHeight   = [];
    GPS.geodUnits    = [];
    GPS.checkSum1    = [];
% $GPVTG Data
    GPS.trueCourse   = [];
    GPS.trueCourseL  = [];
    GPS.magCourse    = [];
    GPS.magCourseL   = [];
    GPS.gSpeedKnots  = [];
    GPS.gSpeedKnotsU = [];
    GPS.gSpeedKPH    = [];
    GPS.gSpeedKPHU   = [];
    GPS.mode         = [];
    GPS.checkSum2    = [];
return

function tline = getNewLine(fid)
    tline = fgetl(fid);
    while isempty(tline)
        tline = fgetl(fid);
        if ~ischar(tline), break, end
    end
    if ~ischar(tline)
        disp('tline is not char --------------->')
        return
    end
    
    k = strfind(tline,'TSP');
    if ~isempty(k)
        k = [k length(tline)];
        dk = diff(k);
        [mv mi] = max(dk);
        %tline = tline(k(mi):length(tline));
        tline = tline(k(mi):k(mi+1));
    else
    k = strfind(tline,'$GPGGA');
    if ~isempty(k)
        k = [k length(tline)];
        dk = diff(k);
        [mv mi] = max(dk);
        %tline = tline(k(mi):length(tline));
        tline = tline(k(mi):k(mi+1));
    else
    k = strfind(tline,'$GPVTG');
    if ~isempty(k)
        k = [k length(tline)];
        dk = diff(k);
        [mv mi] = max(dk);
        %tline = tline(k(mi):length(tline));
        tline = tline(k(mi):k(mi+1));
    else
    k = strfind(tline,'>>>');
    if ~isempty(k)
        k = [k length(tline)];
        dk = diff(k);
        [mv mi] = max(dk);
        %tline = tline(k(mi):length(tline));
        tline = tline(k(mi):k(mi+1));
    end
    end
    end
    end
    disp(tline)
return

function [RCATS GPS] = slvFixTime(RCATS,GPS)
%%
idx = find(GPS.packet>0);
GPS = extractSection(GPS,idx);

N = length(GPS.time);
GPS.time = (0:N-1)';

ridx = findRCATSidx(RCATS,GPS.packet);
RCATS = extractSection(RCATS,min(ridx):max(ridx));
ridx = findRCATSidx(RCATS,GPS.packet);

RCATS.time(1:end) = 0;
RCATS.time(ridx) = GPS.time;
for i=1:N-1
    M = ridx(i+1)-ridx(i);
    dt = 1/M;
    for j=1:M-1
        RCATS.time(ridx(i)+j) = RCATS.time(ridx(i)+j-1) + dt;
    end
end


%%
% h(1)=subplot(3,1,1); 
%     hold off
%     plot(RCATS.time,RCATS.ias,':b.');   grid on
%     hold on
%     plot(GPS.time,GPS.gSpeedKPH,':r.'); grid on
%     vxlabel('time (s)');
%     vylabel('Speed');
% h(2)=subplot(3,1,2); 
%     plot(RCATS.time,RCATS.sync,':.');  grid on
%     ylim([0 3]);
%     vxlabel('time (s)');
%     vylabel('sync');
% linkaxes(h,'x');
% 
% subplot(3,1,3); 
%     hold off
%     plot(RCATS.packet,RCATS.ias,':b.');   grid on
%     hold on
%     plot(GPS.packet,GPS.gSpeedKPH,':r.'); grid on
%     vxlabel('packet number');
%     vylabel('Speed');

%%
GPS = fixGPS_HMS(GPS);

return

function GPS = fixGPS_HMS(GPS)
GPS.hour = floor(GPS.time/3600);
GPS.min  = floor((GPS.time-GPS.hour*3600)/60);
GPS.sec  = GPS.time-GPS.hour*3600-GPS.min*60;
return

function ridx = findRCATSidx(RCATS,packets)
    N = length(packets);
    ridx = zeros(N,1);
    for i=1:N
        ridx(i) = find(RCATS.packet==packets(i));
    end
return

function [GPS gidx] = fixGPStime(GPS)
    %% Check for leftover GPS packets from previous session
    %% usually first one
    dp = [diff(GPS.packet); 10];
    dpdx = find(dp>0);
    if length(dpdx)~=length(GPS.time) % if lengths don't match throw away bad points
        names = fieldnames(GPS);
        K = length(names);
        for i=1:K
            GPS.(names{i}) = GPS.(names{i})(dpdx);
        end
    end
    N = length(GPS.time);
    nSat = 3;
    gtErr = 0;
    %% Start with >3 satellites and increment until there are no
    %% time artifacts in GPS
    while ~isempty(gtErr)
        gidx = find(GPS.q>0 & GPS.numSat>nSat);
        if ~isempty(gidx)
            dt = diff(GPS.time(gidx))-diff(gidx);
            gtErr = find(dt~=0);
            if ~isempty(gtErr)
                nSat = nSat+1;
            end
        else
            gtErr = [];
        end
    end
    if isempty(gidx)
        gidx = 1:length(GPS.time);
    end
    GPS.time = GPS.time-GPS.time(gidx(1));
    [mv mi] = min(GPS.hzDil(gidx));
    midx = gidx(mi);
    firstHalf  = midx-1:-1:1;
    secondHalf = midx+1: 1:N;
    
    GPS.time(firstHalf)  = GPS.time(midx) + cumsum( round(diff(GPS.packet([midx  firstHalf]))/10) );
    GPS.time(secondHalf) = GPS.time(midx) + cumsum( round(diff(GPS.packet([midx secondHalf]))/10) );
    GPS = fixGPS_HMS(GPS);      % resets GPS HOURS, MINUTES, and SECONDS to match time
    
    %% Look for GPS points more than one sec away from neighbors
    idx = find(diff(GPS.time)>1)+1;
    if ~isempty(idx)
        disp('Indices of GPS points more than one second away from neighbors')
        disp(idx')
    end
    
return

