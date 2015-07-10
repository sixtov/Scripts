%% Test TwoTailedTest 
clear
pColor = {':b.',':r.',':c.',':m.'};
dlist = dir('MT*000*');
load (sprintf('%s\\PC104.mat', dlist.name));
known = PC104.DATA.CANOBAZ;

%%
TwoTailedDiagnosis (known, known, ':y.', 0);

%%
dlist = dir('MT_50g_*');

for i=1:length(dlist)
    load (sprintf('%s\\PC104.mat', dlist(i).name));
    unknown = PC104.DATA.CANOBAZ;
    TwoTailedDiagnosis (known, unknown, pColor{i}, 1);
end
