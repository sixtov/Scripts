%%
function sroc = evalParameterSet()
    tdata = getClassifyTrainingData();

    plist = [];
    gColor = ['b'; 'r'];
    roc = [];
    
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
            {'sae1'}; ...%            {'sae2'}; ...%            {'pole1_m'}; ...%            {'pole2_m'}; ...
            {'pole1_a'}; ...
            {'pole2_a'}; ...
            {'delLim_low'}; ...
            {'delLim_hi'} ...
            ];
    Np = length(p1D);
    cnt = 0;
    for i=1:Np
    for ii = i+1: Np
    for iii = ii+1: Np
    for iv = iii+1: Np
    %for v = iv+1: Np
    %for vi = v+1: Np
            pidx = [i ii iii iv];
            upidx = unique(pidx);
        if length(pidx) == length(upidx)
            cnt = cnt + 1;
            %disp(sprintf('Testing %s vs %s]',p1D{i}, p1D{j}));
            %set = p1D([i ii]);
            %set = p1D([i ii iii]);
            set = p1D([i ii iii iv]);
            %set = p1D([i ii iii iv v]);
            %set = p1D([i ii iii iv v vi]);
            
            [uSET uGroup] = getClassifierSet (tdata.NLSN, set,  [],    [], 'U');
            [uSET uGroup] = getClassifierSet (tdata.NLDV, set, uSET, uGroup, 'U');
            [uSET uGroup] = getClassifierSet (tdata.NLWN, set, uSET, uGroup, 'U');
            [uSET uGroup] = getClassifierSet (tdata.NLFS, set, uSET, uGroup, 'U');
            [uSET uGroup] = getClassifierSet (tdata.NLSS, set, uSET, uGroup, 'U');
 
            [dSET dGroup] = getClassifierSet (tdata.LSN,  set,  [],    [], 'D');
            [dSET dGroup] = getClassifierSet (tdata.LDV,  set, dSET, dGroup, 'D');
            [dSET dGroup] = getClassifierSet (tdata.LWN,  set, dSET, dGroup, 'D');
            [dSET dGroup] = getClassifierSet (tdata.LFS,  set, dSET, dGroup, 'D');
            [dSET dGroup] = getClassifierSet (tdata.LSS,  set, dSET, dGroup, 'D');

            SET = [uSET; dSET];
            Group = [uGroup; dGroup];
            [roc plist] = xxx('ALL',roc,cnt,SET,Group,uSET,dSET,gColor,set,plist,'quadratic',1,0);
        end
    %end
    %end
    end
    end
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


function [roc plist] = xxx(dCase,roc,cnt,SET,Group,uSET,dSET,gColor,set,plist,method,saveGraphYES,deleteGraph)
    acc = [];
    tpr = [];
    fpr = [];
    xd = SET;
    N = size(SET,2);
    flag = 0;
    for i=1:N-1
        for j=i+1:N
            flag = flag || mean(SET(:,i)-SET(:,j))~=0;
        end
    end
    if (flag) 
        [C,errq,P,logp,coeff] = classify(zeros(1,size(SET,2)),SET,Group,method);
        plist = [plist; set];

        K = coeff(1,2).const;
        L = coeff(1,2).linear;
        Q = coeff(1,2).quadratic;
        N = length(xd);
        y = zeros(N,1);
        for k=1:N
            y(k) = K + xd(k,:)*L + xd(k,:)*Q*xd(k,:)';
        end

        troc = getROC (uSET, dSET, K,L,Q);

        slvFigure('Parameter ROC');
        if cnt==1, hold off; plot([0 1],[0 1],':r'); hold on; end
        if cnt==1, xlim([0 .2]); ylim([.8 1]); xlabel('FPR'); ylabel('TPR'); end
        if cnt==1
            %% plot circles
            r = 0.02:0.02:0.5;
            theta = linspace(-pi/2,0);
            Nr = length(r);
            for k=1:Nr
                plot(complex(r(k)*cos(theta),1+r(k)*sin(theta)),':k')
            end
        end
        plot(troc.FPR, troc.TPR,'ko','MarkerFaceColor','b'); hold on

        acc = [acc; troc.ACC];
        tpr = [tpr; troc.TPR];
        fpr = [fpr; troc.FPR];
        troc.set = set;
        troc.K = K;
        troc.L = L;
        troc.Q = Q;
        troc.range = [min(SET); max(SET)];

        if isempty(roc), roc = troc; else roc(cnt) = troc; end
        N = length(set);
        switch N
            case 2
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s)'                        ,cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,set{1:end});
            case 3
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s vs %s)'                  ,cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,set{1:end});
            case 4
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s vs %s vs %s)'            ,cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,set{1:end});
            case 5
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s vs %s vs %s vs %s)'      ,cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,set{1:end});
            case 6
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  PE=%0.3f    (%s vs %s vs %s vs %s vs %s vs %s)',cnt,roc(cnt).ACC,roc(cnt).TPR,roc(cnt).FPR,errq,set{1:end});
            otherwise
                dtext = 'ERROR';
        end
        disp(dtext)
    else
        disp(sprintf('Skipped (%s vs %s) Classification',set{1:end}))
        %if cnt>0, roc(cnt) = roc(cnt-1); end
    end
return

function si = showTop5(roc)
    N = length(roc);
    tpr = [];
    fpr = [];
    for i=1:N
        tpr = [tpr; roc(i).TPR];
        fpr = [fpr; roc(i).FPR];
    end
    dis = sqrt((fpr).^2+(1-tpr).^2);
    [sv si] = sort(dis);
    disp(' ')
    disp('Top 5 Results')
    for i=1:5
        N = length(roc(si(i)).set);
        switch N
            case 2
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s)'                        ,si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).set{1:end});
            case 3
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s vs %s)'                  ,si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).set{1:end});
            case 4
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s vs %s vs %s)'            ,si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).set{1:end});
            case 5
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s vs %s vs %s vs %s)'      ,si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).set{1:end});
            case 6
                dtext = sprintf('%3.3d) ACC=%0.3f  TPR=%0.3f  FPR=%0.3f  (%s vs %s vs %s vs %s vs %s vs %s)',si(i),roc(si(i)).ACC,roc(si(i)).TPR,roc(si(i)).FPR,roc(si(i)).set{1:end});
            otherwise
                dtext = 'ERROR';
        end
        disp(dtext)
        plot(roc(si(i)).FPR, roc(si(i)).TPR,'ko','MarkerFaceColor','g'); hold on
    end
return
