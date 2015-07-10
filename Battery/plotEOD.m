function plotEOD(label,t,EOD,timeS,timeE)
hold off
plot(t/60,EOD(:,2)/60,'b')
hold on
[mv miS] = min(abs(t/60-timeS));
[mv miE] = min(abs(t/60-timeE));
plot(t([miS miE])/60,EOD([miS miE],2)/60,'rd')
grid on
xlim([timeS-1 timeE+1]);
vtitle(sprintf('%s: EOD',label));
ylabel('EOD (sec)')
return
