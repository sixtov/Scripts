function [p d] = getParametersFromData(PC104,dFlag, mFlag, varargin)
    %% Constants
    Fs = 200;
    
    %% Generate parameters with OBAcc Data
    d = get_data(PC104.DATA);
    d.Fs = Fs/5;
    d.strain = mean([d.strain_aft d.strain_fwd],2);
    d.acc = d.acc_ob; % - d.acc_cg;

    [p d] = getParameters(dCase, d, dFlag, mFlag);
    p.dCase = dCase;
    p.sigName = {'OBaccOnly'};
    p.sd.sigName = p.sigName;
    
    if (nargin > 3)
       p.sd = getTwoTailedParameters(dCase, varargin{1}, p.sd, 0, 0 );
       p.delLim_low  = p.sd.delLim(1);
       p.delLim_hi  = p.sd.delLim(2);
       p.damageInd = p.sd.damageInd;
       p.array = [p.array; p.delLim_low; p.delLim_hi; p.damageInd];
    end;
   
    %% Plot Data
    plotData(d,p);
return

function [p d] = getParameters(dCase, d, dFlag, mFlag)
    global pfit;
    warning off all;

    %% Set Damage Flag Classification
    p.dFlag = dFlag;
    p.mFlag = mFlag;
    
    p.eRatio = sqrt(mean((d.strain).^2)) / ...
               sqrt(mean((d.acc).^2));
    p.array = p.eRatio;
    
    %% Get Second Order System Poles, Wn, & Sae
    m = arx([d.strain d.acc],[2 2 0]);
    m.Ts = 1/d.Fs;
    m = d2c(m);
    [dwn dsae dpole] = damp(tf(m));
    
    p.wn1 = abs(dwn(1));
    p.wn2 = abs(dwn(2));
    p.sae1 = dsae(1);
    p.sae2 = dsae(2);
    p.pole1_m = abs(dpole(1));
    p.pole2_m = abs(dpole(2));
    p.pole1_a = angle(dpole(1));
    p.pole2_a = angle(dpole(2));
    p.array = [p.array; p.wn1; p.wn2; p.sae1; p.sae2; p.pole1_m; p.pole1_a; p.pole2_m; p.pole2_a];
    
    %% Get Slope of Strain vs Acceleration
    d.pc = polyfit(d.acc,d.strain,1);
    p.slope = d.pc(1);
    p.intercept = d.pc(2);
    d.px = unique(sort(d.acc));
    p.array = [p.array; p.slope; p.intercept];
    
    %% Get Peak Parameters of Load Factor Histogram
    CAP = 100;
    acc_TH = 1/CAP;
%     d.acc(d.acc>=0 & d.acc<acc_TH) =  acc_TH;
%     d.acc(d.acc<=0 & d.acc>-acc_TH) = -acc_TH;
    d.lf = d.strain ./ d.acc;
    d.lf(d.lf >  CAP) =  CAP;
    d.lf(d.lf < -CAP) = -CAP;
    [b a] = butter(4,0.2);
    d.lf = filtfilt(b,a,d.lf);

    bw = 1.5;
    
    %% Histogram
    bins = round(max(abs(d.lf))/bw);
    [d.hy d.hx] = hist(d.lf, bins);
%     %% eliminate the two outermost bins
%     d.hx = d.hx(5:bins-4);
%     d.hy = d.hy(5:bins-4);
    %% continue process
    d.hy = d.hy/max(d.hy);
    d.hx = d.hx(:);
    d.hy = d.hy(:);
    
    N = length(d.strain);
    try
        gfit = fit(d.hx,d.hy,'gauss1');
        pfit = gfit; % Saves current fit 
        p.lf_c = gfit.b1;
        p.lf_w = gfit.c1;
        p.lf_a = gfit.a1;
    catch
        %ME
        %p.lf_c = 0;
        %p.lf_w = 20;
        %p.lf_a = 1;
        % Current fit failed, Use previous fit
        p.lf_c = pfit.b1;
        p.lf_w = pfit.c1;
        p.lf_a = pfit.a1;
    end
    p.array = [p.array; p.lf_c; p.lf_w; p.lf_a];
    
    %% Get Main Frequency of Strain
    Y = fft(d.strain)/N;
    f = linspace(0,d.Fs,N);
    idx = find(f>1 & f<20);
    [mv mi] = max(abs(Y(idx)));
    p.lf_freq = f(idx(mi));
    p.array = [p.array; p.lf_freq];
    
    %% Get Two-Tail Parameters
    % Create a Welch spectral estimator: pwelch(data,window length, overlap)
    p.sd.dCase = dCase;
    p.sd.Fs = d.Fs;
    p.sd.DL = length(d.acc);
    p.sd.K = 40; %Number of data segments
    p.sd.WL = round (p.sd.DL / p.sd.K);
    p.sd.W = pi*[0:0.001:1]';
    [p.sd.sHat p.sd.Wu] = pwelch(d.acc, hann(p.sd.WL), 0, p.sd.W );  % Damaged system, use hanning window

    warning on all;
return

function d = get_data(DATA)
    d.time = DATA.time;
    d.acc_cg = DATA.CGAZ;
    d.acc_ob = DATA.CANOBAZ;
    d.acc_ib = DATA.CANIBAZ;
    d.acc_ct = DATA.CANCTRAZ;
    d.strain_aft = 1e6*DATA.AFTSTRB;
    d.strain_fwd = 1e6*DATA.FSTRB;
    
    idx = find(d.time>0.5);
    d.time = d.time(idx);
    d.acc_cg = d.acc_cg(idx);
    d.acc_ob = d.acc_ob(idx);
    d.acc_ib = d.acc_ib(idx);
    d.acc_ct = d.acc_ct(idx);
    d.strain_aft = d.strain_aft(idx);
    d.strain_fwd = d.strain_fwd(idx);
    
    [b a] = butter(4,0.2);
    
    d.acc_cg = filtfilt(b,a,d.acc_cg);
    d.acc_ob = filtfilt(b,a,d.acc_ob);
    d.acc_ib = filtfilt(b,a,d.acc_ib);
    d.acc_ct = filtfilt(b,a,d.acc_ct);
    d.strain_aft = filtfilt(b,a,d.strain_aft);
    d.strain_fwd = filtfilt(b,a,d.strain_fwd);
    
    d.time = decimate(d.time,5);
    d.acc_cg = decimate(d.acc_cg,5);
    d.acc_ob = decimate(d.acc_ob,5);
    d.acc_ib = decimate(d.acc_ib,5);
    d.acc_ct = decimate(d.acc_ct,5);
    d.strain_aft = decimate(d.strain_aft,5);
    d.strain_fwd = decimate(d.strain_fwd,5);
    
    d.acc_cg = d.acc_cg - mean(d.acc_cg);
    d.acc_ob = d.acc_ob - mean(d.acc_ob);
    d.acc_ib = d.acc_ib - mean(d.acc_ib);
    d.acc_ct = d.acc_ct - mean(d.acc_ct);
    d.strain_aft = d.strain_aft - mean(d.strain_aft);
    d.strain_fwd = d.strain_fwd - mean(d.strain_fwd);
return

function plotData(d,p)
    slvFigure(sprintf('%s - Data Plot',p.dCase));
    subplot(5,1,1)
        plot(d.time,d.strain); grid on
        yl = ylim();
        title (sprintf('%s',p.sigName{1}));
%     subplot(5,2,2)
%         plot(d.uni.time,d.uni.strain); grid on
%         ylim(yl);
%         title (sprintf('%s',p.uni.sigName));
        
    subplot(5,1,2)
        plot(d.time,d.acc); grid on
        yl = ylim();
%     subplot(5,2,4)
%         plot(d.uni.time,d.uni.acc); grid on
%         ylim(yl);

    subplot(5,1,3)
        hold off
        plot(d.acc,d.strain,'b.'); grid on
        hold on
        plot(d.px,polyval(d.pc,d.px),'r'); grid on
        xl = xlim();
        yl = ylim();
        text(dot(xl,[.95 .05]),dot(yl,[.75 .25]),sprintf('Slope = %0.2f',p.slope),'FontSize',14)
%     subplot(5,2,6)
%         hold off
%         plot(d.uni.acc,d.uni.strain,'b.'); grid on
%         hold on
%         plot(d.uni.px,polyval(d.uni.pc,d.uni.px),'r'); grid on
%         xlim(xl);
%         ylim(yl);
%         text(dot(xl,[.95 .05]),dot(yl,[.75 .25]),sprintf('Slope = %0.2f',p.uni.slope),'FontSize',14)
        
    subplot(5,1,4)
        plot(d.time,d.lf); grid on
        ylim(100*[-1 1])
        yl = ylim();
        ytick = unique(sort([yl p.lf_c]));
        set(gca,'Ytick',ytick)
%     subplot(5,2,8)
%         plot(d.uni.time,d.uni.lf); grid on
%         ylim(yl);
%         ytick = unique(sort([yl p.uni.lf_c]));
%         set(gca,'Ytick',ytick)
        
    subplot(5,1,4)
        yl = ylim();
    subplot(5,1,5)
        hold off
        plot(d.hx,d.hy,'b','LineWidth',2); grid on
        hold on
        plot(d.hx,p.lf_a*exp(-((d.hx-p.lf_c)/p.lf_w).^2),'r')
        xlim(yl)
        xtick = get(gca,'Xtick');
        [mv mi] = min(abs(xtick-p.lf_c));
        xtick(mi) = p.lf_c;
        set(gca,'Xtick',xtick);
%     subplot(5,2,8)
%         yl = ylim();
%     subplot(5,2,10)
%         hold off
%         plot(d.uni.hx,d.uni.hy,'b','LineWidth',2); grid on
%         hold on
%         plot(d.uni.hx,p.uni.lf_a*exp(-((d.uni.hx-p.uni.lf_c)/p.uni.lf_w).^2),'r')
%         xlim(yl)
%         xtick = get(gca,'Xtick');
%         [mv mi] = min(abs(xtick-p.uni.lf_c));
%         xtick(mi) = p.uni.lf_c;
%         set(gca,'Xtick',xtick);
    saveas(gcf,sprintf('fig\\%s.fig',p.dCase));
    %pause(1)
    close(gcf)
return
