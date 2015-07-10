%%
function findPC104AsciiFilesAndDecode()
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
    disp('Done!')
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
    decodePC104AsciiFilesNew(dname);
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
