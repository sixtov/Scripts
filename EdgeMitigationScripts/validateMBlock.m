%%
clear
load dList

%%
WS = 20000;
plist = cell(N,1);
for k=1:N
    cnt = 0;
    for i=1:dN(k)
        d = getPc4Data(dlist{k}{i});
        NB = floor(length(d.strn)/WS);
        if NB == 0, NB=1; BS=length(d.strn); else BS=WS; end
        for j=1:NB
            si = (j-1)*BS+1;
            ei = si+BS-1;
            plist{k} = getParameters(plist{k},[d.strn(si:ei) d.cgaz(si:ei) d.obaz(si:ei) d.ctaz(si:ei)]);
            cnt = cnt+1;
            clist{k}{cnt,1} = class{k};
        end
    end
    dN(k) = cnt;
end
clist = clist(:);

save('pMBLOCK.mat' ,'dlist','plist','clist','dN');

%% Setup Parameter-Signal Combinations
clear
load('pMBLOCK.mat');
load('..\Training Data\rocBLOCK.mat');
tROC = roc;
clear roc;

validatingScript;
movefile('roc.mat','rocBLOCK.mat');
