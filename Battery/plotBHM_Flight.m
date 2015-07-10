function plotBHM_Flight(BHM)
    slvFigure(BHM.dfile);
    h=plotULA(BHM);
    h=[h plotURA(BHM)];
    h=[h plotLLF(BHM)];
    h=[h plotLRF(BHM)];
    linkaxes(h,'x');
    saveas(gcf,sprintf('%s_BHM.fig',BHM.dfile(1:end-4)));
return

function h=plotULA(BHM)
    BAT=BHM.ULA20;
    subplot(8,2,1)
    h=plotVoltageCurrent('ULA',BAT.t,BAT.V,BAT.I,BHM.timeS,BHM.timeE);
    [xticks xtickCL]=setupTicks(BHM.timeS,BHM.timeE);
    set(h(1),'XTick',xticks);
    set(h(1),'XTickLabel',xtickCL);
    set(h(2),'XTick',xticks);
    set(h(2),'XTickLabel',xtickCL);

    h=[h subplot(8,2,3)];
    plotEOD('ULA',BAT.t_p,BAT.EOD,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,5)];
    plotRUL('ULA',BAT.t_p,BAT.RUL,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,7)];
    plotSOC('ULA',BAT.t_p,BAT.SOC,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);
return

function h=plotURA(BHM)
    BAT=BHM.URA40;
    subplot(8,2,2)
    h=plotVoltageCurrent('URA',BAT.t,BAT.V,BAT.I,BHM.timeS,BHM.timeE);
    [xticks xtickCL]=setupTicks(BHM.timeS,BHM.timeE);
    set(h(1),'XTick',xticks);
    set(h(1),'XTickLabel',xtickCL);
    set(h(2),'XTick',xticks);
    set(h(2),'XTickLabel',xtickCL);

    h=[h subplot(8,2,4)];
    plotEOD('URA',BAT.t_p,BAT.EOD,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,6)];
    plotRUL('URA',BAT.t_p,BAT.RUL,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,8)];
    plotSOC('URA',BAT.t_p,BAT.SOC,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);
return

function h=plotLLF(BHM)
    BAT=BHM.LLF20;
    subplot(8,2,9)
    h=plotVoltageCurrent('LLF',BAT.t,BAT.V,BAT.I,BHM.timeS,BHM.timeE);
    [xticks xtickCL]=setupTicks(BHM.timeS,BHM.timeE);
    set(h(1),'XTick',xticks);
    set(h(1),'XTickLabel',xtickCL);
    set(h(2),'XTick',xticks);
    set(h(2),'XTickLabel',xtickCL);

    h=[h subplot(8,2,11)];
    plotEOD('LLF',BAT.t_p,BAT.EOD,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,13)];
    plotRUL('LLF',BAT.t_p,BAT.RUL,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,15)];
    plotSOC('LLF',BAT.t_p,BAT.SOC,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);
return

function h=plotLRF(BHM)
    BAT=BHM.LRF40;
    subplot(8,2,10)
    h=plotVoltageCurrent('LRF',BAT.t,BAT.V,BAT.I,BHM.timeS,BHM.timeE);
    [xticks xtickCL]=setupTicks(BHM.timeS,BHM.timeE);
    set(h(1),'XTick',xticks);
    set(h(1),'XTickLabel',xtickCL);
    set(h(2),'XTick',xticks);
    set(h(2),'XTickLabel',xtickCL);

    h=[h subplot(8,2,12)];
    plotEOD('LRF',BAT.t_p,BAT.EOD,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,14)];
    plotRUL('LRF',BAT.t_p,BAT.RUL,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);

    h=[h subplot(8,2,16)];
    plotSOC('LRF',BAT.t_p,BAT.SOC,BHM.timeS,BHM.timeE);
    set(gca,'XTick',xticks);
    set(gca,'XTickLabel',xtickCL);
return
        
function [xticks xtickCL]=setupTicks(timeS,timeE)
    xticks = get(gca,'XTick');
    tickDif = mean(diff(xticks));
    xtickL = get(gca,'XTickLabel');

    if (timeS<xticks(1)-tickDif/2)
        xticks = [timeS xticks];
        xtickL = [xtickL(1,:); xtickL];
    end
    if (timeE>xticks(end)+tickDif/2)
        xticks = [xticks timeE];
        xtickL = [xtickL; xtickL(end,:)];
    end

    xL = length(xticks);
    xtickCL = cell(xL,1);
    for i=1:xL
        xtickCL{i} = xtickL(i,:);
    end
    
    [mv miS] = min(abs(xticks-timeS));
    xticks(miS) = timeS;
    [mv miE] = min(abs(xticks-timeE));
    xticks(miE) = timeE;
    xtickCL{miS} = sprintf('%.1f>',timeS);
    xtickCL{miE} = sprintf('<%.1f',timeE);
return