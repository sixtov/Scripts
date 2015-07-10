function p = VDCtoVrCal(ADCVolts,LoadTable,ridx,VexV,RgV,RlV,GFV,LV,ODV,IDV,EcV)
    syms   R GF Rl Rg Vex Vt ID OD Load L Ec;
    c = ID/2;
    M = Load*L;
    I = pi*(OD^4-ID^4)/64;
    Vr = Vt/Vex;

    Gauge.ueEq = 1e6*(-4*(1+Rl/Rg)/(2*GF))*Vr/(Vr + 1/2);
    Tube.ueEq = 1e6*(M*c)/(I*Ec);
    GFactor.ueEq = 1e6*(R-Rg)/(GF*Rg);
    
    Gauge.ue = subs(Gauge.ueEq,[{'Vex'} {'Rg'} {'Rl'} {'GF'}],[VexV RgV RlV GFV]);
    Tube.ue = subs(Tube.ueEq,[{'L'} {'OD'} {'ID'} {'Ec'}],[LV ODV IDV EcV]);
    GFactor.ue = subs(GFactor.ueEq,[{'Rg'} {'GF'}],[RgV GFV]);
    
    RTable = (348:0.5:352)';
    VtvREq = solve(Gauge.ue-GFactor.ue,Vt);
    VtvRTable = subs(VtvREq,'R',RTable);
    ueGFactor = subs(GFactor.ue,'R',RTable);
    disp('    R(ohms) Gauge(ue)   Vt(mV)')
    disp('---------------------------------------------------')
    disp([RTable ueGFactor 1e3*VtvRTable])
    
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
return
