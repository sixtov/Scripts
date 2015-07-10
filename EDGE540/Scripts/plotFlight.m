%% 
idx = find(RCATS.q==1 & RCATS.gSpeedKPH>0);
didx = diff(idx);
ididx = find(didx>10);
dididx = diff(ididx);
[mv mi] = max(dididx);
si = ididx(mi)+1;
ei = ididx(mi+1);
idx = idx(si:ei);

% subplot(2,1,1)
% hold off
% plot(RCATS.lon(idx),RCATS.lat(idx),':')
% hold on
% grid on
% set(gca,'XDir','reverse')
% 
% subplot(2,1,2)
hold off
plot3(RCATS.lon(idx),RCATS.lat(idx),RCATS.alt(idx))
hold all
grid on
axis square
view(163.5, 38)
set(gca,'XDir','reverse')

%%
N = length(idx);
MS = floor(RCATS.gSpeedKPH/10);
MS(MS==0) = 1;
MS(MS>20) = 20;

%%
%for i=idx(1):5:idx(N)
for j=1:length(idx)
    i = idx(j);
%     subplot(2,1,1)
%     plot(RCATS.lon(i),RCATS.lat(i),'r.')
%     subplot(2,1,2)
    h = plot3(RCATS.lon(i),RCATS.lat(i),RCATS.alt(i),'o','MarkerSize',MS(i));
    set(h,'MarkerFaceColor',get(h,'Color'));
    xlabel(sprintf('%d/%d',i,idx(N)))
    grid on
    %disp(RCATS.gSpeedKPH(i))
    pause(0.05)
end

%%
subplot(2,1,1)
plot(RCATS.lat)
grid on
subplot(2,1,2)
plot(RCATS.lon)
grid on
