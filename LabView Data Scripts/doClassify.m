%%
function [errq fq coef] = doClassify (cnt, SL, SW, group, gColor, xl, yl,method, saveGraph)
    ncolor = [gColor(1) gColor(2)];
    rcolor = [gColor(2) gColor(1)];
    SLrange = [min(SL) max(SL)];
    SWrange = [min(SW) max(SW)];
    range = [SLrange SWrange];

    [X,Y] = meshgrid(linspace(min(SL), max(SL)), linspace(min(SW), max(SW)));
    X = X(:); Y = Y(:);

    % Quadratic separator curve
    [C,errq,P,logp,coeff] = classify([X Y],[SL SW],group,method);
    
    if (strcmp(C(1,:),group(1,:)))
        gcolors = ncolor;
    else
        gcolors = rcolor;
    end

    switch(coeff(1,2).type)
        case 'linear'
            K = coeff(1,2).const;
            L = coeff(1,2).linear; 
            fq = sprintf('0 = %g+%g*x+%g*y',K,L);
            coef = [K; L; 0; 0; 0]';
       case 'quadratic'
            K = coeff(1,2).const;
            L = coeff(1,2).linear; 
            Q = coeff(1,2).quadratic;
            fq = sprintf('0 = %g+%g*x+%g*y+%g*x^2+%g*x.*y+%g*y.^2',K,L,Q(1,1),Q(1,2)+Q(2,1),Q(2,2));
            coef = [K; L; Q(1,1); Q(1,2)+Q(2,1); Q(2,2)]';
        otherwise
            coef = [];
            disp(sprintf('Error %s type is undefined',coeff(1,2).type))
    end
   
    idx = find(xl==':');
    if isempty(idx), idx = 1; end
% bh=slvFigure (sprintf('Blank (%s vs %s)',xl(idx+1:end),yl));
%     hold off
%     gscatter(X,Y,C,gcolors,'.',1,'off');
%     hold on
%     h2 = ezplot(fq,range);
%     set(h2,'Color','m','LineWidth',2)
%     xlabel(xl)
%     ylabel(yl)
%     validTitle(sprintf('(%s vs %s)',xl,yl))
%     saveas (gcf, sprintf('%s\\Blank (%s vs %s).fig',pwd,xl(idx+1:end), yl));
%     close(bh)

slvFigure (sprintf('Classify %s vs %s',xl,yl));
    hold off
    h1 = gscatter(SL,SW,group,ncolor,'v^',10,'off');
    axis square
    set(h1,'LineWidth',2)
    legend(group(1,:),group(end,:), 'Location','Best');
    hold on;
    gscatter(X,Y,C,gcolors,'.',1,'off');
    h2 = ezplot(fq,range);
    set(h2,'Color','m','LineWidth',2)
    xlabel(xl)
    ylabel(yl)
    %validTitle(sprintf('Classification of %s vs %s : Prob Error %0.3f',xl,yl,errq))
    validTitle(sprintf('Classification of (%s vs %s)',xl,yl))
    grid on
    if (saveGraph)
        saveas (gcf, sprintf('fig\\Classify_TrainingSet_%s_vs_%s.fig',xl(idx+1:end), yl));
    %    close(gcf)
    end
    
    %disp (sprintf('%d) Prob of Error[%0.3f] for [%s vs %s]',cnt,errq,xl,yl));
return


% function [errq fq coef] = doClassify (cnt, SL, SW, group, gColor, xl, yl,method, saveGraph)
%     %disp(sprintf('Classifying %s vs %s...', xl, yl))
%     slvFigure (sprintf('Classify %s vs %s',xl,yl));
%     hold off
% 
%     ncolor = [gColor(1) gColor(2)];
%     rcolor = [gColor(2) gColor(1)];
%     h1 = gscatter(SL,SW,group,ncolor,'v^',10,'off');
%     set(h1,'LineWidth',2)
%     legend(group(1,:),group(end,:), 'Location','Best');
%     SLrange = [min(SL) max(SL)];
%     SWrange = [min(SW) max(SW)];
%     range = [SLrange SWrange];
% 
%     [X,Y] = meshgrid(linspace(min(SL), max(SL)), linspace(min(SW), max(SW)));
%     X = X(:); Y = Y(:);
%     % Quadratic separator curve
%     [C,errq,P,logp,coeff] = classify([X Y],[SL SW],group,method);
%     hold on;
%     if (strcmp(C(1,:),group(1,:)))
%         gcolors = ncolor;
%     else
%         gcolors = rcolor;
%     end
%     gscatter(X,Y,C,gcolors,'.',1,'off');
% 
%     switch(coeff(1,2).type)
%         case 'linear'
%             K = coeff(1,2).const;
%             L = coeff(1,2).linear; 
%             fq = sprintf('0 = %g+%g*x+%g*y',K,L);
%             coef = [K; L; 0; 0; 0]';
%        case 'quadratic'
%             K = coeff(1,2).const;
%             L = coeff(1,2).linear; 
%             Q = coeff(1,2).quadratic;
%             fq = sprintf('0 = %g+%g*x+%g*y+%g*x^2+%g*x.*y+%g*y.^2',K,L,Q(1,1),Q(1,2)+Q(2,1),Q(2,2));
%             coef = [K; L; Q(1,1); Q(1,2)+Q(2,1); Q(2,2)]';
%         otherwise
%             coef = [];
%             disp(sprintf('Error %s type is undefined',coeff(1,2).type))
%     end
%     h2 = ezplot(fq,range);
%     set(h2,'Color','m','LineWidth',2)
%    
%     %axis(range)
%     xlabel(xl)
%     ylabel(yl)
%     %validTitle(sprintf('Classification of %s vs %s : Prob Error %0.3f',xl,yl,errq))
%     validTitle(sprintf('Classification of (%s vs %s)',xl,yl))
%     grid on
%     xlm = xlim();
%     ylm = ylim();
% %     text(dot(xlm,[.99 1-.99]),dot(ylm,[.94 1-.94])          ...
% %          ,sprintf('Qfit miss rate [%0.3f]', errq)    ...
% %          ,'FontSize',10,'Color','k','FontName','Courier');
% %     text(dot(xlm,[.99 1-.99]),dot(ylm,[.97 1-.97])          ...
% %         ,sprintf('[%s]', fq)    ...
% %         ,'FontSize',10,'Color','k','FontName','Courier');
%     if (saveGraph)
%         saveas (gcf, sprintf('fig\\Classify_%s_vs_%s.fig',xl, yl));
%     %    close(gcf)
%     end
%     
%     %disp (sprintf('%d) Prob of Error[%0.3f] for [%s vs %s]',cnt,errq,xl,yl));
% return
