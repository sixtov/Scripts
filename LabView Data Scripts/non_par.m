% This m-file demonstrates a nonparametric technique for fault detection
% based on measured data only. From "Time-series methodes for fault
% detection in vibrating structures", by Fassois & Sakellariou Page 420

clear all
% Simulate normal vibrating structure
wo = 0.25*pi; ro = 0.9; N = 1E7;   %natural freq; damping; # of samples
Ao = [1 -2*ro*cos(wo) ro^2];        %transfer function denominater
Bo = [0.5 0.7 1.2];                 %numerator
an = length(Ao)-1;   %order of A
bn = length(Bo)-1;   %order of B
uo = randn(N,1);     %intitialize data vectors
yo = zeros(N,1);

% Simulate damaged vibrating structure
wu = 0.275*pi; ru = 0.9;            %natural freq; damping
Au = [1 -2*ru*cos(wu) ru^2];        %transfer function denominater
Bu = [0.5 0.7 1.2];                 %numerator
anu = length(Au)-1;   %order of A
bnu = length(Bu)-1;   %order of B
uu = randn(N,1);     %intitialize data vectors
yu = zeros(N,1);

% Simulation
for t = an+1:N
    yo(t) = -Ao(2:an+1)*yo(t-1:-1:t-an)   + Bo*uo(t:-1:t-bn);
    yu(t) = -Au(2:anu+1)*yu(t-1:-1:t-anu) + Bu*uu(t:-1:t-bnu);
end

% Create a Welch spectral estimator: pwelch(data,window length, overlap)
K = 10; %Number of data segments
%W = [0:0.001:1].*pi;
[Pyo Wo] = pwelch(yo,N/K,0);  % Nonimal system, use hanning window
[Pyu Wu] = pwelch(yu,N/K,0);  % Damaged system, use hanning window

twoK = 2*K; %Plot a F distribution for comparison
xF = 0:0.0001:6;
yF = fpdf(xF,twoK,twoK);
plot(xF,yF,'r')
hold on

% Form the F distribution for fault detection
F = Pyo./Pyu;

% Check what is going on
%plot(Wo,Pyo)
%hold on
%plot(Wu,Pyu,'r')
%hold on
%plot(Wo,F.*20,'g');

%break

x = 0.025:0.05:6; %Bins for the histogram
NB = hist(F,x);   %Plot the histogram
max(F)
min(F)
plot(x,NB./(sum(NB)*0.05),'b')
hold on

%Perform the two tail test
alpha = 5E-7;
P = finv([alpha/2, 1-alpha/2],twoK,twoK);
%plot(P,[0.2 0.2],'.g')

