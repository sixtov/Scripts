function plotSOC(label,t,SOC,timeS,timeE)
hold off
plot(t/60,SOC(:,2),'b')
hold on
[mv miS] = min(abs(t/60-timeS));
[mv miE] = min(abs(t/60-timeE));
plot(t([miS miE])/60,SOC([miS miE],2),'rd')
% plot(BHM.time/60,BHM.soc,'c')
grid on
xlim([timeS-1 timeE+1]);
ylim([0 105])
vtitle(sprintf('%s: SOC',label));
% xlabel('time (min)')
ylabel('SOC (%)')
return
