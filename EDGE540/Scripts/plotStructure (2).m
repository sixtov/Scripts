function plotStructure(ptitle,data)
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            plotStructure(sprintf('%s.%s',ptitle,fname),data.(fname));
        else
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
                    ~strcmp(names{j},'hour') && ...         % and fields with the following names:
                    ~strcmp(names{j},'min') && ...
                    ~strcmp(names{j},'sec') && ...
                    ~strcmp(names{j},'minute') && ...
                    ~strcmp(names{j},'second') && ...
                    ~strcmp(names{j},'orderinsec') && ...
                    ~strcmp(names{j},'time')
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
            for j=1:M
                disp(names{jidx(j)})
                h(j) = subplot(R,C,j);
                if isfield(data,'time')
                    plot(data.time(idx),data.(names{jidx(j)})(idx),':.')
                else
                    plot(data.(names{jidx(j)})(idx),':.')
                end
                xlabel(validPlotLabel(names{jidx(j)}))
                grid on
            end
            linkaxes(h,'x')
            return
        end
        pause(3)
    end
return

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
