%% Loads Training Data
clear
ulist = dir('MT_U*');
dlist = dir('MT_D*');
uN = length(ulist);
dN = length(dlist);

up = [];
for i=1:uN
    d = getPc4Data(ulist(i).name);
    up = getParameters(up,[d.strn d.cgaz d.obaz d.ctaz],[{'strn'} {'cgaz'} {'obaz'} {'ctaz'}]);
end
ug(1:uN,1) = 'U';

dp = [];
for i=1:dN
    d = getPc4Data(dlist(i).name);
    dp = getParameters(dp,[d.strn d.cgaz d.obaz d.ctaz],[{'strn'} {'cgaz'} {'obaz'} {'ctaz'}]);
end
dg(1:dN,1) = 'D';

save('pFULL.mat','up','dp','ug','dg','uN','dN');

%%
clear
load('pFULL.mat');
trainingScript;
movefile('roc.mat','rocFULL.mat');
