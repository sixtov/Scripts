function clss = evalClass(clss)
    clss.roc = getOther(clss.Kgroup, clss.group);
    plot(clss.roc.FPR, clss.roc.TPR,'ko','MarkerFaceColor','r'); hold on
    disp(sprintf('ROC_ACC=%0.3f  ROC_TPR=%0.3f  ROC_FPR=%0.3f',clss.roc.ACC,clss.roc.TPR,clss.roc.FPR))  
return

function roc = getOther(Kgroup,Sgroup)
    idx = find(Kgroup == 'U');
    idx1 = find(Sgroup(idx) == 'U');
    roc.TP = length(idx1);
    roc.FN = length(idx) - roc.TP;

    idx = find(Kgroup == 'D');
    idx1 = find(Sgroup(idx) == 'U');
    roc.FP = length(idx1);
    roc.TN = length(idx) - roc.FP;
    
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
