function [Mdle Pdle] = PanelDiagnosis(dCase)
    %%% Forward Calculation
    %clear
    PC104exist = 0;
    SENSORexist = 0;
    gagePos = 0.95*0.0254; % meters (m)
    [Mpanel wn sae] = getPanelModel();

    b = Mpanel.B(3);
    a = Mpanel.A;

    M = a(1)/b;     % mass (Kg)
    D = a(2)/b;     % damping (N-s/m)
    K = a(3)/b;     % spring constant (N/m)
    g = 9.8;        % acceleration (m/s^2)
    Ts = 1/200;     % sampling period (s)
    Lc = 0.9271;    % cantilever length (m)
    EI = 3246*Lc^3/3;  % stiffness (N-m^2)
    half_thickness = 0.025/8; %half thickness of panel (m)

    if ~isempty(dir(sprintf('%s\\PC104.mat',dCase)))
        PC104exist = 1;
        load(sprintf('%s\\PC104.mat',dCase));
    end
    if ~isempty(dir(sprintf('%s\\SENSOR.mat',dCase)))
        SENSOR.exist = 1;
        load(sprintf('%s\\SENSOR.mat',dCase));
    end

    % load('junk\PC104.mat');
    % load('MT_LoadDive\PC104.mat');
    % load('MT_LoadDive\SENSOR.mat');
    % load('MT_NoLoadSine\PC104.mat');
    % load('MT_NoLoadSine\SENSOR.mat');
    % load('MT_NoLoadDive\FOID.mat');
    % 
    % slvFigure('Fiber Strain');
    % fiber1 = FOID.f1;
    % plot(fiber1)

    if PC104exist
        t = PC104.DATA.time;
        % Filter data
        [b,a] = butter(2,0.15);
        cgAcc = -filtfilt(b,a,g*(PC104.DATA.CGAZ+1));
        obAcc = -filtfilt(b,a,g*(PC104.DATA.CANOBAZ+1));
        strain = -filtfilt(b,a,mean(1e6*[PC104.DATA.AFTSTRB PC104.DATA.FSTRB],2));
    else
        return
    end
    if SENSORexist
        torque = -SENSOR.moments(:,2)*0.025*4.44822 ;
    end
    
    % Outboard Acceleration Relative to the CG Acceleration
    obAcc = obAcc-cgAcc;

    % Remove Sensor Bias so Steady-State is Zero
    iss = find(t>(max(t)-3)); % use last 3 seconds
    cgAcc = cgAcc - mean(cgAcc(iss));
    obAcc = obAcc - mean(obAcc(iss));
    strain = strain - mean(strain(iss));

%     slvFigure('Strain/Acc');
%     subplot(2,1,1)
%     hold off
%     plot(t,strain,'b');
%     hold on
%     plot(t,10*obAcc,'r');
%     grid on
%     subplot(2,1,2)
%     plot(t,strain./obAcc);
%     grid on
%     s2a = strain./obAcc;
%     idx = find(abs(s2a)<100);
%     disp(mean(s2a(idx)))
    
    % Remove sensor powerup glitch (first 100ms)
%    idx  = find(t>150 & t<500);
%     if isempty(idx)
        idx = find(t>0.1);
%     end
    t = t(idx);
    cgAcc = cgAcc(idx);
    obAcc = obAcc(idx);
    strain = strain(idx);

    slvFigure('OB Data');
    h(1)=subplot(4,1,1); hold off;
    plot(t,obAcc);hold on;grid on
    plot(t,cgAcc,'r')
    plot(t,-strain/10,'g')
    xlabel('time (s)')
    ylabel('Acceleration (m/s^2)')
    lText = [{'obAcc'} {'cgAcc'} {'pseudo-strain'}];
    legend(lText);

    %%% Calculate Velocity as the Integral of Acceleration
    obVel = cumtrapz(t,obAcc);
    [b,a] = butter(2,0.002);
    fVel = filtfilt(b,a,obVel);
    obVel = obVel-fVel;

    slvFigure('OB Data');
    h(2)=subplot(4,1,2); hold off;
    plot(t,obVel,'b');hold on;grid on
    % plot(t,fVel,'r')
    % plot(t,obVel-fVel,'g')
    xlabel('time (s)')
    ylabel('Velocity (m/s)')
    lText = [{'obVel'}];
    legend(lText);
    linkaxes(h,'x')

    %%% Calculate Position as the Integral of Velovity
    obPos = cumtrapz(t,obVel);
    [b,a] = butter(2,0.02);
    fPos = filtfilt(b,a,obPos);
    obPos = obPos-fPos;

    slvFigure('OB Data');
    h(3)=subplot(4,1,3); hold off;
    plot(t,obPos,'b');hold on;grid on
    % plot(t,fPos,'r')
    % plot(t,obPos-fPos,'g')
    xlabel('time (s)')
    ylabel('Position (m)')
    lText = [{'obPos'}];
    legend(lText);
    linkaxes(h,'x')

    %%% Calculate Force from Acc,Vel,Pos and from strain
    aForce = M*obAcc + D*obVel + K*obPos;
    sForce = (1e-6*strain)*EI/(half_thickness*(Lc-gagePos));
    if SENSORexist
        mForce = torque/(Lc+0.1);
    end
    
    slvFigure('OB Data');
    h(4)=subplot(4,1,4); hold off;
    plot(t,aForce,'b');hold on;grid on
    plot(t,sForce/2,'g')
    if SENSORexist
        plot(SENSOR.time-0.030,mForce,'m')
    end
    xlabel('time (s)')
    ylabel('Force (N)')
    lText = [{'Acceleration Force'} {'Strain Force'}];
    if SENSORexist
        lText = [lText {'Moment Force'}];
    end
    legend(lText);
    linkaxes(h,'x')
    %%%
    [Mdle Me De Ke wne saee] = modelData(obPos,sForce,t,Ts);

%     %%%
%     dM = 100*(Me-M)/M;
%     dD = 100*(De-D)/D;
%     dK = 100*(Ke-K)/K;
%     dw = 100*(wne-wn)/wn;
%     ds = 100*(saee-sae)/sae;
% 
%     script{1,1}  = sprintf(' *** Percent Change in Model Parameters');
%     script{2,1}  = sprintf('%% Model: M s^2 + D s + K = F');
%     script{3,1}  = sprintf('    dM     = %f;       %% percent change',dM);
%     script{4,1}  = sprintf('    dD     = %f;       %% ',dD);
%     script{5,1}  = sprintf('    dK     = %f;       %% ',dK);
%     script{6,1}  = sprintf('    dw     = %f;       %% ',dw);
%     script{7,1}  = sprintf('    ds     = %f;       %% ',ds);
%     disp(script)

    pm = pole(tf(Mpanel));
    Pdle = pole(tf(Mdle)) + eps*j;

    slvFigure('Pole-Zero Map');
    hold off
    plot(pm,'bx','MarkerSize',24,'LineWidth',8)
    hold on
    plot(Pdle,'rx','MarkerSize',14,'LineWidth',3)
    axis equal
    xlim([-100 20])
    ylim([-60 60])
    grid on
    sgrid

return
%% Use Strain Force and obPos to generate model to compare against Mpanel
Mestimated = arx(iddata(obPos,sForce),[2 2 0]);
Mestimated.Ts = Ts;
Mestimated.B = [0 0 1];
Mestimated = d2c(Mestimated);
disp('<=================>')
disp('<Mpanel---------->')
Mpanel
damp(tf(Mpanel));
disp('<Mestimated------>')
Mestimated
damp(tf(Mestimated));

slvFigure('Pole-Zero Map');
hold off
pzmap(tf(Mpanel),'b')
hold on
pzmap(tf(Mestimated),'r')

%% Use Strain and obPos to generate model
Mpanel = arx(iddata(obPos,sForce),[2 2 0]);
Mpanel.Ts = Ts;
Mpanel = d2c(Mpanel);

p = pole(tf(Mpanel));
wn = abs(p(1));
sae = abs(real(p(1)))/wn;
sigma = sae*wn;
wd = abs(imag(p(1)));

lnMp = -pi*sae/sqrt(1-sae^2);

noise = zeros(size(t));
stepForce = zeros(size(t));
F = 1;
stepForce(t>1) = F;
x = lsim(tf(Mpanel),[stepForce noise],t);
nidx = length(t);
xss = x(nidx);

K = F/xss;
M = K/(wd^2*(1+(lnMp/pi)^2));
D = -2*wd*M*lnMp/pi;

script{1,1}  = sprintf(' ');
script{2,1}  = sprintf('%% Model: M s^2 + D s + K = F');
script{3,1}  = sprintf('    M     = %f;       %% mass (Kg)',M);
script{4,1}  = sprintf('    D     = %f;      %% damping (N-s/m)',D);
script{5,1}  = sprintf('    K     = %f;        %% stiffness (N/m)',K);
script{6,1}  = sprintf('    Wn    = %f;       %% natural freq (rad/s)',wn);
script{7,1}  = sprintf('    sae   = %f;    %% damping ratio',sae);
script{8,1}  = sprintf('    Wd    = %f;       %% damped freq (rad/s)',wd);
script{9,1}  = sprintf('    Decay = %f;    %% exponential decay ',sigma);
%script{10,1} = sprintf('    %%%% Model of Panel');
%script{11,1} = sprintf('    Mpanel = idpoly(tf(1,[M D K]));');
%script{12,1} = sprintf('return');

disp(script)
    
%%
[Mpanel M D K wn sae] = modelData(obPos,sForce,t,Ts);

%%
[Mpanel M D K wn sae] = modelData(obAcc,sForce,t,Ts);

%%
disp('<=================>')
disp('<Mpanel---------->')
Mpanel
damp(tf(Mpanel));

slvFigure('Pole-Zero Map');
hold off
pzmap(tf(Mpanel),'b')
hold on
plot(p,'bx','MarkerSize',14,'LineWidth',3)
sgrid
xlim([-60 0])
ylim([-40 40])

%%
% 
% h(2)=subplot(4,1,2); hold off;plot(t,obVel);hold on;grid on
% h(3)=subplot(4,1,3); hold off;plot(t,obPos);hold on;grid on
% %plot(t,fPos,'r');
% junk = (SENSOR.disp(:,4)-SENSOR.disp(:,2))/1000;
% plot(SENSOR.time,junk,'g')
% de = lsim(tf(Mpanel),[sForce noise],t);
% plot(t,de,'m')
% h(4)=subplot(4,1,4); hold off;plot(t,f);hold on;grid on
% if SENSORexist
%     torque = -SENSOR.moments(:,2)*0.025*4.44822 ;
%     force = torque/1.0271;
%     plot(SENSOR.time,force,'g')
% end
% plot(t,sForce,'m')
% 
% linkaxes(h,'x')
% 
% %%%
% noise = zeros(size(t));
% 
% %%%
% M_StrtoForce = arx(iddata(f,strain),[1 1 0]);
% M_StrtoForce.Ts = Ts;
% M_StrtoForce = d2c(M_StrtoForce);
% fe = lsim(tf(M_StrtoForce),[strain noise],t);
% 
% slvFigure('Strain to Force');
% subplot(2,2,1)
% plot(t,strain,'b')
% subplot(2,2,3)
% hold off
% plot(t,f,'b')
% hold on
% plot(t,fe,'r')
% subplot(1,2,2)
% pzmap(tf(M_StrtoForce));
% M_StrtoForce
% 
% %%
% MEpanel = arx(iddata(sForce,obPos),[2 1 0]);
% MEpanel.Ts = Ts;
% MEpanel = d2c(MEpanel);
% damp(tf(MEpanel))
% 
% 
% %%
% slvFigure('MEpanel');
% hold off
% pzmap(tf(MEpanel));
% hold all
% pzmap(tf(Mpanel));
% 
% %% 
% in = obPos * 3000;
% Me_panel = arx(iddata(fe,in),[2 1 0]);
% Me_panel.Ts = Ts;
% MEpanel = d2c(Me_panel);
% slvFigure('ME_panel');
% clf
% plot(t,obPos, 'b.')
% hold on
% plot(t,in, 'b')
% plot(t,fe, 'r')
% 
% %% Sanity Check of Signals
% %%% Compare PC104 Acc to JR3
% slvFigure('Sanity');
% hold off
% pidx = find(PC104.DATA.time>0.5 & PC104.DATA.time<25);
% % pidx = 1:length(PC104.DATA.time);
% % plot(PC104.DATA.time(pidx),g*(PC104.DATA.CGAZ(pidx)+1),':b.')
% % hold on
% [b,a] = butter(2,0.15);
% plot(PC104.DATA.time(pidx),g*(filtfilt(b,a,PC104.DATA.CGAZ(pidx))+1),'b')
% hold on
% sidx = find(SENSOR.time>0.5 & SENSOR.time<25);
% % sidx = 1:length(SENSOR.time);
% % Currently there is a 30ms delay in the JR3 data
% plot(SENSOR.time(sidx)-0.030,g*filtfilt(b,a,SENSOR.linAcc(sidx,3)),'r')
% grid on
% ylabel('Acceleration (m/s^2)')
% xlabel('time (s)')
% pLabels = [{'PC104 CG Z-Acc'} {'JR3 Z-Acc'}];
% legend(pLabels);
% 
