function [SET group] = getClassifierSet (data, set, SET, group, state)
    Ns = length(set);
    for i=1:Ns
        lSET(:,i) = data.(set{i})';
    end
    SET = [SET; lSET];
    N = length(data.(set{1}));
    newstuff(1:N) = state;
    group = [group; newstuff'];
return
