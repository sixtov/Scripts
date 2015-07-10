function h=plotVoltageCurrent(label,t,V,I,timeS,timeE)
    hold off
    axout=plotyy(t/60,V,t/60,I,'plot');
    h=axout;
    hold on
    grid on
    set(axout,'XLim',[timeS-1 timeE+1])
    set(axout(1),'YLim',[15 22])
    set(axout(2),'YLim',[-10 100])
    vtitle(sprintf('%s: Voltage/Current',label));
return
