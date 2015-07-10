function decodeRCATS(RCATSlog)
session = 1;
oPacket = 0;
nPacket = 0;
%froot = RCATSlog(1:find(RCATSlog=='.')-1);
global fid;
fid=fopen(RCATSlog);
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
        disp(tline)
        switch(tline(1))
            case 'T'
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
                end
            case '$'
                NMEA_Code = tline(1:6);
                switch(NMEA_Code)
                    case '$GPGGA'
                        GPS = parseGPS(tline,GPS,nPacket);
%                             nGPS = length(GPS.time);
%                             nRCATS = length(RCATS.time);
%                             if nGPS>0 && GPS.q(nGPS)==1
%                                 RCATS.time(nRCATS) = GPS.time(nGPS);
%                             end
                    case '$GPVTG'
                        disp(tline)
                    otherwise
                        disp('Unparsed command')
                end
        end
    end
end
saveSession(RCATSlog,session,RCATS,GPS);
fclose(fid);
return

function saveSession(file,session,rdata,gdata)
    RCATS = [];
    DATA = [];
    GPS = emptyGPS();
    if ~isempty(rdata)
        froot = file(1:find(file=='.')-1);
        RCATS.version  = 'Jan 21 2011';
        RCATS.file     = sprintf('%s_Session%d.mat',froot,session);
        
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
        %DATA.thrust   = 3.26737e-9*(DATA.rpm.^2.623114);    %% 24x12 Prop
        DATA.thrust   = 1.63187e-9*(DATA.rpm.^2.732623);    %% 26x10 Prop
        %DATA.thrust   = 3.84187e-9*(DATA.rpm.^2.682559);   %% 28x10 Prop
        
        plotUserChannels(rdata(:,[2 3 7 9 10 11]));
        
        %% User defined channels
        if exist('RCATS_user.m','file')
            RCATS_user();
        else
            %% Most current RCATS configuration
            RCATS.config = 'Most Current';
            DATA.motortemp      = rdata(:, 2);              % temp1
            DATA.batterytemp    = rdata(:, 3);              % temp2
            DATA.sync           = rdata(:, 7);              % voltage
            %DATA.current        = rdata(:,9);              % current
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

        if ~isempty(gdata)
            GPS = gdata;
        end

        [DATA GPS] = slvFixTime(DATA,GPS);
        RCATS.DATA = DATA;
        RCATS.GPS = GPS;
        save(RCATS.file,'RCATS');
        dfile = sprintf('%s_Raw%d.mat',froot,session);
        save(dfile,'rdata');
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

function GPS = parseGPS(tline,GPS,packet)
    global fid;
    lGPS = blankGPS();
    lGPS = parseGPGGA(tline,lGPS);

    %% Now parse the $GPVTG line
    %oline = tline;
    VTG_DATA = '$GPVTG';
    tline = getNewLine(fid);
    if ischar(tline)
        nChars = min(length(tline),6);
        NMEA_Code = tline(1:nChars);
        switch(NMEA_Code)
            case VTG_DATA(1:nChars)
                if lGPS.q==1
                    lGPS = parseGPVTG(tline,lGPS);
                end
            otherwise
                disp(sprintf('Expected $GPVTG received %s',NMEA_Code))
        end
    end
    
%     if lGPS.q==1
    nGPS = length(GPS.time);
    if nGPS>0
%         delta = round((packet-GPS.packet(nGPS))/10);
%         if delta==0
%             delta = 1;
%         end
%         packet = GPS.packet(nGPS) + 10*delta;
        if lGPS.q~=1
            lGPS.time = GPS.time(nGPS)+1;
            lGPS = fixGPS_HMS(lGPS);
        end
        if lGPS.time<GPS.time(nGPS)
            disp(sprintf('Time Discontinuity at [RCATS packet %d]',packet))
        end
    end
    % $GPGGA Data
    GPS.packet       = [GPS.packet; packet];
    GPS.time         = [GPS.time; lGPS.time];
    GPS.utc          = [GPS.utc; lGPS.utc];
    GPS.hour         = [GPS.hour; lGPS.hour];
    GPS.min          = [GPS.min; lGPS.min];
    GPS.sec          = [GPS.sec; lGPS.sec];
    GPS.lat          = [GPS.lat; lGPS.lat];
    GPS.latDir       = [GPS.latDir; lGPS.latDir];
    GPS.lon          = [GPS.lon; lGPS.lon];
    GPS.lonDir       = [GPS.lonDir; lGPS.lonDir];
    GPS.q            = [GPS.q; lGPS.q];
    GPS.numSat       = [GPS.numSat; lGPS.numSat];
    GPS.hzDil        = [GPS.hzDil; lGPS.hzDil];
    GPS.alt          = [GPS.alt; lGPS.alt];
    GPS.altUnits     = [GPS.altUnits; lGPS.altUnits];
    GPS.geodHeight   = [GPS.geodHeight; lGPS.geodHeight];
    GPS.geodUnits    = [GPS.geodUnits; lGPS.geodUnits];
    GPS.diffDataAge  = [GPS.diffDataAge; lGPS.diffDataAge];
    GPS.stationID    = [GPS.stationID; lGPS.stationID];
    % $GPVTG Data
    GPS.trueCourse   = [GPS.trueCourse; lGPS.trueCourse];
    GPS.trueCourseL  = [GPS.trueCourseL; lGPS.trueCourseL];
    GPS.magCourse    = [GPS.magCourse; lGPS.magCourse];
    GPS.magCourseL   = [GPS.magCourseL; lGPS.magCourseL];
    GPS.gSpeedKnots  = [GPS.gSpeedKnots; lGPS.gSpeedKnots];
    GPS.gSpeedKnotsU = [GPS.gSpeedKnotsU; lGPS.gSpeedKnotsU];
    GPS.gSpeedKPH    = [GPS.gSpeedKPH; lGPS.gSpeedKPH];
    GPS.gSpeedKPHU   = [GPS.gSpeedKPHU; lGPS.gSpeedKPHU];
    GPS.mode         = [GPS.mode; lGPS.mode];
%     end
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
    GPS.diffDataAge  = [];
    GPS.stationID    = [];
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
return

function GPS = blankGPS()
    % $GPGGA Data
    GPS.packet       =   0;
    GPS.time         =  -1;
    GPS.utc          =   0;
    GPS.hour         =   0;
    GPS.min          =   0;
    GPS.sec          =  -1;
    GPS.lat          =   0;
    GPS.latDir       = 'N';
    GPS.lon          =   0;
    GPS.lonDir       = 'W';
    GPS.q            =   0;
    GPS.numSat       =   0;
    GPS.hzDil        =   -1;
    GPS.alt          =   0;
    GPS.altUnits     = 'M';
    GPS.geodHeight   =   0;
    GPS.geodUnits    = 'M';
    GPS.diffDataAge  =   0;
    GPS.stationID    =   0;
    % $GPVTG Data
    GPS.trueCourse   =   0;
    GPS.trueCourseL  = 'T';
    GPS.magCourse    =   0;
    GPS.magCourseL   = 'M';
    GPS.gSpeedKnots  =   0;
    GPS.gSpeedKnotsU = 'N';
    GPS.gSpeedKPH    =   0;
    GPS.gSpeedKPHU   = 'K';
    GPS.mode         = 'N';
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

