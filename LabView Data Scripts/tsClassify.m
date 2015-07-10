function [o] = tsClassify (dCase, Fs, decimation, filterLimit, winTime, verbose)
%clear
dCases = dir(sprintf('%s\\PC104.mat', dCase));
if ~isempty(dCases)
    load (sprintf('%s\\PC104.mat', dCase));
    pc104T1 = PC104.DATA;
else
    o = [];
    return;
end

% simFile = dir(sprintf('%s\\*sim.mat',dCase));
% temp = load (sprintf('%s\\%s', dCase, simFile.name));
% simT1.ell = temp.ELLOB.signals.values;
% simT1.time = temp.TimeStamp.signals.values;
% simT1.cgaz = temp.nzbody.signals.values(:);
% clear temp;
% clear simFile;

%%%
% decimation = 5;
% filterLimit = 0.2;
% Fs = 200;  %Hz
Fdec = Fs/decimation;

time = decimate(pc104T1.time,decimation); 
cgaz = preprocess_data(pc104T1.CGAZ, decimation, filterLimit);
ibaz = preprocess_data(pc104T1.CANIBAZ, decimation, filterLimit);
ctaz = preprocess_data(pc104T1.CANCTRAZ, decimation, filterLimit);
obaz = preprocess_data(pc104T1.CANOBAZ, decimation, filterLimit);
fs = pc104T1.FSTRB*1e6;
as = pc104T1.AFTSTRB*1e6;
str = mean([fs as],2);
str = preprocess_data(str, decimation, filterLimit);
tload = strain2Load(str);
%%%
ti = find(time>.25);
cgaz = cgaz(ti);
ibaz = ibaz(ti);
ctaz = ctaz(ti);
obaz = obaz(ti);
str = str(ti);
tload = tload(ti);
time = time(ti);
%%%

slvFigure (sprintf('Mitigation %s: Strain, OBaz, CGaz', dCase));
h(1)=subplot(2,1,1);
plot(time, str, 'm')
legend([{'Strain'}], 'Location','Best');
h(2)=subplot(2,1,2);
hold off
plot(time, obaz, 'b')
hold on
plot(time, cgaz, 'r')
xlabel('time(s)')
legend([{'OBaz'} {'CGaz'}], 'Location','Best');
%legend on
linkaxes(h,'x')

slvFigure (sprintf('Mitigation %s: str and equiv. tip load', dCase));
hold off
h(1) = subplot (2,1,1);
plot(obaz, str,  'b.')
xlim ([min(obaz) max(obaz)])
ylim ([min(str) max(str)])
xlabel('OBaz')
Ylabel('strain')
grid on
h(2) = subplot (2,1,2);
plot(str, tload, 'b.')
ylim ([min(tload) max(tload)])
xlim ([min(str) max(str)])
xlabel('strain')
Ylabel('Tip Load')
grid on

%%% Window signal in time domain
% winTime = 10;
winSize = winTime*Fdec;
n = floor(length(str)/winSize)*winSize;
Dcnt = 0;
Ucnt = 0;
dF = zeros(length(str),1);
df = ones(winSize,1);
j = 0;
for i = 1:winSize:n
    j = j + 1;
    b = i;
    e = i+winSize-1;
    [p(j) d] = getParameters(Fdec, str(b:e), obaz(b:e));
    [s(j)] = classifyUsingParams( p(j).lf_w,  p(j).lf_freq  ...
                                , p(j).lf_c,  p(j).pole1_a  ...
                                , p(j).slope, p(j).lf_w     ...
                                 , [],  []                  ...
                             );
    dF(b:e) = df * s(j).dFlag;
    if (verbose)
        disp(sprintf('%3.3d) [%6.3f %6.3f %6.3f] [%6.3f] [%c] [%d]',i,[s(j).y1 s(j).y2 s(j).y3],s(j).state, s(j).group, s(j).dFlag))
    end
    if (s(j).dFlag)
      Dcnt = Dcnt + 1;
    else
      Ucnt = Ucnt + 1;
    end
end;
slvFigure (sprintf('Mitigation %s: Strain, OBaz, CGaz', dCase));
hold on
plot(time, dF*max(obaz), 'g')

Tcnt = Dcnt + Ucnt;
o.Ucnt = Ucnt;
o.Dcnt = Dcnt;
o.s = s;
o.p = p;
o.time = time;
o.cgaz = cgaz;
o.obaz = obaz;
o.str = str;
o.tload = tload;
% o.sim = simT1;
o.dF = dF;
%disp('')
disp (sprintf('----%s:  Total[%6.3f] U[%6.3f/%4.1f%%] D[%6.3f/%4.1f%%]'     ...
             ,dCase,      Tcnt, Ucnt,100*Ucnt/Tcnt,Dcnt,100*Dcnt/Tcnt))

return


