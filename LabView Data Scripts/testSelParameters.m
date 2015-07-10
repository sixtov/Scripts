%%
function clss = testSelParameters()
    %% Using roc(41)  (lf_w vs lf_freq)
    %% Using roc(36)  (lf_c vs pole1_a)
    %% Using roc(16)  (slope vs lf_w)
 
    %% Start of set
    set = [              ...
           {'lf_w'}; ...
           {'lf_freq'}; ...
           {'lf_c'}; ...
           {'pole1_a'}; ...
           {'slope'}; ...
           {'lf_w'}; ...
      ];
    %% End of set
%%
tdata = getClassifyTrainingData();
    
%%
    [SET group] = getClassifierSet (tdata.NLSN, set,  [],    [], 'U');
    [SET group] = getClassifierSet (tdata.NLDV, set, SET, group, 'U');
    [SET group] = getClassifierSet (tdata.NLWN, set, SET, group, 'U');
    [SET group] = getClassifierSet (tdata.NLFS, set, SET, group, 'U');
    [SET group] = getClassifierSet (tdata.NLSS, set, SET, group, 'U');

    [SET group] = getClassifierSet (tdata.LSN,  set, SET, group, 'D');
    [SET group] = getClassifierSet (tdata.LDV,  set, SET, group, 'D');
    [SET group] = getClassifierSet (tdata.LWN,  set, SET, group, 'D');
    [SET group] = getClassifierSet (tdata.LFS,  set, SET, group, 'D');
    [SET group] = getClassifierSet (tdata.LSS,  set, SET, group, 'D');

%%
    clss = classifyUsingParams( ...
                                SET(:,1), ...
                                SET(:,2), ...
                                SET(:,3), ...
                                SET(:,4), ...
                                SET(:,5), ...
                                SET(:,6), ...
                                group, ...
                                tdata.list ...
                              );
    clss = evalClass(clss);
%%
return