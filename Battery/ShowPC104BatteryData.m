%%
if (isfield(PC104.AD1,'RPM'))
    rAD = PC104.AD1;
end
if (isfield(PC104.AD2,'RPM'))
    rAD = PC104.AD2;
end

   
if (exist('rAD','var')==1)
    nRows = 3;
    pn = 3;
    subplot(nRows,1,1)
    hold off
    plot(rAD.time,rAD.RPM)
    hold all
    grid on
else
    nRows = 2;
    pn = 1;
end

if (isfield(PC104.AD1,'URA40V'))
    bAD = PC104.AD1;
end
if (isfield(PC104.AD2,'URA40V'))
    bAD = PC104.AD2;
end

subplot(nRows,2,pn)
hold off
plot(bAD.time,bAD.ULA20V)
hold all
plot(bAD.time,bAD.ULA20C)
grid on
ylim([0 120])
title('ULA20')

subplot(nRows,2,pn+1)
hold off
plot(bAD.time,bAD.URA40V)
hold all
plot(bAD.time,bAD.URA40C)
grid on
ylim([0 120])
title('URA40')

subplot(nRows,2,pn+2)
hold off
plot(bAD.time,bAD.LLF20V)
hold all
plot(bAD.time,bAD.LLF20C)
grid on
ylim([0 120])
title('LLF20')

subplot(nRows,2,pn+3)
hold off
plot(bAD.time,bAD.LRF40V)
hold all
plot(bAD.time,bAD.LRF40C)
grid on
ylim([0 120])
title('LRF40')


