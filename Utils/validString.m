%%
function newTitle = validString(oldTitle)
k1 = findstr('_', oldTitle);
k2 = findstr('\', oldTitle);
k  = sort([k1 k2],'descend');
newTitle = oldTitle;
if ~isempty(k)
    for i=1:length(k)
        K = length(newTitle);
        newTitle = strcat(newTitle(1:k(i)-1),'\',newTitle(k(i):K));
    end
end
%title(newTitle,'FontWeight','bold');
return

%%
% function newTitle = validTitle(oldTitle)
% k = findstr('_', oldTitle);
% newTitle = oldTitle;
% if ~isempty(k)
%     newTitle(k) = ' ';
% end
% return
