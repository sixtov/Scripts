function data = combineStruct(s1,s2)
    data = [];
    data = copyStruct(data,s1);
    data = copyStruct(data,s2);
return

function data = copyStruct(data,s1)
    names = fieldnames(s1);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(s1.(fname))
            data.(fname) = s1.(fname);
        else
            if isnumeric(s1.(fname))
                data.(fname) = s1.(fname);
            else
                data.(fname) = {s1.(fname)};
            end
        end
    end
return
