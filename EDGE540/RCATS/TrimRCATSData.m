%% Section 01 of 03
    decodeRCATS('RCATS_Flight_08_trimmed_071610.LOG');
    decodeRCATS('RCATS_Flight_09_trimmed_071610.LOG');
    decodeRCATS('RCATS_Flight_10_trimmed_071610.LOG');

%% Section 02 of 03
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

%% Section 03 of 03
    % Call truncateRCATSFile using the information
    % from previous section
    % truncateRCATSFile(DATAFILE, START TIME, END TIME);
    truncateRCATSFile('RCATS_Flight_08_trimmed_071610_Session1.mat',1440,2400);% Flight 08
    truncateRCATSFile('RCATS_Flight_09_trimmed_071610_Session1.mat', 500,1600);% Flight 09
    truncateRCATSFile('RCATS_Flight_10_trimmed_071610_Session1.mat', 400,1900);% Flight 10

%% Section A
% file = 'RCATS_Flight_08_trimmed_071610.mat';
% load(file);
% 
% %% Section B
% slvFigure('Show Flight');
% h = [];
% h(1)=subplot(5,1,1);
%     plot(RCATS.DATA.time,RCATS.DATA.rpm); grid on; vylabel('RPM')
% h(2)=subplot(5,1,2);
%     hold off
%     plot(RCATS.DATA.time,RCATS.DATA.altitude,'b'); 
%     hold on
%     plot(RCATS.GPS.time,(1000/(12*25.4))*RCATS.GPS.alt,'r'); 
%     grid on; vylabel('Altitude (feet)')
% h(3)=subplot(5,1,3);
%     hold off
%     plot(RCATS.DATA.time,RCATS.DATA.ias,'b'); 
%     hold on
%     plot(RCATS.GPS.time,(1/1.609344)*RCATS.GPS.gSpeedKPH,'r'); 
%     grid on; vylabel('Speed (MPH)')
% h(4)=subplot(5,1,4);
%     hold off;
%     plot(RCATS.DATA.time,RCATS.DATA.frontmotorcurr,'b');
%     hold on
%     plot(RCATS.DATA.time,RCATS.DATA.aftmotorcurr,'r'); 
%     grid on; vylabel('Current (A)')
% h(5)=subplot(5,1,5);
%     plot(RCATS.DATA.time,RCATS.DATA.sync); 
%     grid on; vylabel('Sync')
% linkaxes(h,'x')
% 
% %% Section C-08
% stime = 1440;% Flight 08
% etime = 2400;% Flight 08
% 
% %% Section C-09
% stime = 500;% Flight 09
% etime = 1600;% Flight 09
% 
% %% Section C-10
% stime = 400;% Flight 10
% etime = 1900;% Flight 10
% 
% %% Section D
% gt0 = find(RCATS.GPS.time>=stime,1,'first');
% gt1 = find(RCATS.GPS.time<=etime,1,'last');
% stime = RCATS.GPS.time(gt0);
% etime = RCATS.GPS.time(gt1);
% rt0 = find(RCATS.DATA.time>=stime,1,'first');
% rt1 = find(RCATS.DATA.time<=etime,1,'last');
% 
% RCATS.DATA = extractSection(RCATS.DATA,rt0:rt1);
% RCATS.GPS   = extractSection(RCATS.GPS  ,gt0:gt1);
% 
% %% Section E
% save(file,'RCATS');
