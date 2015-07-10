function RCATS = newParseRCATS(RCATSlog)
    RCATS = preDecodeRCATS(RCATSlog);
    DATA = [];
    RCATS.version  = 'Oct 06 2011';

    %% Default RCATS channels
    DATA.packet   = RCATS.RAW.packet;
    DATA.rpm      = RCATS.RAW.rpm;
    DATA.altitude = RCATS.RAW.altitude;
    DATA.ias      = RCATS.RAW.ias;
    DATA.cgLoad   = RCATS.RAW.cgLoad;
    DATA.alt_off  = RCATS.RAW.alt_off;
    DATA.ambient  = RCATS.RAW.ambient;

    %% Calculated signals
    %DATA.thrust   = 0.37*rdata(:,9)+25.7;
    DATA.thrust    = 6.74e-8*(DATA.rpm.^2.3020);   %% 26x10 Prop
    %DATA.thrust   = 3.19e-8*(DATA.rpm.^2.3627);   %% 24x12 Prop
    %DATA.thrust   = 1.69e-8*(DATA.rpm.^2.5080);   %% 28x10 Prop

    %% User defined channels
    if exist('RCATS_user.m','file')
        disp('Found local "RCATS_user.m" file');
        RCATS_user();
    else
        disp('Local "RCATS_user.m" file not found');
        %% Most current RCATS configuration
        RCATS.config = 'Conf_10';
        DATA.motortemp      = RCATS.RAW.temp1;             % temp1
        DATA.batterytemp    = RCATS.RAW.temp2;             % temp2
        DATA.sync           = RCATS.RAW.voltage;           % voltage
        DATA.nc             = RCATS.RAW.current;           % current
        DATA.frontmotorcurr = (RCATS.RAW.IO_1-2.5)/0.019;  % I/0 1
        DATA.aftmotorcurr   = (RCATS.RAW.IO_2-2.5)/0.019;  % I/O 2

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
    RCATS.DATA = DATA;
    %save(RCATS.file,'RCATS');
return
