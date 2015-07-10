%%
function p = processParamFile(param)
    fid=fopen(param);
    if fid == -1
        disp(sprintf('Could not open ''%s''',RCATSlog))
        return
    end
    p.file = param;
    p.note = fgetl(fid);
    while 1
        tline = fgetl(fid);
        if ~ischar(tline),   break,   end
        [pname pvalue] = strtok(tline,',');
        p.param.(pname) = sscanf(pvalue,',%f');
    end
    printParams(p);
return

%%
function printParams(p)
    list = fieldnames(p.param);
    N = length(list);
    mL = 0;
    val = zeros(N,1);
    for i=1:N
        mL = max([mL length(list{i})]);
    end
    for i=1:N
        val(i) = p.param.(list{i});
        pad{i} = [];
        K = mL-length(list{i});
        for k=1:K
            pad{i} = [pad{i} ' '];
        end
    end

    list = reshape(list,[],3);
    val = reshape(val,[],3);
    pad = reshape(pad,[],3);

    N = size(list,1);
    fp = fopen(sprintf('%s_Table.txt',p.file(1:end-6)),'w');
    fprintf(fp,sprintf('%s\n',p.file));
    fprintf(fp,sprintf('%s\n',p.note));
    for i=1:N
        fprintf(fp,sprintf('%s%s=>%10.3f\t%s%s=>%10.3f\t%s%s=>%10.3f\n',list{i,1},pad{i,1},val(i,1),list{i,2},pad{i,2},val(i,2),list{i,3},pad{i,3},val(i,3)));
    end
    fclose(fp);
return