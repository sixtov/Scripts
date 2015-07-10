%%
function expandStructure(S)
global level;
global root;
global fp;

fnames = fieldnames(S);
if isempty(fnames), return; end
N = length(fnames);
if (isempty(level))
    fp = fopen('junk.m','w');
    %(fp,'function junk(S)\n');
    level = -1;
end
level = level+1;
for i=1:N
    if (isstruct(S.(fnames{i})))
        root = sprintf('MavLink_ts.%s',fnames{i});
        fprintf(fp,'%%%% %s\n',fnames{i});
        expandStructure(S.(fnames{i}));
    else
        fprintf(fp,'%s = %s.%s;\n',fnames{i},root,fnames{i});
    end
end
fprintf(fp,'\n');
if (level==0)
    fclose(fp)
    root = [];
    level = [];
    fp = [];
    clear root level fp
else
    level = level-1;
end
return
