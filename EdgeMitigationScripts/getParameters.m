function p = getParameters(p,darray,narray)
    c = flipud(combnk(1:size(darray,2),2));
    %c = c([1 2 4 5 6],:);
    N = size(c,1);
    for i=1:N
        pa(i) = getPairParameters(darray(:,c(i,:)));
        na{i} = sprintf('%s v %s',narray{c(i,:)});
    end
    fnames = fieldnames(pa(1));
    if isempty(p), cR = 1; else cR = size(p.(fnames{1}),1)+1; end
    Nf = length(fnames);
    for i=1:Nf
        for j=1:N
            p.(fnames{i})(cR,(j)) = pa(j).(fnames{i});
        end
    end
    p.pairs = na;
return

function p = getPairParameters(pair)
    p = getSignalParameters(pair(:,1),pair(:,2));
return

function p = getSignalParameters(p1,p2)
    global pfit;
    warning off all;

    p.eRt = sqrt(mean(p1.^2)) / ...
            sqrt(mean(p2.^2));
    
    %% Get Second Order System Poles, Wn, & Sae
    m = arx([p1 p2],[2 2 0]);
    %m.Ts = 1/d.Fs;
    m = d2c(m);
    [dwn dsae dpole] = damp(tf(m));
    
    p.w_n = abs(dwn(1));
    p.sae = dsae(1);
    p.p_m = abs(dpole(1));
    p.p_a = angle(dpole(1));
    
%     p.wn1 = abs(dwn(1));
%     p.sae1 = dsae(1);
%     p.pole1_m = abs(dpole(1));
%     p.pole1_a = angle(dpole(1));
    
%     p.wn2 = abs(dwn(2));
%     p.sae2 = dsae(2);
%     p.pole2_m = abs(dpole(2));
%     p.pole2_a = angle(dpole(2));
    
    %% Get Slope of Strain vs Acceleration
    d.pc = polyfit(p2,p1,1);
%     p.slope = d.pc(1);
%     p.intercept = d.pc(2);
    p.l_b = d.pc(2);
    %d.px = unique(sort(p2));
    
    %% Get Peak Parameters of Load Factor Histogram
    CAP = 100;
    acc_TH = 1/CAP;
    d.lf = p1 ./ p2;
    d.lf(d.lf >  CAP) =  CAP;
    d.lf(d.lf < -CAP) = -CAP;
    [b a] = butter(4,0.2);
    d.lf = filtfilt(b,a,d.lf);

    bw = 1.5;
    
    %% Histogram
    bins = round(max(abs(d.lf))/bw);
    [d.hy d.hx] = hist(d.lf, bins);
    %% continue process
    d.hy = d.hy/max(d.hy);
    d.hx = d.hx(:);
    d.hy = d.hy(:);
    
    N = length(p1);
    try
        gfit = fit(d.hx,d.hy,'gauss1');
        pfit = gfit; % Saves current fit 
        p.lfw = gfit.c1;
%         p.lf_w = gfit.c1;
%         p.lf_c = gfit.b1;
%         p.lf_a = gfit.a1;
    catch
        %ME
        %p.lf_c = 0;
        %p.lf_w = 20;
        %p.lf_a = 1;
        % Current fit failed, Use previous fit
        p.lfw = pfit.c1;
%         p.lf_w = pfit.c1;
%         p.lf_c = pfit.b1;
%         p.lf_a = pfit.a1;
    end
    
    %% Get Main Frequency of Strain
%     Y = fft(p1)/N;
%     f = linspace(0,1,N);
%     idx = find(f>0 & f<1);
%     [mv mi] = max(abs(Y(idx)));
%     p.lf_freq = f(idx(mi));
    
    %% Get Two-Tail Parameters
    % Create a Welch spectral estimator: pwelch(data,window length, overlap)
%     p.sd.dCase = dCase;
%     p.sd.Fs = d.Fs;
%     p.sd.DL = length(p2);
%     p.sd.K = 40; %Number of data segments
%     p.sd.WL = round (p.sd.DL / p.sd.K);
%     p.sd.W = pi*[0:0.001:1]';
%     [p.sd.sHat p.sd.Wu] = pwelch(p2, hann(p.sd.WL), 0, p.sd.W );  % Damaged system, use hanning window

    warning on all;
return
