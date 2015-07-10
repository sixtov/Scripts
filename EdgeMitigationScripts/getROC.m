%get ROC stats for a particular classifier coef given the known good and
%bad cases
function roc = getROC (t1,t2,K,L,Q) 
    roc.K = K;
    roc.L = L;
    roc.Q = Q;
    
    % get stat on group 1
    for k=1:length(t1)
        y(k) = K + t1(k,:)*L + t1(k,:)*Q*t1(k,:)';
    end
    idx = find(y>=0); %positive group 1
    roc.TP = length(idx);
    idx = find(y<0); % negative group 1
    roc.FN = length(idx);    
    
    % get stat on group 2 (Hit & miss criteria reversed from group 1)
    for k=1:length(t2)
        y(k) = K + t2(k,:)*L + t2(k,:)*Q*t2(k,:)';
    end
    idx = find(y>=0); %negative group 2
    roc.FP = length(idx);
    idx = find(y<0); % positive group 2
    roc.TN = length(idx);
    
    roc.P = roc.TP  + roc.FN;
    roc.N = roc.FP  + roc.TN;
    roc.Pp = roc.TP + roc.FP;
    roc.Np = roc.FN + roc.TN;
    roc.TPR = roc.TP/roc.P;
    roc.FPR = roc.FP/roc.N;
    roc.ACC = (roc.TP + roc.TN)/(roc.P + roc.N);
    roc.SPC = roc.TN/roc.N;
    if ((roc.TP + roc.FP)==0)
        roc.PPV = roc.TP;
    else
        roc.PPV = roc.TP/(roc.TP + roc.FP);
    end
    if ((roc.TN + roc.FN)==0)
        roc.NPV = roc.TN;
    else
        roc.NPV = roc.TN/(roc.TN + roc.FN);
    end
    if ((roc.FP + roc.TP)==0)
        roc.FDR = roc.FP;
    else
        roc.FDR = roc.FP/(roc.FP + roc.TP);
    end
    if (sqrt(roc.P*roc.N*roc.Pp*roc.Np)==0)
        roc.MCC = (roc.TP*roc.TN - roc.FP*roc.FN);
    else
        roc.MCC = (roc.TP*roc.TN - roc.FP*roc.FN)/sqrt(roc.P*roc.N*roc.Pp*roc.Np);
    end
    roc.F1 = 2*roc.TP/(roc.P + roc.Pp);
return
