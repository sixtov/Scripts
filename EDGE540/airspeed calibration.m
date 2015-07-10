%%
actual = [24 27 36 45 55 70]*0.514444444;
cnts   = [2213 2250 2353 2495 2654 2955];
meas   = [22.5 25.2 32.1 39.7 46.5 58.7]*0.514444444;

slvFigure('Cnts');
subplot(2,1,1)
hold off
plot(cnts,actual,'o')
p = polyfit(cnts,actual,1);
hold on
plot(cnts,polyval(p,cnts),'r')
grid on

subplot(2,1,2)
hold off
plot(meas,actual,'o')
grid on
p = polyfit(meas,actual,1);
hold on
plot(meas,polyval(p,meas),'r')
disp(p)

%%
