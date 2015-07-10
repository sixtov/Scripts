%%
slvFigure('Motion');
subplot(3,1,1)
xl = get(gca,'xlim');
ids = find(SENSOR.time>=xl(1),1,'first');
ide = find(SENSOR.time<=xl(2),1,'last');
y = SENSOR.disp(ids:ide,2);
Y = abs(fft(y));
Y(1) = 0;

N = length(y);
fs = 200;
f = linspace(0,fs,N);

slvFigure('FFT');
plot(f,Y,':.');
grid on
[ym yi] = max(Y);
set(gca,'Xtick',f(yi));
xlim([0 10])
