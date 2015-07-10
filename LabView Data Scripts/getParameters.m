function [p d] = getParameters(varargin)
    global pfit;
    warning off all;
    if (nargin == 1) 
        d = varargin{1};
    elseif (nargin == 3)
        d.Fs     = varargin{1};
        d.strain = varargin{2};
        d.acc    = varargin{3};
    else
        disp('Error: please specify data set')
        return;
    end
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
    
%     %% Get Two-Tail Parameters
%     % Create a Welch spectral estimator: pwelch(data,window length, overlap)
%     p.sd.Fs = d.Fs;
%     p.sd.DL = length(d.acc);
%     p.sd.K = 40; %Number of data segments
%     p.sd.WL = round (p.sd.DL / p.sd.K);
%     p.sd.W = pi*[0:0.001:1]';
%     [p.sd.sHat p.sd.Wu] = pwelch(d.acc, hann(p.sd.WL), 0, p.sd.W );  % Damaged system, use hanning window

    warning on all;
return
