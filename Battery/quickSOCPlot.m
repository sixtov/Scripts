%%
idx = strfind(BHM.dfile,filesep);
if ~isempty(idx)
    dfile = BHM.dfile(idx(end)+1:end);
else
    dfile = BHM.dfile;
end

yl = [-10 110];

slvFigure(sprintf('SOC Data: %s',dfile));
h=subplot(2,2,1);
hold off
plot(BHM.ULA20.t/60,[BHM.ULA20.V BHM.ULA20.I])
hold on
plot(BHM.ULA20.t_p/60,BHM.ULA20.SOC(:,2),'r')
vtitle(sprintf('%s\nULA20',dfile));
ylim(yl)
xt=get(gca,'XTick');
[mv mi]=min(abs(xt-BHM.timeS));
xt(mi)=BHM.timeS;
[mv mi]=min(abs(xt-BHM.timeE));
xt(mi)=BHM.timeE;
set(gca,'XTick',xt);
grid on

h=[h subplot(2,2,2)];
hold off
plot(BHM.URA40.t/60,[BHM.URA40.V BHM.URA40.I])
hold on
plot(BHM.URA40.t_p/60,BHM.URA40.SOC(:,2),'r')
vtitle(sprintf('%s\nURA40',dfile));
ylim(yl)
set(gca,'XTick',xt);
grid on

h=[h subplot(2,2,3)];
hold off
plot(BHM.LLF20.t/60,[BHM.LLF20.V BHM.LLF20.I])
hold on
plot(BHM.LLF20.t_p/60,BHM.LLF20.SOC(:,2),'r')
vtitle(sprintf('%s\nLLF20',dfile));
ylim(yl)
set(gca,'XTick',xt);
grid on

h=[h subplot(2,2,4)];
hold off
plot(BHM.LRF40.t/60,[BHM.LRF40.V BHM.LRF40.I])
hold on
plot(BHM.LRF40.t_p/60,BHM.LRF40.SOC(:,2),'r')
vtitle(sprintf('%s\nLRF40',dfile));
ylim(yl)
set(gca,'XTick',xt);
grid on

linkaxes(h,'x');
pause(3)

saveas(gcf,sprintf('%s_SOC.fig',BHM.dfile(1:end-4)));
