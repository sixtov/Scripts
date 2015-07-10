%%
function findPC104MatFilesAndDoBHM()
global count;
    count = 0;
    dfiles = dir();
    if (isempty(dfiles)), return; end
    N = length(dfiles);
    for i=1:N
        if (dfiles(i).isdir && ~strcmp(dfiles(i).name,'.') && ~strcmp(dfiles(i).name,'..'))
%         if (dfiles(i).isdir && ~strcmp(dfiles(i).name,'..'))
            processDir(dfiles(i).name);
        end
    end
return

function processDir(dname)
%     disp(dname)
    dfiles = dir(dname);
    if (isempty(dfiles)), return; end
    N = length(dfiles);
    for i=1:N
        if (dfiles(i).isdir && ~strcmp(dfiles(i).name,'.') && ~strcmp(dfiles(i).name,'..'))
            nname = strcat(dname,filesep,dfiles(i).name);
            processDir(nname);
        end
    end
    dfile = dir(sprintf('%s%c*PC104.mat',dname,filesep));
    if ~isempty(dfile);
        N = length(dfile);
        for i=1:N
            pcfile = sprintf('%s%c%s',dname,filesep,dfile(i).name);
            bhfile = sprintf('%s_BHM.mat',pcfile(1:end-4));
            df = dir(bhfile);
            if isempty(df)
                BHM = bhm_func3(pcfile);
                if ~isempty(BHM)
                    disp(bhfile);
                    %%load(bhfile);
                    %%quickSOCPlot;
                end
            else
                disp(bhfile);
                load(bhfile);
                %%quickSOCPlot;
                plotBHM_Flight(BHM);
            end
        end
    end
return

% function processDir(dname)
% %     disp(dname)
%     dfiles = dir(dname);
%     if (isempty(dfiles)), return; end
%     N = length(dfiles);
%     for i=1:N
%         isDir(i) = dfiles(i).isdir && ~strcmp(dfiles(i).name,'.') && ~strcmp(dfiles(i).name,'..');
%     end
%     idx = find(isDir);
%     if (~isempty(idx))
%         N = length(idx);
%         for i=idx
%             nname = strcat(dname,filesep,dfiles(i).name);
% %             nname = strcat(dname,'\',dfiles(i).name);
% %             disp(nname)
%             processDir(nname);
%         end
%     end
%     decodePC104AsciiFilesNew(dname);
% return
