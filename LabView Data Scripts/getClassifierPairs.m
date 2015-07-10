function [SL SW group] = getClassifierPairs (data, xl, yl, SL, SW, group, state)

SL = [SL ; data.(xl)'];
SW = [SW ; data.(yl)'];
N = length(data.(xl));
newstuff(1:N) = state;
group = [group; newstuff'];


return
