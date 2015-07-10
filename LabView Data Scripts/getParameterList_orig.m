%% Generate Parameter
function p = getParameterList(dCase,dFlag)
    load(sprintf('%s\\PC104.mat',dCase));
    p.name = dCase;
    
    %% Constants
    Fs = 200;
    
    %% Data
    d = get_data(PC104.DATA);
    d.Fs = Fs/5;
    d.strain = mean([d.strain_aft d.strain_fwd],2);
    d.acc = d.acc_ob - d.acc_cg;
    
    slvFigure('Data Plot');
    subplot(5,1,1)
    plot(d.time,d.strain); grid on
    subplot(5,1,2)
    plot(d.time,d.acc); grid on
    subplot(5,1,3)
    hold off
    plot(d.acc,d.strain,'b.'); grid on
    hold on
    
    %% Parameter set 1
    m = arx([d.strain d.acc],[2 2 0]);
    m.Ts = 1/d.Fs;
    m = d2c(m);
    [p.wn p.sae p.pole] = damp(tf(m));
    
    %% Parameter Set 2
    pc = polyfit(d.acc,d.strain,1);
    p.slope = pc(1);
    p.intercept = pc(2);
    px = unique(sort(d.acc));
    plot(px,polyval(pc,px),'r'); grid on

    %% Parameter Set 3
    d.lf = d.strain ./ d.acc;
    CAP = 100;
    d.lf(d.lf >  CAP) =  CAP;
    d.lf(d.lf < -CAP) = -CAP;
    [b a] = butter(2,0.2);
    d.lf = filtfilt(b,a,d.lf);

    subplot(5,1,4)
    plot(d.time,d.lf); grid on
    axis tight
    yl = ylim();
    
    bw = 1.5;
    bins = round(max(d.lf)/bw);
    [hy hx] = hist(d.lf, bins);
    hy = hy/max(hy);
    
    subplot(5,1,5)
    hold off
    plot(hx,hy,'b'); grid on
    xlim(yl)
    
    N = length(d.strain);
    st.fit = fit(hx',hy','gauss1');
    p.lf_c = st.fit.b1;
    p.lf_w = st.fit.c1;
    p.lf_a = st.fit.a1;
    hold on
    plot(hx',p.lf_a*exp(-((hx'-p.lf_c)/p.lf_w).^2),'r')
%     plot(hx',exp(-((hx'-(-37))/8).^2),':g.')
    Y = fft(d.strain)/N;
    f = linspace(0,d.Fs,N);
    idx = find(f>1 & f<20);
    [mv mi] = max(abs(Y(idx)));
    p.lf_freq = f(idx(mi));
    p.dFlag = dFlag;
    
    xtick = get(gca,'Xtick');
    [mv mi] = min(abs(xtick-p.lf_c));
    xtick(mi) = p.lf_c;
    set(gca,'Xtick',xtick);
    
    subplot(5,1,4)
    ytick = unique(sort([yl p.lf_c]));
    set(gca,'Ytick',ytick);
    
    %% Parameter set 4
    %5 Create a Welch spectral estimator: pwelch(data,window length, overlap)
    p.sd.Fs = d.Fs;
    p.sd.DL = length(d.acc_ob);
    p.sd.K = 40; %Number of data segments
    p.sd.WL = round (p.sd.DL / p.sd.K);
    p.sd.W = [0:0.001:1].*pi;
    [p.sd.sHat p.sd.Wu] = pwelch(d.acc_ob,hann(p.sd.WL),0,p.sd.W);  % Damaged system, use hanning window


return

%%% Returns filtered, decimated, & zero-meaned data
function d = get_data(DATA)

    d.time = DATA.time;
    d.acc_cg = DATA.CGAZ;
    d.acc_ob = DATA.CANOBAZ;
    d.strain_aft = 1e6*DATA.AFTSTRB;
    d.strain_fwd = 1e6*DATA.FSTRB;
    
    idx = find(d.time>0.5);
    d.time = d.time(idx);
    d.acc_cg = d.acc_cg(idx);
    d.acc_ob = d.acc_ob(idx);
    d.strain_aft = d.strain_aft(idx);
    d.strain_fwd = d.strain_fwd(idx);
    
    [b a] = butter(2,0.2);
    
    d.acc_cg = filtfilt(b,a,d.acc_cg);
    d.acc_ob = filtfilt(b,a,d.acc_ob);
    d.strain_aft = filtfilt(b,a,d.strain_aft);
    d.strain_fwd = filtfilt(b,a,d.strain_fwd);
    
    d.time = decimate(d.time,5);
    d.acc_cg = decimate(d.acc_cg,5);
    d.acc_ob = decimate(d.acc_ob,5);
    d.strain_aft = decimate(d.strain_aft,5);
    d.strain_fwd = decimate(d.strain_fwd,5);
    
    d.acc_cg = d.acc_cg - mean(d.acc_cg);
    d.acc_ob = d.acc_ob - mean(d.acc_ob);
    d.strain_aft = d.strain_aft - mean(d.strain_aft);
    d.strain_fwd = d.strain_fwd - mean(d.strain_fwd);
return