%%%% File to check signal integrity
clear all
% Set 1
load SFDI_0g_21p5_gp0005_BLWN_pw1p0_022510_1005.mat       
%load SFDI_5g_21p5_gp0005_BLWN_pw1p0_022510_1224.mat
%load SFDI_10g_21p5_gp0005_BLWN_pw1p0_022510_1135.mat
%load SFDI_15g_21p5_gp0005_BLWN_pw1p0_022510_1114.mat

%N = 69; %For A4, the accel on the pedistal
N = 60; %For A1, the outboard accel

L = length(pc104.data(:,N));
X = pc104.data(1:L,N);

% Low pass filter the data
[B,A] = butter(8,0.2);
X = filter(B,A,X);

% Turn on second decimation
X = decimate(X,5);

% Do the second set of data
% Set 2
load SFDI_0g_21p5_gp0005_BLWN_pw1p0_022510_1033.mat
%load SFDI_5g_21p5_gp0005_BLWN_pw1p0_022510_1224.mat       
%load SFDI_5g_21p5_gp0005_BLWN_pw1p0_022510_1244.mat   
%load SFDI_10g_21p5_gp0005_BLWN_pw1p0_022510_1135.mat      
%load SFDI_10g_21p5_gp0005_BLWN_pw1p0_022510_1155.mat      
%load SFDI_15g_21p5_gp0005_BLWN_pw1p0_022510_1057.mat      
%load SFDI_15g_21p5_gp0005_BLWN_pw1p0_022510_1114.mat      

Ly = length(pc104.data(:,N));
Y = pc104.data(1:Ly,N);
Y = filter(B,A,Y);
Y = decimate(Y,5);

% Plot spectrum
X = X(329:length(X));
Y = Y(329:length(Y));
X = X - mean(X);
Y = Y - mean(Y);
%X = X./var(X);
%Y = Y./var(Y);
DL = length(X);
Fs = 200/5;
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
W = [0:0.001:1].*pi;
[PX Wo] = pwelch(X,hann(DL/K),0,W);  % Nonimal system, use hanning window
[PY Wu] = pwelch(Y,hann(DL/K),0,W);  % Damaged system, use hanning window

twoK = 2*K; %Plot a F distribution for comparison
xF = 0:0.0001:3;
yF = fpdf(xF,twoK,twoK);
plot(xF,yF,'r')
hold on

% Form the F distribution for fault detection
F = PX./PY;

% Check what is going on
%plot(Wo,PX)
%hold on
%plot(Wu,PY,'r')
%hold on
%plot(Wo,F,'g');

x = 0.05:0.1:2.95; %Bins for the histogram
NB = hist(F,x);   %Plot the histogram
Max = max(F)
Min = min(F)
plot(x,NB./(sum(NB)*0.1),'.b')
hold on

%Perform the two tail test
P = finv([0.0005 0.9995],twoK,twoK)
plot(P,[0.2 0.2],'*g')

