%%
set = [              ...
        {roc(41).px}; ...
        {roc(41).py}; ...
        {roc(30).px}; ...
        {roc(30).py}; ...
        {roc(36).px}; ...
        {roc(36).py} ...
      ];
%%function clss = do(set)
%%
disp(sprintf('Evaluating Parameters in working directory\n%s',pwd))
%%%   
    load('Parameter.mat');
    pList = [...
             {'MT_LoadDive_01'} ...
             {'MT_LoadDive_02'} ...
             {'MT_LoadDive_03'} ...
             {'MT_LoadDive_04'} ...
             {'MT_LoadDive_05'} ...
             {'MT_LoadDive_06'} ...
             {'MT_LoadDive_07'} ...
             {'MT_LoadDive_08'} ...
             {'MT_LoadDive_09'} ...
             {'MT_LoadDive_10'} ...
             ];
    LDV = extractParameters(p,pList);
  
    pList = [...
             {'MT_05LoadSine_01'} ...
             {'MT_05LoadSine_02'} ...
             {'MT_10LoadSine_01'} ...
             {'MT_10LoadSine_02'} ...
             {'MT_15LoadSine_01'} ...
             {'MT_15LoadSine_02'} ...
             {'MT_25LoadSine_01'} ...
             {'MT_25LoadSine_02'} ...
             {'MT_50LoadSine_01'} ...
             {'MT_50LoadSine_02'} ...
             {'MT_LoadSine_01'} ...
             {'MT_LoadSine_02'} ...
             {'MT_LoadSine_03'} ...
             {'MT_LoadSine_04'} ...
             {'MT_LoadSine_05'} ...
             {'MT_LoadSine_06'} ...
             {'MT_LoadSine_07'} ...
             {'MT_LoadSine_08'} ...
             {'MT_LoadSine_09'} ...
             {'MT_LoadSine_10'} ...
             ];
    LSN = extractParameters(p,pList);

    pList = [...
             {'MT_NoLoadDive_01'} ...
             {'MT_NoLoadDive_02'} ...
             {'MT_NoLoadDive_03'} ...
             {'MT_NoLoadDive_04'} ...
             {'MT_NoLoadDive_05'} ...
             {'MT_NoLoadDive_06'} ...
             {'MT_NoLoadDive_07'} ...
             {'MT_NoLoadDive_08'} ...
             {'MT_NoLoadDive_09'} ...
             {'MT_NoLoadDive_10'} ...
             ];
    NLDV = extractParameters(p,pList);
   
    pList = [...
             {'MT_NoLoadSine_01'} ...
             {'MT_NoLoadSine_02'} ...
             {'MT_NoLoadSine_03'} ...
             {'MT_NoLoadSine_04'} ...
             {'MT_NoLoadSine_05'} ...
             {'MT_NoLoadSine_06'} ...
             {'MT_NoLoadSine_07'} ...
             {'MT_NoLoadSine_08'} ...
             {'MT_NoLoadSine_09'} ...
             {'MT_NoLoadSine_10'} ...
             {'MT_NoLoadSine_11'} ...
             {'MT_NoLoadSine_12'} ...
             {'MT_NoLoadSine_13'} ...
             {'MT_NoLoadSine_14'} ...
             {'MT_NoLoadSine_15'} ...
             {'MT_NoLoadSine_16'} ...
             {'MT_NoLoadSine_17'} ...
            ];
    NLSN = extractParameters(p,pList);

    pList = [...
             {'MT_05LoadBLWN_01'} ...
             {'MT_05LoadBLWN_02'} ...
             {'MT_10LoadBLWN_01'} ...
             {'MT_10LoadBLWN_02'} ...
             {'MT_15LoadBLWN_01'} ...
             {'MT_15LoadBLWN_02'} ...
             ];
    LWN = extractParameters(p,pList);

    pList = [...
             {'MT_NoLoadBLWN_01'} ...
             {'MT_NoLoadBLWN_02'} ...
             {'MT_NoLoadBLWN_03'} ...
             ];
    NLWN = extractParameters(p,pList);
    
     pList = [...
             {'MT_NoLoad_FastSine_01'} ...
             {'MT_NoLoad_FastSine_02'} ...
             {'MT_NoLoad_FastSine_03'} ...
             ];
    NLFS = extractParameters(p,pList);
   
    pList = [...
             {'MT_NoLoad_SlowSine_01'} ...
             {'MT_NoLoad_SlowSine_02'} ...
             {'MT_NoLoad_SlowSine_03'} ...
             ];
    NLSS = extractParameters(p,pList);
    
    pList = [...
             {'MT_Load530g_FastSine_01'} ...
             {'MT_Load530g_FastSine_02'} ...
             {'MT_Load530g_FastSine_03'} ...
             ];
    LFS = extractParameters(p,pList);
    
    pList = [...
             {'MT_Load530g_SlowSine_01'} ...
             {'MT_Load530g_SlowSine_02'} ...
             {'MT_Load530g_SlowSine_03'} ...
             ];
    LSS = extractParameters(p,pList);
    
%%
    [SET group] = getClassifierSet (NLSN, set,  [],    [], 'U');
    [SET group] = getClassifierSet (NLDV, set, SET, group, 'U');
    [SET group] = getClassifierSet (NLWN, set, SET, group, 'U');
    [SET group] = getClassifierSet (NLFS, set, SET, group, 'U');
    [SET group] = getClassifierSet (NLSS, set, SET, group, 'U');

    [SET group] = getClassifierSet (LSN,  set, SET, group, 'D');
    [SET group] = getClassifierSet (LDV,  set, SET, group, 'D');
    [SET group] = getClassifierSet (LWN,  set, SET, group, 'D');
    [SET group] = getClassifierSet (LFS,  set, SET, group, 'D');
    [SET group] = getClassifierSet (LSS,  set, SET, group, 'D');

%%
    clss = classifyUsingParams(SET(:,1),SET(:,2),SET(:,3),SET(:,4),SET(:,5),SET(:,6),group);
    clss = evalClass(clss);
%%
return