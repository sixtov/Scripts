%%%% File to check signal integrity
%function [test fLim delLim damageInd] = getTwoTailedParameters(dCase, base, test, hFlag, saveFlag)
function [test] = getTwoTailedParameters(dCase, base, test, hFlag, saveFlag)

    % Form the F distribution for fault detection
    F = base.sHat ./ test.sHat;
    fLim = [min(F); max(F)];
    
    slvFigure(sprintf('%s - getTwoTailedParameters:PSD %s',dCase, test.sigName{1}));
    subplot(2,2,1)
    if hFlag, hold on; else hold off; end
    plot( base.Fs * base.Wu / pi, F, ':b.')
    hold on
    grid on
    xlabel('freq (Hz)')
    ylabel('F function');

    twoK = 2*base.K;         %Plot a F distribution for comparison
    xF = (0:0.0001:3)';
    yF = fpdf(xF,twoK,twoK);    %xF = 0.05:0.1:2.95; %Bins for the histogram
    yF = yF/sum(yF);        % Normalize pdf so area equals 1
    P = finv([0.0005 0.9995],twoK,twoK);
    xtick = unique(sort([0 3 P]));
    
    x = (0.05:0.1:2.95)'; %Bins for the histogram
    NB = hist(F,x)';   %Plot the histogram
    % Normalize pdf so area equals 1
    NB = (length(x)/length(xF))*NB/sum(NB);
    
    ty = fpdf(x,twoK,twoK);
    ty = (length(x)/length(xF))*ty/sum(ty);
    ty = 1e4*(NB-ty);
    
    subplot(2,4,5)
    idx = find(x<=P(1));
    area(x(idx),ty(idx),'FaceColor','r')
    set(gca,'Xtick',xtick);
    xlim([0 P(1)])
    yl1 = ylim();
    grid on
    
    subplot(2,4,6)
    idx = find(x>=P(2));
    area(x(idx),ty(idx),'FaceColor','r')
    set(gca,'Xtick',xtick);
    xlim([P(2) 3])
    yl2 = ylim();
    yl = [min([yl1(1) yl2(1)]) max([yl1(2) yl2(2)])];
    ylim(yl)
    grid on
    subplot(2,4,5)
    ylim(yl)
    
    subplot(1,2,2)
    if hFlag, hold on; else hold off; end
    area(x, 1e4*NB,'LineWidth',2,'FaceColor','r')
    hold on
    area( xF, 1e4*yF,'LineWidth',2,'FaceColor',0.8*[1 1 1])
    if ~hFlag, ylim(1.5*ylim()); end
    
    %Perform the two tail test
    %P = finv([0.0005 0.9995],twoK,twoK);
    gLim = [min(P); max(P)];
    delLim = [  fLim(1) - gLim(1); ...
                gLim(2) - fLim(2)];
    if (min(delLim) < 0 )
        damageInd = 1;
        state = 'Damaged';
    else
        damageInd = 0;
        state = 'Undamaged';
    end
    
%     yl = 0.1*max(ylim());
%     plot(P,[yl yl],'m*', 'MarkerSize',10)
    
    set(gca,'Xtick',xtick);
    xlim([0 3])

    xl = xlim();
    yl = ylim();
    set(gca,'Ytick',yl);
    grid on
    
    FS = 10;
    text(dot(xl,[.80 1-.80]),dot(yl,[.05 1-.05]),sprintf('fLim       [%0.3f  %0.3f]', fLim(1), fLim(2))          ,'FontSize',FS,'Color','b','FontName','Courier')
    text(dot(xl,[.80 1-.80]),dot(yl,[.10 1-.10]),sprintf('base fLim  [%0.3f  %0.3f]', base.fLim(1), base.fLim(2)),'FontSize',FS,'Color','b','FontName','Courier')
    text(dot(xl,[.80 1-.80]),dot(yl,[.15 1-.15]),sprintf('gLim       [%0.3f  %0.3f]', gLim(1), gLim(2))          ,'FontSize',FS,'Color','b','FontName','Courier')
    text(dot(xl,[.80 1-.80]),dot(yl,[.20 1-.20]),sprintf('State [%s]', state)                                    ,'FontSize',FS,'Color','b','FontName','Courier')
    text(dot(xl,[.80 1-.80]),dot(yl,[.25 1-.25]),sprintf('base [%s]',base.dCase)                                 ,'FontSize',FS,'Color','b','FontName','Courier')
    
    test.F = F;
    test.fLim = fLim;
    test.gLim = gLim;
    test.delLim = delLim;
    test.damageInd = damageInd;
    test.basedCase = base.dCase;
    
    if (saveFlag)
        base = test;
        save (sprintf('%s_baseSD_%s',dCase, test.sigName{1}), 'base');
    end
    
    saveas (gcf, sprintf('fig\\%s_%s_PSD.fig',dCase, test.sigName{1}));
    close(gcf)
    
return
