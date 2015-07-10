function plotStructure_Detail(ptitle,data)
    names = fieldnames(data);
    N = length(names);
    for i=1:N
        fname = names{i};
        if isstruct(data.(fname))
            plotStructure_Detail(sprintf('%s.%s',ptitle,fname),data.(fname));
        else
            M = length(names);
            jidx = [];
            for j=1:M                                       % Do not plot the following cases
                if ((~isempty(data.(names{j})))  && ...     % empty data fields
                    (isnumeric(data.(names{j}))) && ...     % non-numeric data fields
                    (length(data.(names{j}))>1 ))           % non-vector data fields
                    jidx = [jidx; j];
                end
            end
            if ~isempty(jidx)
                idx = find(data.time>0);
                time_off = data.time(idx(1));
                disp(sprintf('Time offset = %f',time_off))
                M = length(jidx);
                for j=1:M
                    vname = names{jidx(j)};
                    pname = sprintf('%s.%s',ptitle,vname);
                    slvFigure(pname);
                    h(j) = subplot(1,1,1);
%                     if isfield(data,'time')
%                         plot(data.time(idx)-time_off,data.(names{jidx(j)})(idx),':.')
%                     else
                        plot(data.time-time_off,data.(vname),':.')
%                     end
                    ylabel(validPlotLabel(vname))
                    legend(pname)
                    grid on
                    pause(0.1)
                end
                linkaxes(h,'x')
                return
            end
            
        end
        pause(1)
    end
return
