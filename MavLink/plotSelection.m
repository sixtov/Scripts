function plotSelection(S,p)
global h;
dline = [{':'} {':'} {':'} {':'} {':'} {':'}];
dcolor = [{'b'} {'r'} {'g'} {'c'} {'m'} {'k'}];
dpoint = [{'.'} {'.'} {'.'} {'.'} {'.'} {'.'}];

    slvFigure(p.figure);
    M = length(p.sel);
    h = zeros(M,1);
    for j=1:M
        h(j)=subplot(p.sel(j).sp(1),p.sel(j).sp(2),p.sel(j).sp(3));
        N = size(p.sel(j).y,1);
        %lText = cell(N,1);
        dtitle = [];
        ploti = 0;
        lText = [];
        for i=1:N
            [xdata subfield dfield cflag] = getData(S,j,i,p);
            if ~isempty(dfield)
                ploti = ploti+1;
                aflag = 0;
                if isfield(p,'append')
                    aflag = p.append;
                end
                if (ploti==1 && ~aflag), hold off; end
                if ~isempty(xdata)
                    plot(xdata,S.(subfield).(dfield),strcat(dline{i},dcolor{i},dpoint{i}))
                else
                    plot(S.(subfield).(dfield),strcat(dline{i},dcolor{i},dpoint{i}))
                end
                if (ploti==1), hold on; end
                if cflag
                    lText{ploti} = validString(p.sel(j).y{i});
                else
                    lText{ploti} = validString(p.sel(j).y);
                end
                if isempty(dtitle)
                    dtitle = dfield;
                else
                    dtitle = strcat(dtitle,' + ',dfield);
                end
            end
        end
        title(validString(dtitle),'FontWeight','bold','FontSize',12)
        if isfield(p.sel(j),'unit')
            ylabel(validString(p.sel(j).unit),'FontWeight','bold','FontSize',8);
        end
        if isfield(p.sel(j),'ylim')
            if ~isempty(p.sel(j).ylim)
                ylim(p.sel(j).ylim);
            end
        end
        if isfield(p.sel(j),'YTick')
            if ~isempty(p.sel(j).YTick)
                set(gca,'YTick',p.sel(j).YTick);
            end
        end
        if isfield(p.sel(j),'YTickLabel')
            if ~isempty(p.sel(j).YTickLabel)
                set(gca,'YTickLabel',p.sel(j).YTickLabel);
            end
        end
        grid on
        legend(lText,'Location','Best');
        
        
        if (isfield(p.sel(j),'hilite') && ~isempty(p.sel(j).hilite))
            for i=1:N
                [xdata subfield dfield cflag] = getData(S,j,i,p);
                if ~isempty(dfield)
                    if ~isempty(xdata)
                        jdx = getStabilizeSections(S,xdata,S.(subfield).(dfield),'sections',p.sel(j).hilite);
                        if ~isempty(jdx)
                            %lcolor = dcolor{i};
                            switch(dcolor{i})
                                case 'b'
                                    acolor = [255 255 0]/255;
                                case 'r'
                                    acolor = [0 255 255]/255;
                                case 'g'
                                    acolor = [255 0 255]/255;
                                case 'c'
                                    acolor = [200 20 20]/255;
                                case 'm'
                                    acolor = [20 200 20]/255;
                                case 'k'
                                    acolor = [200 200 200]/255;
                            end
                            K = size(jdx,1);
                            for k=1:K
                                %plot(xdata(jdx(k,1):jdx(k,2)),S.(subfield).(dfield)(jdx(k,1):jdx(k,2)),'Color',[204 230 202]/255,'LineWidth',7)
                                %plot(xdata(jdx(k,1):jdx(k,2)),S.(subfield).(dfield)(jdx(k,1):jdx(k,2)),'Color',[204 230 0]/255,'LineWidth',7)
                                plot(xdata(jdx(k,1):jdx(k,2)),S.(subfield).(dfield)(jdx(k,1):jdx(k,2)),'Color',acolor,'LineWidth',12)
                                %plot(xdata(jdx(k,1):jdx(k,2)),S.(subfield).(dfield)(jdx(k,1):jdx(k,2)),strcat(dline{i},dcolor{i},dpoint{i}))
                                plot(xdata(jdx(k,1):jdx(k,2)),S.(subfield).(dfield)(jdx(k,1):jdx(k,2)),strcat(':',dcolor{i},'.'))
                            end
                        end
                    end
                end
            end
        end
    end
    if ~isempty(h)
        linkaxes(h,'x')
    else
        delete(gcf);
    end
return


%%
function [xdata subfield dfield cflag] = getData(S,j,i,p)   
            if iscell(p.sel(j).y)
                cflag = 1;
                idx = strfind(p.sel(j).y{i},'.');
            else
                cflag = 0;
                idx = strfind(p.sel(j).y,'.');
            end
            if ~isempty(idx)
                if cflag
                    subfield = p.sel(j).y{i}(1:idx-1);
                    dfield   = p.sel(j).y{i}(idx+1:end);
                else
                    subfield = p.sel(j).y(1:idx-1);
                    dfield   = p.sel(j).y(idx+1:end);
                end
            else
                if cflag
                    subfield = [];
                    dfield   = p.sel(j).y{i};
                else
                    subfield = [];
                    dfield   = p.sel(j).y;
                end
            end
            if ~isempty(dfield)
                if ~isempty(subfield)
                    if isa(S,'tscollection')
                        flag = 1; %exist(strcat('S.',subfield,'.',dfield),'var');
                    else
                        flag = isfield(S.(subfield),dfield);
                    end
                else
                    if isa(S,'tscollection')
                        flag = exist(strcat('S.',dfield),'var');
                    else
                        flag = isfield(S,dfield);
                    end
                end
                if flag
                    if (isfield(p.sel(j),'x') && ~isempty(p.sel(j).x))
                        if (size(p.sel(j).x,1) >= i)
                            if iscell(p.sel(j).x)
                                idx = strfind(p.sel(j).x{i},'.');
                                if ~isempty(idx)
                                    xsub = p.sel(j).x{i}(1:idx-1);
                                    xpos = p.sel(j).x{i}(idx+1:end);
                                else
                                    xsub = [];
                                    xpos = p.sel(j).x{i};
                                end
                            else
                                idx = strfind(p.sel(j).x,'.');
                                if ~isempty(idx)
                                    xsub = p.sel(j).x(1:idx-1);
                                    xpos = p.sel(j).x(idx+1:end);
                                else
                                    xsub = [];
                                    xpos = p.sel(j).x;
                                end
                            end
                            if isempty(xsub)
                                xdata = S.(xpos);
                            else
                                xdata = S.(xsub).(xpos);
                            end
                        else
                            idx = strfind(p.sel(j).x,'.');
                            if ~isempty(idx)
                                xsub = p.sel(j).x(1:idx-1);
                                xpos = p.sel(j).x(idx+1:end);
                            else
                                xsub = [];
                                xpos = p.sel(j).x;
                            end
                            if isempty(xsub)
                                xdata = S.(xpos);
                            else
                                xdata = S.(xsub).(xpos);
                            end
                        end
                    else
                        if ~isempty(subfield)
                            if isa(S,'tscollection')
                                xdata = S.(subfield).time;
                            else
                                if (isfield(S.(subfield),'time'))
                                    xdata = S.(subfield).time;
                                else
                                    xdata = [];
                                end
                            end
                        else
                            if isa(S,'tscollection')
                                xdata = S.time;
                            else
                                if (isfield(S,'time'))
                                    xdata = S.time;
                                else
                                    xdata = [];
                                end
                            end
                        end
                    end
                else
                    dfield = [];
                    xdata = [];
                end
            else
                xdata = [];
            end
return


%%
function [odx] = getStabilizeSections(S,xdata,ydata,type,mode)
    odx = [];
    switch (lower(mode))
        case 'manual'
            flag = ((S.SYS_STATUS.mode==2));
        case 'stabilize'
            flag = ((S.SYS_STATUS.mode==5));
        case 'fbwa'
            flag = ((S.SYS_STATUS.mode==6) & (S.SYS_STATUS.nav_mode==1));
        case 'fbwb'
            flag = ((S.SYS_STATUS.mode==6) & (S.SYS_STATUS.nav_mode==2));
        case 'rtl'
            flag = ((S.SYS_STATUS.mode==4) & (S.SYS_STATUS.nav_mode==5));
        case 'auto'
            flag = ((S.SYS_STATUS.mode==4) & (S.SYS_STATUS.nav_mode==3));
        otherwise
            flag = ((S.SYS_STATUS.mode==-1));
    end
    time = S.SYS_STATUS.time(flag);
    if ~isempty(time)
        dt = diff(time);
        idx = find(dt>5);
        if ~isempty(idx)
            idx = reshape(sort([1; idx; idx+1; length(time)]),2,[])';
        else
            idx = reshape(sort([1; length(time)]),2,[])';
        end
        N = size(idx,1);
        x = [];
        y = [];
        jdx = [];
        rdx = [];
        for i=1:N
            iidx = find(xdata>=time(idx(i,1)) & xdata<=time(idx(i,2)));
            if ~isempty(iidx)
                rdx = [rdx; [iidx(1) iidx(end)]];
            end
            jdx = [jdx; iidx];
            x = [x; xdata(iidx)];
            y = [y; ydata(iidx)];
        end
        switch(type)
            case 'sections'
                odx = rdx;
            otherwise
                odx = jdx;
        end
    end
return
