%%
function sroc = evalParameters()
    tdata = getClassifyTrainingData();

    saveGraphYES = 1;
    q = [];
    c = [];
    xlist = [];
    xlistSN = [];
    xlistDV = [];
    xlistWN = [];
    xlistFS = [];
    xlistSS = [];
    ylist = [];
    ylistSN = [];
    ylistDV = [];
    ylistWN = [];
    ylistFS = [];
    ylistSS = [];
    gColor = ['b'; 'r'];
    acc = [];
    tpr = [];
    fpr = [];

    roc = [];
    rocSN = [];
    rocDV = [];
    rocWN = [];
    rocFS = [];
    rocSS = [];
    
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...
%             {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...
%             {'pole1_a'}; ...
%             {'pole2_a'}; ...
%             {'delLim_low'}; ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLSN, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LSN,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocSN xlistSN ylistSN] = xxx('SN',rocSN,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistSN,ylistSN,'quadratic',0,0);
%             
%             [SL SW group] = getClassifierPairs (tdata.NLDV, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LDV,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocDV xlistDV ylistDV] = xxx('DV',rocDV,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistDV,ylistDV,'quadratic',0,0);
%             
%             [SL SW group] = getClassifierPairs (tdata.NLWN, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LWN,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocWN xlistWN ylistWN] = xxx('WN',rocWN,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistWN,ylistWN,'quadratic',0,0);
%             
%             [SL SW group] = getClassifierPairs (tdata.NLFS, xl, yl, [], [], [],    'U');
%              tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LFS,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocFS xlistFS ylistFS] = xxx('FS',rocFS,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistFS,ylistFS,'quadratic',0,0);
%             
%             [SL SW group] = getClassifierPairs (tdata.NLSS, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LSS,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocSS xlistSS ylistSS] = xxx('SS',rocSS,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistSS,ylistSS,'quadratic',0,0);
%         end
%     end
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...
%             {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...
%             {'pole1_a'}; ...
%             {'pole2_a'}; ...
%             {'delLim_low'}; ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLSN, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LSN,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocSN xlistSN ylistSN] = xxx('SN',rocSN,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistSN,ylistSN,'quadratic',0,0);
%         end
%     end
%     si = showTop5(rocSN);
    
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...%            {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...%            {'pole1_a'}; ...%            {'pole2_a'}; ...
%             {'delLim_low'}; ...%            {'delLim_hi'} ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLDV, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LDV,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocDV xlistDV ylistDV] = xxx('DV',rocDV,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistDV,ylistDV,'quadratic',0,0);
%         end
%     end
%     si = showTop5(rocDV);
    
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...%            {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...%            {'pole1_a'}; ...%            {'pole2_a'}; ...
%             {'delLim_low'}; ...
%             {'delLim_hi'} ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLWN, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LWN,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocWN xlistWN ylistWN] = xxx('WN',rocWN,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistWN,ylistWN,'quadratic',0,0);
%         end
%     end
%     si = showTop5(rocWN);
    
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...
%             {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...
%             {'pole1_a'}; ...%            {'pole2_a'}; ...
%             {'delLim_low'}; ...%            {'delLim_hi'} ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLFS, xl, yl, [], [], [],    'U');
%              tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LFS,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocFS xlistFS ylistFS] = xxx('FS',rocFS,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistFS,ylistFS,'quadratic',0,0);
%         end
%     end
%     si = showTop5(rocFS);
    
%%
%     %%% cycle through all combinations of 1D parameters
%     p1D = [ ...
%             {'eRatio'}; ...
%             {'slope'}; ...
%             {'lf_c'}; ...
%             {'lf_w'}; ...
%             {'lf_a'}; ...
%             {'lf_freq'}; ...
%             {'wn1'}; ...
%             {'wn2'}; ...
%             {'sae1'}; ...
%             {'pole1_m'}; ...
%             {'pole2_m'}; ...
%             {'pole1_a'}; ...%            {'pole2_a'}; ...
%             {'delLim_low'}; ...%            {'delLim_hi'} ...
%             ];
%     Np = length(p1D);
%     cnt = 0;
%     for i=1:Np
%         for j = i+1: Np
%             cnt = cnt + 1;
%             %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%             xl = p1D{i};
%             yl = p1D{j};
%             
%             [SL SW group] = getClassifierPairs (tdata.NLSS, xl, yl, [], [], [],    'U');
%             tu = [SL SW]; tuG = group; % Used by ROC
% 
%             [SL SW group] = getClassifierPairs (tdata.LSS,  xl, yl, [], [], [],    'D');
%             td = [SL SW]; tdG = group; % Used by ROC
% 
%             SL = [tu(:,1); td(:,1)];
%             SW = [tu(:,2); td(:,2)];
%             group = [tuG; tdG];
%             [rocSS xlistSS ylistSS] = xxx('SS',rocSS,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlistSS,ylistSS,'quadratic',0,0);
%         end
%     end
%     si = showTop5(rocSS);
    
%%
    %%% cycle through all combinations of 1D parameters
    p1D = [ ...
            {'eRatio'}; ...
            {'slope'}; ...
            {'lf_c'}; ...
            {'lf_w'}; ...
            {'lf_a'}; ...
            {'lf_freq'}; ...
            {'wn1'}; ...
            {'wn2'}; ...
            {'sae1'}; ...
            {'pole1_m'}; ...
            {'pole2_m'}; ...
            {'pole1_a'}; ...
            {'pole2_a'}; ...
            {'delLim_low'}; ...
            {'delLim_hi'} ...
            ];
    Np = length(p1D);
    cnt = 0;
    for i=1:Np
        for j = i+1: Np
            cnt = cnt + 1;
            %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
            xl = p1D{i};
            yl = p1D{j};
            
            [SL SW group] = getClassifierPairs (tdata.NLSN, xl, yl, [], [], [],    'U');
            [SL SW group] = getClassifierPairs (tdata.NLDV, xl, yl, SL, SW, group, 'U');
            [SL SW group] = getClassifierPairs (tdata.NLWN, xl, yl, SL, SW, group, 'U');
            [SL SW group] = getClassifierPairs (tdata.NLFS, xl, yl, SL, SW, group, 'U');
            [SL SW group] = getClassifierPairs (tdata.NLSS, xl, yl, SL, SW, group, 'U');
            tu = [SL SW]; tuG = group; % Used by ROC

            [SL SW group] = getClassifierPairs (tdata.LSN,  xl, yl, [], [], [],    'D');
            [SL SW group] = getClassifierPairs (tdata.LDV,  xl, yl, SL, SW, group, 'D');
            [SL SW group] = getClassifierPairs (tdata.LWN,  xl, yl, SL, SW, group, 'D');
            [SL SW group] = getClassifierPairs (tdata.LFS,  xl, yl, SL, SW, group, 'D');
            [SL SW group] = getClassifierPairs (tdata.LSS,  xl, yl, SL, SW, group, 'D');
            td = [SL SW]; tdG = group; % Used by ROC

            SL = [tu(:,1); td(:,1)];
            SW = [tu(:,2); td(:,2)];
            group = [tuG; tdG];
            [roc xlist ylist]       = xxx('ALL',roc  ,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlist   ,ylist ,'quadratic',1,0);
        end
    end

    si = showTop5(roc);
    sroc.Top5 = si(1:5);
    sroc.data = roc;
    sroc.si = si;

    disp(' ')
    disp('%% --------------------------------')
    disp('%% Call printClassifierCoef(si,roc.data)')
    disp('%% --------------------------------')
    disp('     where {si       is an array of selected ROC indexes}')
    disp('     and   {roc.data is an array of ROC data}')
    disp(' ')
    disp('suggested:')
    disp(' ')
    disp(sprintf('printClassifierCoef([%d %d %d],roc.data);',si(1:3)))
    disp(' ')
return


function [roc xlist ylist] = xxx(dCase,roc,cnt,SL,SW,group,tu,td,gColor,xl,yl,xlist,ylist,method, saveGraphYES,deleteGraph )
            acc = [];
            tpr = [];
            fpr = [];
            if (mean(SL-SW) ~= 0) 
                %[errq fq coef] = doClassify(cnt, SL, SW, group, gColor, xl, yl,'quadratic', saveGraphYES ); 
                [errq fq coef] = doClassify(cnt, SL, SW, group, gColor, sprintf('%s: %s',dCase,xl), yl,method, saveGraphYES ); 
                xlist = [xlist; {xl}];
                ylist = [ylist; {yl}];
                %q = [q; errq];
                %c = [c; coef];

                K = coef(1);
                L = coef(2:3)';
                Q = [coef(4) coef(5)/2; coef(5)/2 coef(6)];
                xd = [SL SW];
                N = length(xd);
                y = zeros(N,1);
                for k=1:N
                    y(k) = K + xd(k,:)*L + xd(k,:)*Q*xd(k,:)';
                end

%                 validTitle(sprintf('%s Classification of (%s vs %s)',dCase,xl,yl));
%                 
%                 %classified as group 1
%                 idx = find(y>=0); 
%                 plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(1)))
% 
%                 %classified as group 2 
%                 idx = find(y<0);  
%                 plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(2)))

                troc = getROC (tu, td, coef);

%                 h=gcf;
                hp=slvFigure('Parameter ROC');
                if cnt==1, hold off; plot([0 1],[0 1],':r'); hold on; end
                if cnt==1, xlim([0 1]); ylim([0 1]); xlabel('FPR'); ylabel('TPR'); end
                if cnt==1
                    %% plot circles
                    r = 0.1:0.1:0.7;
                    theta = linspace(-pi/2,0);
                    Nr = length(r);
                    for k=1:Nr
                        plot(complex(r(k)*cos(theta),1+r(k)*sin(theta)),':k')
                    end
                    validTitle('Classification Parameter ROC Results')
                end
                plot(troc.FPR, troc.TPR,'ko','MarkerFaceColor','b'); hold on
%                 figure(h);

                acc = [acc; troc.ACC];
                tpr = [tpr; troc.TPR];
                fpr = [fpr; troc.FPR];
                troc.px = xl;
                troc.py = yl;
                troc.K = K;
                troc.L = L;
                troc.Q = Q;
                troc.xrange = [min(SL); max(SL)];
                troc.yrange = [min(SW); max(SW)];

                if isempty(roc), roc = troc; else roc(cnt) = troc; end
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s)',cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,xl,yl);
                disp(dtext)
                dtext = sprintf('ROC     ACC = %0.3f\nROC     TPR = %0.3f\nROC     FPR = %0.3f\nclassify PE = %0.3f',roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq);
%                 text(dot(xlim(),[.5 1-.5]), ...
%                      dot(ylim(),[.1 1-.1]), ...
%                      dtext, ...
%                      'FontSize',16,'Color','k','FontName','Courier','BackgroundColor','w')
%                 if (saveGraphYES)
%                     saveas (gcf, sprintf('fig\\Classify_%s_vs_%s.fig',xl, yl));
%                 end
%                 if (deleteGraph)
%                     close(gcf)
%                 else
%                     figure(hp);
%                 end
            else
                disp(sprintf('Skipped (%s vs %s) Classification',xl,yl))
                roc(cnt) = roc(cnt-1);
            end
return

function si = showTop5(roc)
    dx = 0.1;
    dy = 0.05;
    ap = get(gca,'Position');
    nx = ap(1)+[0 ap(3)];
    ny = ap(2)+[0 ap(4)];
    xl = xlim();
    yl = ylim();
    px = polyfit(xl,nx,1);
    py = polyfit(yl,ny,1);
    N = length(roc);
    tpr = [];
    fpr = [];
    for i=1:N
        tpr = [tpr; roc(i).TPR];
        fpr = [fpr; roc(i).FPR];
    end
    dis = sqrt((fpr).^2+(1-tpr).^2);
    [sv si] = sort(dis);
    top = roc(si(1:3));
    junk = [top(1).TPR; top(2).TPR; top(3).TPR];
    [av ai] = sort(junk);
    top = top(ai);
    disp(' ')
    disp('Top 3 Results')
    for i=1:3
        dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s)',si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).px,roc(si(i)).py);
        disp(dtext)
        x1 = top(i).FPR;
        y1 = top(i).TPR;
        x2 = x1+dx;
        switch(i)
            case 1
                y2 = y1-dy;
            case 2
                y2 = y1+0;
            case 3
                y2 = y1+dy;
        end
        annotation('arrow',polyval(px,[x2 x1]),polyval(py,[y2 y1]));
        plot(x1,y1,'ko','MarkerFaceColor','g'); hold on
        text(x2,y2,validString(sprintf(' ( %s vs. %s )',top(i).px,top(i).py)),'BackgroundColor','w','FontWeight','bold');
    end
    saveas(gcf,'ROC Results.fig')
return
