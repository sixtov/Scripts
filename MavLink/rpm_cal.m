%%
function rpm_cal(aircraft)
    switch aircraft
        case 'R3' %% Cal Data for R3
            load('R3_RPM_Cal_2011-09-07 01-59-44_mavLink.mat');
            timeS =[2950; 3075; 3118; 3156; 3183; 3209; 3240; 3270; 3472; 3500; 3527; 3555; 3583; 3625; 3670];
            timeE =[3039; 3083; 3134; 3167; 3189; 3219; 3245; 3419; 3483; 3508; 3533; 3562; 3599; 3634; 3749];
            RPM = [... % Data from digital scope
                       0; 3972; 6120; 5610; 4878; 3972; 2430;    0; 2352; 3660; 4380; 4998; 5820; 4896; 0; ];
            %%
            apmCnt.name = 'ADC Counts';
            apmCnt.data = double(MavLink.Analog.chan12);
            apmCnt.time = MavLink.Analog.time;

            apmPct.name = 'RC Scaled';
            apmPct.data = double(MavLink.RC.Scaled.chan3);
            apmPct.time = MavLink.RC.Scaled.time;

            apmPwm.name = 'RC Raw';
            apmPwm.data = double(MavLink.RC.Raw.chan3);
            apmPwm.time = MavLink.RC.Raw.time;

            apmServo.name = 'Servo Raw';
            apmServo.data = double(MavLink.Servo.Raw.chan3);
            apmServo.time = MavLink.Servo.Raw.time;
             %%
        case 'R2' %% Cal Data for R2
            load('R2_RPM_CalData_2012-04-04 01-30-52_mavLink.mat');
            timeS =[   1284; 1328; 1348; 1369; 1396; 1424; 1448; 1471; 1500; 1515; 1525; 1540; 1555; 1569; 1590; 1595; 1603; 1612; 1628; 1637; 1699; 1733; 1816; 1891; 1914; 1931; 1953; 1978; 2001];
            timeE =[   1311; 1336; 1362; 1385; 1408; 1437; 1462; 1493; 1509; 1522; 1538; 1552; 1566; 1584; 1594; 1601; 1607; 1623; 1633; 1682; 1716; 1790; 1874; 1907; 1925; 1940; 1964; 1991; 2014];
            RPM = 60*[... % Data from digital scope
                       20.4; 23.4; 26.5;   30;32.65; 36.7; 40.4; 44.9; 49.1; 52.4; 58.5; 63.5; 65.5; 71.2; 77.4;   82; 85.8;   89; 92.2; 94.8; 69.2;   65; 49.6; 38.5; 34.2; 30.9; 25.3; 22.3; 19.5];
            %%
            apmCnt.name = 'ADC Counts';
            apmCnt.data = double(MavLink.ANALOG_EU.chan12);
            apmCnt.time = MavLink.ANALOG_EU.time;

            apmPct.name = 'RC Scaled';
            apmPct.data = double(MavLink.RC_CHANNELS_SCALED.chan3_scaled);
            apmPct.time = MavLink.RC_CHANNELS_SCALED.time;

            apmPwm.name = 'RC Raw';
            apmPwm.data = double(MavLink.RC_CHANNELS_RAW.chan3_raw);
            apmPwm.time = MavLink.RC_CHANNELS_RAW.time;

            apmServo.name = 'Servo Raw';
            apmServo.data = double(MavLink.SERVO_OUTPUT_RAW.servo3_raw);
            apmServo.time = MavLink.SERVO_OUTPUT_RAW.time;
             %%
        otherwise
            disp('Error: Invalid Aircraft Selected');
            return
    end
    
    calData(apmCnt,timeS,timeE,RPM);
    calData(apmPct,timeS,timeE,RPM);
    calData(apmPwm,timeS,timeE,RPM);
    calData(apmServo,timeS,timeE,RPM);
return

%%
function calData(data,timeS,timeE,RPM)
    N = length(timeS);
    slvFigure(data.name);
    subplot(1,2,1)
    hold off
    plot(data.time,data.data,':.')
    hold on
    grid on
%    xlim([min(timeS) max(timeE)]);
    for i=1:N
        %idx = intersect(find(data.time>=timeS(i)),find(data.time<=timeE(i)));
        idx = timeS(i):timeE(i);
        avgData(i,1) = mean(data.data(idx));
        plot(data.time(idx),data.data(idx),'r.')
    end

    ytick = sort(unique(avgData));
    set(gca,'ytick',ytick);
    vtitle(data.name);

     %%
    p = polyfit(avgData,RPM,1);
    %p(2) = 0;
    cnt = linspace(min(data.data),max(data.data),100)'; %(0:64:768)';
    subplot(1,2,2)
    hold off
    plot(avgData,RPM,'o')
    hold on
    plot(cnt,polyval(p,cnt))
    grid on
    ylim([-10 7000]);
    vtitle(sprintf('%s Fit',data.name));
    if(p(2)>0)
        legend(sprintf('RPM = %f * %s + %f',p(1),data.name,p(2)),'Location','SouthEast');
    else
        legend(sprintf('RPM = %f * %s - %f',p(1),data.name,abs(p(2))),'Location','SouthEast');
    end
    %      %%
    %     disp('RPM Calibration Data');
    %     disp('Autopilot ADC counts         RPM from digital scope');
    %     disp([avgData RPM]);
    % 
    %     disp('Coefficients')
    %     disp(p)
    saveas(gcf,data.name,'jpg')
return
