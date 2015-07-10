function me = strain(Vch,Vo,Vex,GF,Rl,Rg)
    Vr = (Vch-Vo)/Vex;
    top = 4*(1+Rl/Rg)*Vr;
    bot = GF*(1+2*Vr);
    me = 1e6* (top./bot);
return
