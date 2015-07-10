%plotLinked(RCATS)
clf
clear h;
R = 4;
C = 1;

idx = find(RCATS.GPS.q);
dtime = [1; diff(RCATS.GPS.time(idx))];
didx = [1; diff(idx)];
%dtime(dtime==RCATS.GPS.time(idx(1))+1) = 0;
dtime = dtime./didx;
pn = 1;

h(pn) = subplot(R,C,pn);
    %plot(idx,RCATS.GPS.time(idx),':.')
    plot(idx,dtime,':.')
    grid on
    ylabel('time steps')
    pn = pn+1;
h(pn) = subplot(R,C,pn);
    plot(idx,RCATS.GPS.numSat(idx),':.')
    grid on
    ylabel('numSat')
    pn = pn+1;
h(pn) = subplot(R,C,pn);
    plot(idx,RCATS.GPS.hzDil(idx),':.')
    grid on
    ylabel('Horz Dil')
    pn = pn+1;
% h(pn) = subplot(R,C,3);
%     plot(idx,RCATS.GPS.lat(idx),':.')
%     grid on
%     ylabel('lat')
%     pn = pn+1;
% h(pn) = subplot(R,C,pn);
%     plot(idx,RCATS.GPS.lon(idx),':.')
%     grid on
%     ylabel('lon')
%     pn = pn+1;
% h(pn) = subplot(R,C,pn);
%     plot(idx,RCATS.GPS.alt(idx),':.')
%     grid on
%     ylabel('alt')
%     pn = pn+1;
h(pn) = subplot(R,C,pn);
    plot(idx,RCATS.GPS.gSpeedKPH(idx),':.')
    grid on
    ylabel('ground speed')
    pn = pn+1;
    
%%%
linkaxes(h,'x');  
    