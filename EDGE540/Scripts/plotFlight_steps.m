%% 
idx = find(RCATS.GPS.q==1 & RCATS.GPS.gSpeedKPH>0);
didx = diff(idx);
ididx = find(didx>10);
dididx = diff(ididx);
[mv mi] = max(dididx);
si = ididx(mi)+1;
ei = ididx(mi+1);
idx = idx(si:ei);

% subplot(2,1,1)
% hold off
% plot(RCATS.GPS.lon(idx),RCATS.GPS.lat(idx),':')
% hold on
% grid on
% set(gca,'XDir','reverse')
% 
% subplot(2,1,2)
hold off
plot3(RCATS.GPS.lon(idx),RCATS.GPS.lat(idx),RCATS.GPS.alt(idx))
hold all
grid on
axis square
view(163.5, 38)
set(gca,'XDir','reverse')

%%
N = length(idx);
MS = floor(RCATS.GPS.gSpeedKPH/10);
MS(MS==0) = 1;
MS(MS>20) = 20;

%%
%for i=idx(1):5:idx(N)
for j=1:length(idx)
    i = idx(j);
%     subplot(2,1,1)
%     plot(RCATS.GPS.lon(i),RCATS.GPS.lat(i),'r.')
%     subplot(2,1,2)
    h = plot3(RCATS.GPS.lon(i),RCATS.GPS.lat(i),RCATS.GPS.alt(i),'o','MarkerSize',MS(i));
    set(h,'MarkerFaceColor',get(h,'Color'));
    xlabel(sprintf('%d/%d',i,idx(N)))
    grid on
    %disp(RCATS.GPS.gSpeedKPH(i))
    pause(0.05)
end

%%
subplot(2,1,1)
plot(RCATS.GPS.lat)
grid on
subplot(2,1,2)
plot(RCATS.GPS.lon)
grid on
