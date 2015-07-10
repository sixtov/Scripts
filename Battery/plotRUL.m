function plotRUL(label,t,RUL,timeS,timeE)
hold off
plot(t/60,RUL(:,2)/60,'b')
hold on
[mv miS] = min(abs(t/60-timeS));
[mv miE] = min(abs(t/60-timeE));
plot(t([miS miE])/60,RUL([miS miE],2)/60,'rd')
grid on
xlim([timeS-1 timeE+1]);
vtitle(sprintf('%s: RUL',label));
ylabel('RUL (sec)')
return
