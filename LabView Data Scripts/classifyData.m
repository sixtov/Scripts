function clss = classifyData(pair1, pair2, pair3, varargin)
    px1 = pair1(:,1);
    py1 = pair1(:,2);
    px2 = pair2(:,1);
    py2 = pair2(:,2);
    px3 = pair3(:,1);
    py3 = pair3(:,2);
    if nargin>3
        var1 = varargin{1};
        var2 = varargin{2};
        ccase = strcat(var1,'.vs.',var2);
        switch(ccase)
            case 'strain.vs.cgaz'
                clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
%             case 'strain.vs.obaz'
%                 clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
%             case 'strain.vs.ctaz'
%                 clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
%             case 'acc_ib.vs.acc_ob'
%                 clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
%             case 'acc_ib.vs.acc_ct'
%                 clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
%             case 'acc_ct.vs.acc_ob'
%                 clss = classifyUsingParams( px1, py1, px2, py2, px3, py3, [], [] );
            otherwise
                disp(sprintf('''%s'' case not implemented',ccase))
        end
        if nargin == 6
            if ischar(varargin{3})
                switch(varargin{3})
                    case 'plot'
                        %% Using roc(41)  (lf_w vs lf_freq)
                        %% Using roc(36)  (lf_c vs pole1_a)
                        %% Using roc(16)  (slope vs lf_w)
                        if clss.dFlag, cp = 'r'; else cp = 'b'; end
                        MS = 8;
                        
                        fname1 = 'Blank ( lf_w vs lf_freq)';
                        if ~slvFigureExists(fname1)
                            if open(sprintf('..\\%s.fig',fname1)); end
                            hold on
                        else
                            slvFigure(fname1);
                        end
                        plot(px1,py1,'ko','MarkerSize',MS,'MarkerEdgeColor',cp)

                        fname2 = 'Blank ( lf_c vs pole1_a)';
                        if ~slvFigureExists(fname2)
                            if open(sprintf('..\\%s.fig',fname2)); end
                            hold on
                        else
                            slvFigure(fname2);
                        end
                        plot(px2,py2,'ko','MarkerSize',MS,'MarkerEdgeColor',cp)
                        
                        fname3 = 'Blank ( slope vs lf_w)';
                        if ~slvFigureExists(fname3)
                            if open(sprintf('..\\%s.fig',fname3)); end
                            hold on
                        else
                            slvFigure(fname3);
                        end
                        plot(px3,py3,'ko','MarkerSize',MS,'MarkerEdgeColor',cp)
                end
            end
        end
    else
        disp('Warning: Parameter List has changed.\nPlease check function to see new parameter list')
    end
return
