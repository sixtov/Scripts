%%
correction = 10 + 35/60;
True = [0  90 180 270 360]' + correction;
Mag  = [9.5 107 191 273 370]';
Error = True - Mag;

p = [0.997 1.4]; %p = polyfit(Mag,True,1);
cMag = polyval(p,Mag);
cError = True - cMag;

disp('True Mag corrected');
disp(sprintf('%6.2f : %6.2f  %6.2f : %6.2f  %6.2f\n',[True'; Mag'; Error'; cMag'; cError']))
disp(sprintf('y = %f Mag + %f',p))

hold off
plot(Mag,True,'bo');
hold on
pMag = (0:45:360)' + correction;
pTrue = polyval(p,pMag);
plot(pMag,pTrue,'r','LineWidth',2)
grid on

