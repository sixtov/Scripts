%%
    d = getPc4Data('MT_LoadDive_01','filter',0.9,'decimate',1,'zerobias');

    BS = 32*d.Fs;
    N = floor(length(d.time)/BS);
    
    p1R = zeros(N,1);
    p2R = zeros(N,1);
    p3R = zeros(N,1);
    p4R = zeros(N,1);
    p5R = zeros(N,1);
    p6R = zeros(N,1);
    midx = zeros(N,1);
    for i=1:N
        idx = (i-1)*BS+1:i*BS;
        midx(i) = round(mean(idx));
        
        %%pass strain and obacc to function
        [p junk] = getParameters(d.Fs, d.strn(idx), d.obaz(idx));
                             
        clss = classifyData([p.lf_w p.lf_freq], ...
                            [p.lf_c p.pole1_a], ...
                            [p.slope ,p.lf_w], ...
                            'strain', 'cgaz'); %,'plot');
                        
        p1R(i) = clss.dFlag;
        
    end
%%%
disp(pwd)
    slvFigure('Classify Results');
%     h(1)=subplot(3,2,1);
    plot(d.time(midx),p1R,':.')
    ylim([-1 2]);
    set(gca,'YTick',[0 1]);
    set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
    vtitle('(strain vs obacc)');
    
%     h(2)=subplot(3,2,2);
%     plot(p2R,':.')
%     ylim([-1 2]);
%     set(gca,'YTick',[0 1]);
%     set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
%     validTitle('(strain vs ctacc)');
%     
%     h(3)=subplot(3,2,3);
%     plot(p3R,':.')
%     ylim([-1 2]);
%     set(gca,'YTick',[0 1]);
%     set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
%     validTitle('(strain vs ibacc)');
%     
%     h(4)=subplot(3,2,4);
%     plot(p4R,':.')
%     ylim([-1 2]);
%     set(gca,'YTick',[0 1]);
%     set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
%     validTitle('(ibacc vs obacc)');
%     
%     h(5)=subplot(3,2,5);
%     plot(p5R,':.')
%     ylim([-1 2]);
%     set(gca,'YTick',[0 1]);
%     set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
%     validTitle('(ibacc vs ctacc)');
%     
%     h(6)=subplot(3,2,6);
%     plot(p6R,':.')
%     ylim([-1 2]);
%     set(gca,'YTick',[0 1]);
%     set(gca,'YTickLabel',[{'Undamaged'} {'Damaged'}]);
%     validTitle('(ctacc vs obacc)');
    
%     linkaxes(h,'x')