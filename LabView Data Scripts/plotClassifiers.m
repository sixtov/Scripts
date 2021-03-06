%%
%%%   
    pList = [...
             {'MT_LoadDive_01'} ...
             {'MT_LoadDive_02'} ...
             {'MT_LoadDive_03'} ...
             {'MT_LoadDive_04'} ...
             {'MT_LoadDive_05'} ...
             {'MT_LoadDive_06'} ...
             {'MT_LoadDive_07'} ...
             {'MT_LoadDive_08'} ...
             {'MT_LoadDive_09'} ...
             {'MT_LoadDive_10'} ...
             ];
    LDV = extractParameters(p,pList);
  
    pList = [...
             {'MT_05LoadSine_01'} ...
             {'MT_05LoadSine_02'} ...
             {'MT_10LoadSine_01'} ...
             {'MT_10LoadSine_02'} ...
             {'MT_15LoadSine_01'} ...
             {'MT_15LoadSine_02'} ...
             {'MT_25LoadSine_01'} ...
             {'MT_25LoadSine_02'} ...
             {'MT_50LoadSine_01'} ...
             {'MT_50LoadSine_02'} ...
             {'MT_LoadSine_01'} ...
             {'MT_LoadSine_02'} ...
             {'MT_LoadSine_03'} ...
             {'MT_LoadSine_04'} ...
             {'MT_LoadSine_05'} ...
             {'MT_LoadSine_06'} ...
             {'MT_LoadSine_07'} ...
             {'MT_LoadSine_08'} ...
             {'MT_LoadSine_09'} ...
             {'MT_LoadSine_10'} ...
             ];
    LSN = extractParameters(p,pList);

    pList = [...
             {'MT_NoLoadDive_01'} ...
             {'MT_NoLoadDive_02'} ...
             {'MT_NoLoadDive_03'} ...
             {'MT_NoLoadDive_04'} ...
             {'MT_NoLoadDive_05'} ...
             {'MT_NoLoadDive_06'} ...
             {'MT_NoLoadDive_07'} ...
             {'MT_NoLoadDive_08'} ...
             {'MT_NoLoadDive_09'} ...
             {'MT_NoLoadDive_10'} ...
             ];
    NLDV = extractParameters(p,pList);
   
    pList = [...
             {'MT_NoLoadSine_01'} ...
             {'MT_NoLoadSine_02'} ...
             {'MT_NoLoadSine_03'} ...
             {'MT_NoLoadSine_04'} ...
             {'MT_NoLoadSine_05'} ...
             {'MT_NoLoadSine_06'} ...
             {'MT_NoLoadSine_07'} ...
             {'MT_NoLoadSine_08'} ...
             {'MT_NoLoadSine_09'} ...
             {'MT_NoLoadSine_10'} ...
             {'MT_NoLoadSine_11'} ...
             {'MT_NoLoadSine_12'} ...
             {'MT_NoLoadSine_13'} ...
             {'MT_NoLoadSine_14'} ...
             {'MT_NoLoadSine_15'} ...
             {'MT_NoLoadSine_16'} ...
             {'MT_NoLoadSine_17'} ...
            ];
    NLSN = extractParameters(p,pList);

    pList = [...
             {'MT_05LoadBLWN_01'} ...
             {'MT_05LoadBLWN_02'} ...
             {'MT_10LoadBLWN_01'} ...
             {'MT_10LoadBLWN_02'} ...
             {'MT_15LoadBLWN_01'} ...
             {'MT_15LoadBLWN_02'} ...
             ];
    LWN = extractParameters(p,pList);

    pList = [...
             {'MT_NoLoadBLWN_01'} ...
             {'MT_NoLoadBLWN_02'} ...
             {'MT_NoLoadBLWN_03'} ...
             ];
    NLWN = extractParameters(p,pList);
    
     pList = [...
             {'MT_NoLoad_FastSine_01'} ...
             {'MT_NoLoad_FastSine_02'} ...
             {'MT_NoLoad_FastSine_03'} ...
             ];
    NLFS = extractParameters(p,pList);
   
    pList = [...
             {'MT_NoLoad_SlowSine_01'} ...
             {'MT_NoLoad_SlowSine_02'} ...
             {'MT_NoLoad_SlowSine_03'} ...
             ];
    NLSS = extractParameters(p,pList);
    
    pList = [...
             {'MT_Load530g_FastSine_01'} ...
             {'MT_Load530g_FastSine_02'} ...
             {'MT_Load530g_FastSine_03'} ...
             ];
    LFS = extractParameters(p,pList);
    
    pList = [...
             {'MT_Load530g_SlowSine_01'} ...
             {'MT_Load530g_SlowSine_02'} ...
             {'MT_Load530g_SlowSine_03'} ...
             ];
    LSS = extractParameters(p,pList);

%%% cycle through all combinations of 1D parameters
p1D = [ ...
        {'eRatio'} ...
        {'slope'} ...
        {'lf_c'} ...
        {'lf_w'} ...
        {'lf_a'} ...
        {'lf_freq'} ...
        {'wn1'} ...
        {'wn2'} ...
        {'sae1'} ...%        {'sae2'} ...
        {'pole1_m'} ...
        {'pole2_m'} ...
        {'pole1_a'} ...
        {'pole2_a'} ...
        {'delLim_low'} ...
        {'delLim_hi'} ...
        ];
 %   'delLim'
%%%
% cross the p1D
saveGraphYES = 1;
Np = length(p1D);
q = [];
c = [];
xlist = [];
ylist = [];
cnt = 0;
gColor = ['b'; 'r'];

for i=1:Np
    for j = i+1: Np
        %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
        xl = p1D{i};
        yl = p1D{j};
        [SL SW group] = getClassifierPairs (NLSN, xl, yl, [], [], [],    'U');
        [SL SW group] = getClassifierPairs (NLDV, xl, yl, SL, SW, group, 'U');
        [SL SW group] = getClassifierPairs (NLWN, xl, yl, SL, SW, group, 'U');
        [SL SW group] = getClassifierPairs (NLFS, xl, yl, SL, SW, group, 'U');
        [SL SW group] = getClassifierPairs (NLSS, xl, yl, SL, SW, group, 'U');
        tu = [SL SW]; tuG = group;
        
        [SL SW group] = getClassifierPairs (LSN, xl, yl, [], [], [],    'D');
        [SL SW group] = getClassifierPairs (LDV, xl, yl, SL, SW, group, 'D');
        [SL SW group] = getClassifierPairs (LWN, xl, yl, SL, SW, group, 'D');
        [SL SW group] = getClassifierPairs (LFS, xl, yl, SL, SW, group, 'D');
        [SL SW group] = getClassifierPairs (LSS, xl, yl, SL, SW, group, 'D');
        td = [SL SW]; tdG = group;
        
        SL = [tu(:,1); td(:,1)];
        SW = [tu(:,2); td(:,2)];
        group = [tuG; tdG];
        
        if (mean(SL-SW) ~= 0) 
            cnt = cnt + 1;
            [errq fq coef] = doClassify(cnt, SL, SW, group, gColor, xl, yl,'quadratic', saveGraphYES ); 
            xlist = [xlist; {xl}];
            ylist = [ylist; {yl}];
            q = [q; errq];
            c = [c; coef];
            
            K = coef(1);
            L = coef(2:3)';
            Q = [coef(4) coef(5)/2; coef(5)/2 coef(6)];
            xd = [SL SW];
            N = length(xd);
            y = zeros(N,1);
            for k=1:N
                y(k) = K + xd(k,:)*L + xd(k,:)*Q*xd(k,:)';
            end
%             
%             roc = getROC (td, tdG, tu, tuG, coef);
            %classified as group 1 
            idx = find(y>=0); 
            plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(1)))

            %classified as group 2 
            idx = find(y<0);  
            plot(xd(idx,1),xd(idx,2),sprintf('%c.',gColor(2)))

            troc = getROC (tu, td, coef);
            troc.px = xl;
            troc.py = yl;
            troc.K = K;
            troc.L = L;
            troc.Q = Q;
            
            roc(cnt) = troc;
            dtext = sprintf('%3.3d) ROC_ACC=%0.3f  ROC_PPV=%0.3f  ROC_NPV=%0.3f  classify_PE=%0.3f    (%s vs %s)',cnt,roc(cnt).ACC,roc(cnt).PPV,roc(cnt).NPV,errq,xl,yl);
            disp(dtext)
            dtext = sprintf('ROC     ACC = %0.3f\nROC     PPV = %0.3f\nROC     NPV = %0.3f\nclassify PE = %0.3f',roc(cnt).ACC,roc(cnt).PPV,roc(cnt).NPV,errq);
            text(dot(xlim(),[.5 1-.5]), ...
                 dot(ylim(),[.1 1-.1]), ...
                 dtext, ...
                 'FontSize',16,'Color','k','FontName','Courier','BackgroundColor','w')
            if (saveGraphYES)
                saveas (gcf, sprintf('fig\\Classify_%s_vs_%s.fig',xl, yl));
                close(gcf)
            end
        end
    end
end

%%
set = [               ...
       {'lf_w'}       ...
       {'lf_freq'}    ...
       {'lf_c'}       ...
       {'delLim_low'} ...
      ];
[SET group] = getClassifierSet (NLSN, set,  [],    [], 'U');
[SET group] = getClassifierSet (NLDV, set, SET, group, 'U');
[SET group] = getClassifierSet (NLWN, set, SET, group, 'U');
[SET group] = getClassifierSet (NLFS, set, SET, group, 'U');
[SET group] = getClassifierSet (NLSS, set, SET, group, 'U');
        
[SET group] = getClassifierSet (LSN,  set, SET, group, 'D');
[SET group] = getClassifierSet (LDV,  set, SET, group, 'D');
[SET group] = getClassifierSet (LWN,  set, SET, group, 'D');
[SET group] = getClassifierSet (LFS,  set, SET, group, 'D');
[SET group] = getClassifierSet (LSS,  set, SET, group, 'D');

clss = classifyUsingParams(SET(:,1),SET(:,2),SET(:,3),SET(:,4),group);
clss.Kgroup = group;
clss = evalClass(clss);

% %%
% [sq sidx] = sort(q);
% disp(' ')
% disp('Cases sorted by Prob of Error')
% for i=1:length(q)
%     disp(sprintf('[%0.3f]   %s vs %s'  ...
%     ,q(sidx(i)),xlist{sidx(i)},ylist{sidx(i)}))
% end
% slvFigure ('error compare');
% hold off
% plot(q(sidx),':.')
% legend ('errq');
% grid on
% 
% %% Perform the following set of Classifications
% xlist = [ ...
%         {'slope'} ...
%         {'lf_c'} ...
%         {'delLim_low'} ...
%         {'eRatio'} ...
%         {'wn1'} ...
%         {'lf_w'} ...
%         {'lf_c'} ...
%         ];
% ylist = [ ...
%         {'lf_freq'} ...
%         {'delLim_hi'} ...
%         {'delLim_hi'} ...
%         {'delLim_hi'} ...
%         {'delLim_hi'} ...
%         {'lf_freq'} ...
%         {'pole1_a'} ...
%         ];
% mlist = [ ...
%         {'linear'} ...
%         {'quadratic'} ...
%         {'quadratic'} ...
%         {'quadratic'} ...
%         {'quadratic'} ...
%         {'quadratic'} ...
%         {'quadratic'} ...
%         ];
% saveGraphYES = 1;
% 
% % cross the p1D
% Np = length(xlist);
% q = [];
% c = [];
% cnt = 1;
% for i=1:Np
%     %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
%     xl = xlist{i};
%     yl = ylist{i};
%     method = mlist{i};
%     [SL SW group] = getClassifierPairs (LSN,  xl, yl, [], [],    [], 'D');
%     [SL SW group] = getClassifierPairs (LDV,  xl, yl, SL, SW, group, 'D');
%     [SL SW group] = getClassifierPairs (LWN,  xl, yl, SL, SW, group, 'D');
%     [SL SW group] = getClassifierPairs (LFS,  xl, yl, SL, SW, group, 'D');
%     [SL SW group] = getClassifierPairs (LSS,  xl, yl, SL, SW, group, 'D');
%     [SL SW group] = getClassifierPairs (NLSN, xl, yl, SL, SW, group, 'U');
%     [SL SW group] = getClassifierPairs (NLDV, xl, yl, SL, SW, group, 'U');
%     [SL SW group] = getClassifierPairs (NLWN, xl, yl, SL, SW, group, 'U');
%     [SL SW group] = getClassifierPairs (NLFS, xl, yl, SL, SW, group, 'U');
%     [SL SW group] = getClassifierPairs (NLSS, xl, yl, SL, SW, group, 'U');
%     [errq fq coef] = doClassify(cnt, SL, SW, group, xl, yl,method, saveGraphYES );
%     q = [q; errq];
%     c = [c; coef];
%     cnt = cnt + 1;
%     
%     K = coef(1);
%     L = coef(2:3)';
%     Q = [coef(4) coef(5)/2; coef(5)/2 coef(6)];
%     x = [SL SW];
%     for i=1:length(x)
%         y(i) = K + x(i,:)*L + x(i,:)*Q*x(i,:)';
%     end
%     idx = find(y>=0);
%     plot(x(idx,1),x(idx,2),'b.')
%     idx = find(y<0);
%     plot(x(idx,1),x(idx,2),'r.')
% end
% 
% %%
% %%
% %%
% 
% p2D = [ ...
%         {'wn'} ...
%         {'sae'} ...
%         {'pole'} ...
%         ];
%     
