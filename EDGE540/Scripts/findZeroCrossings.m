function [nPeriods zcTimes] = findZeroCrossings(time,sync)
    junk(sync> 1.5) = 1;
    junk(sync<=1.5) = 0;
    idx = find(diff(junk)~=0);
    nPeriods = floor(length(idx)/2);
    
    zcTimes = zeros(size(idx));
    %hold on
    %tickLabels = [];
    for i=1:length(idx)
        p = polyfit(sync(idx(i):idx(i)+1),time(idx(i):idx(i)+1),1);
        zcTimes(i) = polyval(p,1.5);
        %plot(zcTimes(i),1.5,'r.')
        %tickLabels = [tickLabels {sprintf('%.2f',zcTimes(i))}];
    end
    %set(gca,'XTick',zcTimes);
    %set(gca,'XTickLabels',tickLabels);
    %grid on
    %hold off
return
