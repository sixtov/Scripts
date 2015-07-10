function RCATS = parseRCATS(tline)
    RCATS = [];
    rdata = sscanf(tline,'TSP%dA%fB%fC%dD%dE%fF%fG%fH%fI%fJ%fK%dL%f')';
    if length(rdata) == 13
        %% Default RCATS channels
        RCATS.packet   = rdata(:,1);
        RCATS.rpm      = rdata(:,4);
        RCATS.altitude = rdata(:,5);
        RCATS.ias      = rdata(:,6);
        RCATS.cgLoad   = rdata(:,8);
        RCATS.alt_off  = rdata(:,12);
        RCATS.ambient  = rdata(:,13);

        %% Calculated signals
        RCATS.time     = (RCATS.packet-RCATS.packet(1))/10;
        %RCATS.thrust   = 0.37*rdata(:,9)+25.7;
        RCATS.thrust    = 6.74e-8*(RCATS.rpm.^2.3020);   %% 26x10 Prop
        %RCATS.thrust   = 3.19e-8*(RCATS.rpm.^2.3627);   %% 24x12 Prop
        %RCATS.thrust   = 1.69e-8*(RCATS.rpm.^2.5080);   %% 28x10 Prop
        
        %% Most current RCATS configuration
        RCATS.config = 'Most Current';
        RCATS.motortemp      = rdata(:, 2);              % temp1
        RCATS.batterytemp    = rdata(:, 3);              % temp2
        RCATS.sync           = rdata(:, 7);              % voltage
        RCATS.nc             = rdata(:,9);               % current
        RCATS.frontmotorcurr = (rdata(:,10)-2.5)/0.019;  % I/0 1
        RCATS.aftmotorcurr   = (rdata(:,11)-2.5)/0.019;  % I/O 2
    end
return
