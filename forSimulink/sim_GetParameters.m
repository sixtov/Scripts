function [p d] = sim_GetParameters(s1,s2)
    d.Fs = 200;
    N = length(s1);
    if N>50, s1 = s1(2:end); s2 = s2(2:end); end
    
    p.eRatio = sqrt(mean((s1).^2)) / sqrt(mean((s2).^2));
    
    %% Get Second Order System Poles, Wn, & Sae
    m = arx([s1 s2],[2 2 0]);
    m.Ts = 1/200;
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
    
    %% Get Slope of Strain vs Acceleration
    d.pc = polyfit(s2,s1,1);
    p.slope = d.pc(1);
    p.intercept = d.pc(2);
    d.px = unique(sort(s2));
    
    %% Get Peak Parameters of Load Factor Histogram
    CAP = 100;
    acc_TH = 1/CAP;
    d.lf = s1 ./ s2;
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
    
    N = length(s1);
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
    
    %% Get Main Frequency of Strain
    Y = fft(s1)/N;
    f = linspace(0,d.Fs,N);
    idx = find(f>1 & f<20);
    [mv mi] = max(abs(Y(idx)));
    p.lf_freq = f(idx(mi));
    
    p.array = [p.eRatio;        ...
               p.wn1;           ...
               p.wn2;           ...
               p.sae1;          ...
               p.sae2;          ...
               p.pole1_m;       ...
               p.pole1_a;       ...
               p.pole2_m;       ...
               p.pole2_a;       ...
               p.slope;         ...
               p.intercept;     ...
               p.lf_c;          ...
               p.lf_w;          ...
               p.lf_a;          ...
               p.lf_freq];
return
