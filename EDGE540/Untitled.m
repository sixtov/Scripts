%% Tube 0
load('.mat','pc104');
LoadTable = [];
ridx = {;           ;        ;};
    
Left   = pc104.data(:,4);
Center = pc104.data(:,5);
Right  = pc104.data(:,6);

disp('Left Gauge')
T0.VDCtoVrCoeff.Left   = VDCtoVrCal(Left  ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

disp('Center Gauge')
T0.VDCtoVrCoeff.Center = VDCtoVrCal(Center,LoadTable,ridx,5,350,0.7,2.09,38.175/2,1.574,1.457,10.1e6);

disp('Right Gauge')
T0.VDCtoVrCoeff.Right  = VDCtoVrCal(Right ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

LStrain = VdcToStrain(Left  ,T0.VDCtoVrCoeff.Left  ,5,2.09,0.7,350);
CStrain = VdcToStrain(Center,T0.VDCtoVrCoeff.Center,5,2.09,0.7,350);
RStrain = VdcToStrain(Right ,T0.VDCtoVrCoeff.Right ,5,2.09,0.7,350);
plot([LStrain CStrain RStrain]); grid on

%% Tube 1
load('EDGE540R2_TubeT1_onR2Airframe_Cal_F100_072610_1615.mat','pc104');
LoadTable = [0; 10; 15; 20; 25; 30; 35; 40; 45; 50; 45; 40; 35; 30; 25; 20; 15; 10; 0];
ridx = {100:5945;           16900:22720;        24040:27080;
        29570:33150;        33940:36760;        38570:41540;
        43450:46610;        48380:51580;        53990:58250;
        62880:79700;        80960:84980;        85700:90350;
        91440:95180;        96170:99710;        100400:105500;
        106400:110200;      113000:116600;      117300:119800;
        123800:129400};
    
Left   = pc104.data(:,4);
Center = pc104.data(:,5);
Right  = pc104.data(:,6);

disp('Left Gauge')
T1.VDCtoVrCoeff.Left   = VDCtoVrCal(Left  ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

disp('Center Gauge')
T1.VDCtoVrCoeff.Center = VDCtoVrCal(Center,LoadTable,ridx,5,350,0.7,2.09,38.175/2,1.574,1.457,10.1e6);

disp('Right Gauge')
T1.VDCtoVrCoeff.Right  = VDCtoVrCal(Right ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

LStrain = VdcToStrain(Left  ,T1.VDCtoVrCoeff.Left  ,5,2.09,0.7,350);
CStrain = VdcToStrain(Center,T1.VDCtoVrCoeff.Center,5,2.09,0.7,350);
RStrain = VdcToStrain(Right ,T1.VDCtoVrCoeff.Right ,5,2.09,0.7,350);
plot([LStrain CStrain RStrain]); grid on

%% Tube 2
load('EDGE540R1_TUBET3_CalTubeOnly_0to180LBS_081010_1052.mat','pc104');
% LoadTable = [0; 10; 20; 30; 40; 60; 70; 80; 90; 80; 70; 60; 40; 30; 20; 10; 0];
% ridx = { 7175:15130;        19230:23530;        24760:28040;
%         30010:33050;        34490:37570;        39300:43380;
%         46360:49240;        51060:54360;        56060:65490;
%         66830:69210;        70460:72270;        73500:76000;
%         76900:80600;        81520:84610;        85500:87580;
%         88700:91240;        93330:100200};
    
Left   = pc104.data(:,4);
Center = pc104.data(:,5);
Right  = pc104.data(:,6);

disp('Left Gauge')
T2.VDCtoVrCoeff.Left   = VDCtoVrCal(Left  ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

disp('Center Gauge')
T2.VDCtoVrCoeff.Center = VDCtoVrCal(Center,LoadTable,ridx,5,350,0.7,2.09,38.175/2,1.574,1.457,10.1e6);

disp('Right Gauge')
T2.VDCtoVrCoeff.Right  = VDCtoVrCal(Right ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

LStrain = VdcToStrain(Left  ,T2.VDCtoVrCoeff.Left  ,5,2.09,0.7,350);
CStrain = VdcToStrain(Center,T2.VDCtoVrCoeff.Center,5,2.09,0.7,350);
RStrain = VdcToStrain(Right ,T2.VDCtoVrCoeff.Right ,5,2.09,0.7,350);
plot([LStrain CStrain RStrain]); grid on

%% Tube 3
load('EDGE540R1_TUBET3_CalTubeOnly_0to180LBS_081010_1052.mat','pc104');
LoadTable = [0; 10; 20; 30; 40; 60; 70; 80; 90; 80; 70; 60; 40; 30; 20; 10; 0];
ridx = { 7175:15130;        19230:23530;        24760:28040;
        30010:33050;        34490:37570;        39300:43380;
        46360:49240;        51060:54360;        56060:65490;
        66830:69210;        70460:72270;        73500:76000;
        76900:80600;        81520:84610;        85500:87580;
        88700:91240;        93330:100200};
    
Left   = pc104.data(:,4);
Center = pc104.data(:,5);
Right  = pc104.data(:,6);

disp('Left Gauge')
T3.VDCtoVrCoeff.Left   = VDCtoVrCal(Left  ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

disp('Center Gauge')
T3.VDCtoVrCoeff.Center = VDCtoVrCal(Center,LoadTable,ridx,5,350,0.7,2.09,38.175/2,1.574,1.457,10.1e6);

disp('Right Gauge')
T3.VDCtoVrCoeff.Right  = VDCtoVrCal(Right ,LoadTable,ridx,5,350,0.7,2.09,12      ,1.574,1.457,10.1e6);

LStrain = VdcToStrain(Left  ,T3.VDCtoVrCoeff.Left  ,5,2.09,0.7,350);
CStrain = VdcToStrain(Center,T3.VDCtoVrCoeff.Center,5,2.09,0.7,350);
RStrain = VdcToStrain(Right ,T3.VDCtoVrCoeff.Right ,5,2.09,0.7,350);
plot([LStrain CStrain RStrain]); grid on

%% Gauge Factor Eq
Rg = 350;
GF = 2.09;
R = (348:0.5:352)';
e = 1e6*(R-Rg)/(GF*Rg);
hold off
plot(R,e,':o','MarkerFaceColor','b'); grid on
vxlabel('Gauge Resistance (ohms)')
vylabel('\mustrain')
lText = [{'e = 1e6*(R-Rg)/(GF*Rg)'};
         {sprintf('where: Rg=%d',Rg)};
         {sprintf('and    GF=%.2f',GF)}];
text((2*min(R)+2*max(R))/4,(max(e)+3*min(e))/4,lText,'BackgroundColor',0.98*[1 1 1],'Margin',5,'FontName','Courier');

format long
disp(sprintf('%.1f    %.0f\n',[R e]'))
disp(sprintf('%.1f\n',R))
disp(sprintf('%.0f\n',e))
format short

%%
    clear

    %% Constants
    VexV = 5;
    RgV = 350;
    RlV = 0.7;
    GFV = 2.09;
    IDV = 1.457;
    ODV = 1.574;
    EcV = 10.1e6;
    LV = 12;

    %% Equations
    syms   R GF Rl Rg Vex Vt ID OD Load L Ec ue;
    c = ID/2;
    M = Load*L;
    I = pi*(OD^4-ID^4)/64;
    Vr = Vt/Vex;

    Gauge.ueEq = 1e6*(-4*(1+Rl/Rg)/(2*GF))*Vr/(Vr + 1/2);
    Gauge.ue = subs(Gauge.ueEq,[{'Vex'} {'Rg'} {'Rl'} {'GF'}],[VexV RgV RlV GFV]);

    %Tube.ueEq = 1e6*(M*c)/(I*Ec);
    %Tube.ue = subs(Tube.ueEq,[{'L'} {'OD'} {'ID'} {'Ec'}],[LV ODV IDV EcV]);

    GFactor.ueEq = 1e6*(R-Rg)/(GF*Rg);
    GFactor.ue = subs(GFactor.ueEq,[{'Rg'} {'GF'}],[RgV GFV]);

    VtvREq = solve(Gauge.ue-GFactor.ue,Vt);
    VtvGaugeue = solve(Gauge.ue-ue,Vt);
    RTable = (348:0.5:352)';
    ueRTable = subs(GFactor.ue,'R',RTable);

    VtTable = subs(VtvREq,'R',RTable);
    ueTable = subs(Gauge.ue,'Vt',VtTable);
    
    disp(sprintf('Results for GF=%f',GFV))
    disp('Gauge.ue =')
    disp(Gauge.ue)
    disp('GFactor.ue =')
    disp(GFactor.ue)
    disp('Vt =')
    disp(VtvREq)
    disp('Vt =')
    disp(VtvGaugeue)
    
    disp('    R(ohms) Gauge(ue)   Bridge(ue)   Vt(mV)')
    disp('---------------------------------------------------')
    disp([RTable ueRTable ueTable 1e3*VtTable])
    disp('Resistance (ohms)')
    disp(RTable)
    disp('Gauge \mu\epsilon')
    disp(ueRTable)
    disp('Bridge Voltage (mV)')
    disp(1e3*VtTable)
    
%%
    VtvLoadEq = solve(Gauge.ue-Tube.ue,Vt);
    ueTube = subs(Tube.ue,'Load',LoadTable);
    VtTable = subs(VtvLoadEq,'Load',LoadTable);
    ueGauge = subs(Gauge.ue,'Vt',VtTable);

    %% Get Raw Strain (volts) at Loads
    VDC = [];
    for i=1:length(LoadTable)
        VDC = [VDC; mean(ADCVolts(ridx{i}))];
    end
    disp('    Load(lb) Tube(ue) Gauge(ue)   Vt(mV)    VDC(V)')
    disp('---------------------------------------------------')
    disp([LoadTable ueTube ueGauge 1e3*VtTable VDC])
    p = fit(VDC,VtTable,'poly2');
    disp('Use the following slope and intercept for this channel')
    format long
    disp(p)
    format short

    hold off
    plot(VDC,VtTable,'bo')
    hold on
    plot(VDC,feval(p,VDC),'r')
    grid on
