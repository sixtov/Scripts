%%
function printStructureMembers(header,data)
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            nheader = strcat(header,'.',fname);
            printStructureMembers(nheader,data.(fname));
        else
            disp(sprintf('%s.%s',header,fname))
        end
    end
return
