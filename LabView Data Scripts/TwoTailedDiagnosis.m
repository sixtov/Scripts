%%%% File to check signal integrity
function [] = TwoTailedDiagnosis(knownOBAZ, unknownOBAZ, pColor, hFlag)
    disp('TwoTailedDiagnosis')
    % Lowpass Filter
    [B,A] = butter(8,0.2);

    X = knownOBAZ;
    % Low pass filter the data
    X = filter(B,A,X);
    % Turn on second decimation
    X = decimate(X,5);
    X = X(329:length(X));
    X = X - mean(X);

    Y = unknownOBAZ;
    % Low pass filter the data
    Y = filter(B,A,Y);
    % Turn on second decimation
    Y = decimate(Y,5);
    Y = Y(329:length(Y));
    Y = Y - mean(Y);

    %X = X./var(X);
    %Y = Y./var(Y);
    DL = length(X);
    Fs = 200/5;

    % Plot spectrum
    %h = spectrum.welch;       % Create a Welch spectral estimator. 
    %Hpsd = psd(h,X,'Fs',Fs);  % Calculate the PSD 
    %plot(Hpsd)                % Plot the PSD

    %pause
    %hold on

    %h = spectrum.welch;       % Create a Welch spectral estimator. 
    %Hpsd = psd(h,Y,'Fs',Fs);  % Calculate the PSD 
    %plot(Hpsd)                % Plot the PSD

    %hold on
    %pause
    %hold off

    % Create a Welch spectral estimator: pwelch(data,window length, overlap)
    K = 40; %Number of data segments
    WL = round(DL/K);
    W = [0:0.001:1].*pi;
    [PX Wo] = pwelch(X,hann(WL),0,W);  % Nonimal system, use hanning window
    [PY Wu] = pwelch(Y,hann(WL),0,W);  % Damaged system, use hanning window

    % Form the F distribution for fault detection
    F = PX./PY;
    slvFigure('TwoTailedDiagnosis:PSD');
    subplot(1,2,1)
    if hFlag, hold on; else hold off; end
    plot(Fs*Wo/pi,F,pColor)
    hold on
    grid on
%     disp('Hit any key to continue ...')
%     pause;

    twoK = 2*K; %Plot a F distribution for comparison
    xF = 0:0.0001:3;
    %xF = 0.05:0.1:2.95; %Bins for the histogram
    yF = fpdf(xF,twoK,twoK);
    % Normalize pdf so area equals 1
    yF = yF/sum(yF);
    
    %slvFigure('TwoTailedDiagnosis:PSD');
    subplot(1,2,2)
    if hFlag, hold on; else hold off; end
    plot(xF,yF,'k','LineWidth',2)
    hold on
    if ~hFlag, ylim(1.5*ylim()); end
    
    % Check what is going on
    %plot(Wo,PX)
    %hold on
    %plot(Wu,PY,'r')
    %hold on
    %plot(Wo,F,'g');

    x = 0.05:0.1:2.95; %Bins for the histogram
    NB = hist(F,x);   %Plot the histogram
    % Normalize pdf so area equals 1
    NB = (length(x)/length(xF))*NB/sum(NB);
    
%     Max = max(F);
%     Min = min(F);
    % plot(x,NB./(sum(NB)*0.1),'.b')
    % plot(x,NB./(sum(NB)*0.1),pColor)
    plot(x,NB,pColor)
    hold on

    %Perform the two tail test
    P = finv([0.0005 0.9995],twoK,twoK);
    %plot(P,[0.2 0.2],'*g')
    xl = xlim();
%     xtick = xl(1):0.5:xl(2);
%     for i=1:2
%         [mv mi] = min(abs(xtick-P(i)));
%         xtick(mi) = P(i);
%     end
    xtick = unique(sort([xl P]));
    set(gca,'Xtick',xtick);
    grid on
    pause(1);
return
