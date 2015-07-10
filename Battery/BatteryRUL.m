function P = BatteryRUL(P,dfile)
    %timeBase = P.ula20c_ts.time/3600;
    %secondBase = P.ula20c_ts.time;
    minuteBase = P.ula20c_ts.time/60;
    hourBase = P.ula20c_ts.time/3600;

    ulaCurrent = avg(P.ula20c_ts.data);
    uraCurrent = avg(P.ura40c_ts.data);
    llfCurrent = avg(P.llf20c_ts.data);
    lrfCurrent = avg(P.lrf40c_ts.data);
    
    ulaVoltage = avg(P.ula20v_ts.data);
    uraVoltage = avg(P.ura40v_ts.data);
    llfVoltage = avg(P.llf20v_ts.data);
    lrfVoltage = avg(P.lrf40v_ts.data);

    ulaAmpHour = cumtrapz(hourBase,ulaCurrent);
    uraAmpHour = cumtrapz(hourBase,uraCurrent);
    llfAmpHour = cumtrapz(hourBase,llfCurrent);
    lrfAmpHour = cumtrapz(hourBase,lrfCurrent);
    
    AmpHourCap = 7.8;
    minFlightCurr = 6;
    maxRUL = 60;
    
    ulaCurrent(ulaCurrent<minFlightCurr) = minFlightCurr;
    uraCurrent(uraCurrent<minFlightCurr) = minFlightCurr;
    llfCurrent(llfCurrent<minFlightCurr) = minFlightCurr;
    lrfCurrent(lrfCurrent<minFlightCurr) = minFlightCurr;
    
    ulaRUL = avg(60*((AmpHourCap - ulaAmpHour)./ulaCurrent));
    uraRUL = avg(60*((AmpHourCap - uraAmpHour)./uraCurrent));
    llfRUL = avg(60*((AmpHourCap - llfAmpHour)./llfCurrent));
    lrfRUL = avg(60*((AmpHourCap - lrfAmpHour)./lrfCurrent));

    ulaRUL(ulaRUL>maxRUL) = maxRUL;
    uraRUL(uraRUL>maxRUL) = maxRUL;
    llfRUL(llfRUL>maxRUL) = maxRUL;
    lrfRUL(lrfRUL>maxRUL) = maxRUL;
    
    ulaEOD = ulaRUL + minuteBase;
    uraEOD = uraRUL + minuteBase;
    llfEOD = llfRUL + minuteBase;
    lrfEOD = lrfRUL + minuteBase;

    idx = min([find(ulaRUL<=0,1,'first') find(uraRUL<=0,1,'first') find(llfRUL<=0,1,'first') find(lrfRUL<=0,1,'first')]);
    if (isempty(idx))
        [mv idx] = min([ulaRUL; uraRUL; llfRUL; lrfRUL]);
        idx = mod(idx-1,length(ulaRUL))+1;
        if (mv > 1), idx = length(ulaRUL); end
    end
    timeRUL = minuteBase(idx);
    
    slvFigure(dfile);
    h = zeros(4,1);
    h(1)=subplot(4,1,1);
    hold off
    plot(minuteBase,[ulaAmpHour uraAmpHour llfAmpHour lrfAmpHour]);
    hold on
    xlim([0 max(minuteBase)])
    ylim([0 12])
    plot(xlim,AmpHourCap*[1 1],'-d','LineWidth',2)
    plot(timeRUL*[1 1],ylim,'-d','LineWidth',2)
    yTick = unique(sort([0 2 4 6 AmpHourCap 10 12]));
    set(gca,'YTick',yTick);
    grid on
    xlabel('min')
    ylabel('Amp-Hours');
    legend('ULA20','URA40','LLF20','LRF40')
    
    h(2)=subplot(4,1,2);
    hold off
    %plot(minuteBase,[ulaCurrent uraCurrent llfCurrent lrfCurrent]);
    plot(minuteBase,[ulaVoltage uraVoltage llfVoltage lrfVoltage]);
    hold on
    xlim([0 max(minuteBase)])
    ylim([15 22])
    %plot(minuteBase,[P.ula20c_ts.data P.ura40c_ts.data P.llf20c_ts.data P.lrf40c_ts.data]);
    plot(timeRUL*[1 1],ylim,'-d','LineWidth',2)
    grid on
    xlabel('min')
%     ylabel('Current (Amps)');
    ylabel('Voltage (Volts)');
    legend('ULA20','URA40','LLF20','LRF40')
    
    h(3)=subplot(4,1,3);
    hold off
    plot(minuteBase,[ulaRUL uraRUL llfRUL lrfRUL]);
    hold on
    xlim([0 max(minuteBase)])
    ylim([0 maxRUL])
    plot(timeRUL*[1 1],ylim,'-d','LineWidth',2)
    %yTick = unique(sort([0 2 4 6 AmpHourCap 10 12]));
    %set(gca,'YTick',yTick);
    grid on
    xlabel('min')
    ylabel('RUL (min)');
    legend('ULA20','URA40','LLF20','LRF40')
    
    h(4)=subplot(4,1,4);
    hold off
    plot(minuteBase,100*(AmpHourCap-[ulaAmpHour uraAmpHour llfAmpHour lrfAmpHour])/AmpHourCap);
%     plot(minuteBase,[P.soc3_ts.data P.soc1_ts.data P.soc4_ts.data P.soc2_ts.data ]);
    hold on
    xlim([0 max(minuteBase)])
    ylim([0 100])
    plot(timeRUL*[1 1],ylim,'-d','LineWidth',2)
    grid on
    xlabel('min')
    ylabel('%soc');
    legend('ULA20','URA40','LLF20','LRF40')
    
 
    linkaxes(h,'x');
    
    P.ulaRUL = ulaRUL;
    P.uraRUL = uraRUL;
    P.llfRUL = llfRUL;
    P.lrfRUL = lrfRUL;
    
    P.ulaEOD = ulaEOD;
    P.uraEOD = uraEOD;
    P.llfEOD = llfEOD;
    P.lrfEOD = lrfEOD;
return    
    
function a = avg(a)
N = length(a);
p = 0.01;
for i=2:N
   a(i) =  p*a(i) + (1-p)*a(i-1);
end
return
