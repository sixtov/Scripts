function pairUpSignals(S1,sig1,S2,sig2,fitn)
    x = S1.(sig1);
    y = S2.(sig2);
    sig1 = upper(sig1);
    sig2 = upper(sig2);
    
    if isempty(fitn)
        fitn = 'poly1';
        disp('Valid Options for parameter "fitn" include')
        disp('      exp1:exp2')
        disp('    gauss1:gauss8')
        disp('     poly1:poly9')
        disp('    power1:power2')
        disp('     rat01:rat55')
    end
    
    fitm = fit(x,y,fitn);
    %disp(fitm)
    
    dTitle = sprintf('%s vs %s',sig2,sig1);
    slvFigure(dTitle);
    
%     subplot(4,1,1)
%     plot(S1.time,S1.(sig1),'b');grid on
%     vylabel(sig1)
%     vxlabel('time (sec)')
    
    subplot(2,1,1)
    hold off
    plot(S2.time,y,'r');grid on
    hold on
    plot(S1.time,feval(fitm,x),'b')
    vylabel('data (EU)')
    vxlabel('time (sec)')
    vtitle(dTitle)
    lText = [{sig2} {sig1}];
    legend(lText,'Location','Best')
    
    subplot(2,1,2)
    hold off
    plot(x,y,'g.');grid on
    hold on
    plot(fitm,'k')
    vylabel(sig2)
    vxlabel(sig1)
    vtitle(dTitle)
    form = formula(fitm);
    ncoef = numcoeffs(fitm);
    coef = coeffnames(fitm);
    lText = [{'Data'} {strcat('Fit = ',formula(fitm))}];
    for i=1:ncoef
        lText{2} = sprintf('%s\n%s = %f',lText{2},coef{i},fitm.(coef{i}));
    end
    legend(lText,'Location','Best','Color','none','TextColor','b')
    saveas(gcf,dTitle,'fig');
    disp(' ')
    disp(dTitle)
    disp(lText{1})
    disp(lText{2})
return
