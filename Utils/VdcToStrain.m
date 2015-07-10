function me = VdcToStrain(VDC,p,Vex,GF,Rl,Rg)
    if isempty(p)
        disp('Default settings for Left Tube Gauge')
        p = [0.001628466689456   0.001622702470746];
    end
    Vr = feval(p,VDC);
    top = (4*(1+Rl/Rg)/(2*GF))*Vr;
    bot = (Vr+Vex/2);
    me = 1e6* (top./bot);
return
