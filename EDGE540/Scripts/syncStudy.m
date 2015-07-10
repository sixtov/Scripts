%%
load('RCATS.mat');
f = 0.5;
T = 1/f;
y = RCATS.DATA.sync;
N = length(y);
idx = find(y==0,1,'last')+1;
y = y(idx:N)-1.5;
y = y/max(abs(y));
te = RCATS.DATA.time;
te = te(idx:N)-te(idx);
t = te;
N = length(y);

for i=1:N
    idx = floor(max(1,i-20)):floor(min(N,i+20));
    e = y(i)-sin(2*pi*f*t(i));
    while abs(e)>1e-3
        m = cos(2*pi*f*t(i))/2;
        if abs(m*e)<1e-4, m = sign(m)*1e-4/abs(e); end
        t(i) = t(i) + m*e;
        e = y(i)-sin(2*pi*f*t(i));
%         hold off
%         plot(y(idx),':b.')
%         hold on
%         plot(i-idx(1)+1,sin(2*pi*f*t(i)),':ro')
    end
%     hold off
%     plot(y(idx),':b.')
%     hold on
%     plot(i-idx(1)+1,sin(2*pi*f*t(i)),':ro')
%     pause(0.1)
end
hold off
plot(y,':b.')
hold on
plot(sin(2*pi*f*t),':ro')
grid on
return
