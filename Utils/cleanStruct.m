function S = cleanStruct(S)
    names = fieldnames(S);
    rmList = [];
    N = length(names);
    for i=1:N
        if (isstruct(S.(names{i})))
            S.(names{i}) = cleanStruct(S.(names{i}));
            Snames = fieldnames(S.(names{i}));
            if isempty(Snames)
                S.(names{i}) = [];
            end
        end
        if isempty(S.(names{i}))
            rmList = [rmList; names(i)];
            %disp(sprintf('Removing %s field',names{i}))
        end
    end
    if (~isempty(rmList))
        S = rmfield(S,rmList);
    end
return
