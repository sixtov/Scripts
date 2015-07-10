%% Loads Validation Data
clear
ulist = dir('MT_NoLoad*');
dlist = dir('MT_Load*');
uN = length(ulist);
dN = length(dlist);

up = [];
for i=1:uN
    d = getPc4Data(ulist(i).name);
    up = getParameters(up,[d.strn d.cgaz d.obaz d.ctaz]);
    ug(1:uN,1) = 'U';
end

dp = [];
for i=1:dN
    d = getPc4Data(dlist(i).name);
    dp = getParameters(dp,[d.strn d.cgaz d.obaz d.ctaz]);
    dg(1:dN,1) = 'D';
end

save('pFULL.mat','up','dp','ug','dg','uN','dN');

%% Setup Parameter-Signal Combinations
clear
load('pFULL.mat');
load('..\Training Data\rocFULL.mat');
tROC = roc;
clear roc;

validatingScript;
movefile('roc.mat','rocFULL.mat');
