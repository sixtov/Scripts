function plotStructure(ptitle,data,exclude)
    lexc = [{'hour'} ...         % and fields with the following names:
            {'min'} ...
            {'sec'} ...
            {'minute'} ...
            {'second'} ...
            {'orderinsec'} ...
            {'msec'} ...
            {'usec'} ...
            {'gtime'} ...
            {'packet'} ...
            {'text'} ...
            {'time'}];
    if ~isempty(exclude)
        lexc = [lexc(:); exclude(:)];
    end
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            plotStructure(sprintf('%s.%s',ptitle,fname),data.(fname),exclude);
        else
            disp(' ');
            disp(ptitle);
            slvFigure(ptitle);
            M = length(names);
            if M>32 % Limit the number of plots
                M = 32;
            end
            jidx = [];
            for j=1:M                                       % Do not plot the following cases
                if ~isempty(data.(names{j})) && ...         % empty data fields
                    isnumeric(data.(names{j})) && ...       % non-numeric data fields
                    length(data.(names{j}))>1 && ...        % non-vector data fields
                    NotInList(names{j},lexc)                % and fields with the following names:
                    jidx = [jidx; j];
                end
            end
            M = length(jidx);
            if M>6
                R = ceil(sqrt(M));
            else
                R = M;
            end
            C = ceil(M/R);
            idx = find(data.time>0);
            h = [];
            for j=1:M
                disp(names{jidx(j)})
                h(j) = subplot(R,C,j);
                if isfield(data,'time')
                    plot(data.time(idx),data.(names{jidx(j)})(idx),':.')
                    vxlabel('time');
                else
                    plot(data.(names{jidx(j)})(idx),':.')
                    vxlabel('index');
                end
                vtitle(validPlotLabel(names{jidx(j)}),'FontWeight','bold','FontSize',12)
                grid on
            end
            if ~isempty(h)
                linkaxes(h,'x')
            else
                delete(gcf)
            end
            return
        end
        pause(3)
    end
return

function bol = NotInList(item,list)
    N = length(list);
    bol = 1;
    for i=1:N
        bol = bol && ~strcmp(item,list{i});
    end
return


% and fields with the following names:
% function plotStructure(name,data)
%     names = fieldnames(data);
%     N = length(names);
%     for i=1:N
%         fname = names{i};
%         if isstruct(data.(fname))
%             slvFigure(sprintf('%s.%s',name,fname));
%             snames = fieldnames(data.(fname));
%             M = length(snames);
%             if M>32
%                 M = 32;
%             end
%             jidx = [];
%             for j=1:M
%                 if ~isempty(data.(fname).(snames{j})) && ...
%                     isnumeric(data.(fname).(snames{j})) && ...
%                     length(data.(fname).(snames{j}))>1 && ...
%                     ~strcmp(snames{j},'hour') && ...
%                     ~strcmp(snames{j},'min') && ...
%                     ~strcmp(snames{j},'sec') && ...
%                     ~strcmp(snames{j},'minute') && ...
%                     ~strcmp(snames{j},'second') && ...
%                     ~strcmp(snames{j},'orderinsec') && ...
%                     ~strcmp(snames{j},'time')
%                     jidx = [jidx; j];
%                 end
%             end
%             M = length(jidx);
%             R = ceil(sqrt(M));
%             C = ceil(M/R);
%             idx = find(data.(fname).time>0);
%             for j=1:M
%                 disp(snames{jidx(j)})
%                 h(j) = subplot(R,C,j);
%                 plot(data.(fname).time(idx),data.(fname).(snames{jidx(j)})(idx))
%                 xlabel(snames{jidx(j)})
%                 grid on
%             end
%             linkaxes(h,'x')
%         end
%         pause(3)
%     end
% return
