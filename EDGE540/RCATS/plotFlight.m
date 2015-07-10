    % Load the data file first, then execute this cell
    % Zoom into the sync data to show the last section 
    % Select a time before the sync signal start,
    % (while its still zero) START TIME
    % Select a time after the sync signal ends
    % (after it goes to zero) END TIME

    slvFigure('Show Flight');
    h = [];
    h(1)=subplot(5,1,1);
        plot(RCATS.DATA.time,RCATS.DATA.rpm); grid on; vylabel('RPM')
    h(2)=subplot(5,1,2);
        hold off
        plot(RCATS.DATA.time,RCATS.DATA.altitude,'b'); 
        hold on
        plot(RCATS.GPS.time,(1000/(12*25.4))*RCATS.GPS.alt,'r'); 
        grid on; vylabel('Altitude (feet)')
        lText = [{'RCATS'} {'GPS'}];
        legend(lText)
    h(3)=subplot(5,1,3);
        hold off
        plot(RCATS.DATA.time,RCATS.DATA.ias,'b'); 
        hold on
        plot(RCATS.GPS.time,(1/1.609344)*RCATS.GPS.gSpeedKPH,'r'); 
        grid on; vylabel('Speed (MPH)')
        lText = [{'RCATS Airspeed'} {'GPS Groundspeed'}];
        legend(lText)
    h(4)=subplot(5,1,4);
        hold off;
        plot(RCATS.DATA.time,RCATS.DATA.frontmotorcurr,'b');
        hold on
        plot(RCATS.DATA.time,RCATS.DATA.aftmotorcurr,'r'); 
        grid on; vylabel('Current (A)')
        lText = [{'Front Motor'} {'Aft Motor'}];
        legend(lText)
    h(5)=subplot(5,1,5);
        plot(RCATS.DATA.time,RCATS.DATA.sync); 
        grid on; vylabel('Sync'); vxlabel('time (sec)');
    linkaxes(h,'x')

