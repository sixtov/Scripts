%get ROC stats for a particular classifier coef given the known good and
%bad cases
function [roc] = getROC (t1, t2, coef) 

    % setup coefficients
    K = coef(1);
    L = coef(2:3)';
    Q = [coef(4) coef(5)/2; coef(5)/2 coef(6)];

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
    roc.PPV = roc.TP/(roc.TP + roc.FP);
    roc.NPV = roc.TN/(roc.TN + roc.FN);
    roc.FDR = roc.FP/(roc.FP + roc.TP);
    roc.MCC = (roc.TP*roc.TN - roc.FP*roc.FN)/sqrt(roc.P*roc.N*roc.Pp*roc.Np);
    roc.F1 = 2*roc.TP/(roc.P + roc.Pp);
return
