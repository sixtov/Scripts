%% Loads Training Data
clear
ulist = dir('MT_U*');
dlist = dir('MT_D*');
uN = length(ulist);
dN = length(dlist);
WS = 2000;
up = [];
cnt = 0;
for i=1:uN
    d = getPc4Data(ulist(i).name);
    NB = floor(length(d.strn)/WS);
    for j=1:NB
        si = (j-1)*WS+1;
        ei = si+WS-1;
        up = getParameters(up,[d.strn(si:ei) d.cgaz(si:ei) d.obaz(si:ei) d.ctaz(si:ei)]);
        cnt = cnt+1;
        ug(cnt,1) = 'U';
    end
end
uN = cnt;

dp = [];
cnt = 0;
for i=1:dN
    d = getPc4Data(dlist(i).name);
    NB = floor(length(d.strn)/WS);
    for j=1:NB
        si = (j-1)*WS+1;
        ei = si+WS-1;
        dp = getParameters(dp,[d.strn(si:ei) d.cgaz(si:ei) d.obaz(si:ei) d.ctaz(si:ei)]);
        cnt = cnt+1;
        dg(cnt,1) = 'D';
    end
end
dN = cnt;

save('pBLOCK.mat','up','dp','ug','dg','uN','dN');

%% Setup Parameter-Signal Combinations
clear
load('pBLOCK.mat');
trainingScript;
movefile('roc.mat','rocBLOCK.mat');
