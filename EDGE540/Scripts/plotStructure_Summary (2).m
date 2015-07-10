function plotStructure_Summary(ptitle,data)
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            plotStructure_Summary(sprintf('%s.%s',ptitle,fname),data.(fname));
        else
            M = length(names);
            if M>36 % Limit the number of plots
                M = 36;
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
                    ~strcmp(names{j},'orderinsec')
                    jidx = [jidx; j];
                end
            end
            if ~isempty(jidx)
                idx = find(data.time>0);
                time_off = data.time(idx(1));
                disp(sprintf('Time offset = %f',time_off))
                M = length(jidx);
                if M>6
                    R = ceil(sqrt(M));
                else
                    R = M;
                end
                C = ceil(M/R);
                slvFigure(ptitle);
                for j=1:M
                    %disp(names{jidx(j)})
                    vname = names{jidx(j)};
                    h(j) = subplot(R,C,j);
                    plot(data.(vname),':.')
                    ylabel(validPlotLabel(vname))
                    grid on
                    pause(0.5)
                end
                linkaxes(h,'x')
                return
            end
        end
    end
return
