%%
class = [];
dlist = [];

class = [class; {'No Damage'}];
dlist = [dlist; {[ ...
            {'MT_NoLoadSine'}; ...
           ]}];
       
class = [class; {'Tip Load'}];
dlist = [dlist; {[ ...
            {'MT_Load250g_Tip_BLWN_01'}; ...
           ]}];
       
class = [class; {'OBCTR Load'}];
dlist = [dlist; {[ ...
            {'MT_Load250g_OBCTR_BLWN_01'}; ...
           ]}];
       
N = length(dlist);
for i=1:N
    dN(i) = length(dlist{i});
end

save('dList.mat','dlist','class','dN');
MT_D_05LoadBLWN_01         
MT_D_05LoadBLWN_02         
MT_D_05LoadSine_01         
MT_D_05LoadSine_02         
MT_D_10LoadBLWN_01         
MT_D_10LoadBLWN_02         
MT_D_10LoadSine_01         
MT_D_10LoadSine_02         
MT_D_15LoadBLWN_01         
MT_D_15LoadBLWN_02         
MT_D_15LoadSine_01         
MT_D_15LoadSine_02         
MT_D_25LoadSine_01         
MT_D_25LoadSine_02         
MT_D_50LoadSine_01         
MT_D_50LoadSine_02         

MT_D_Load530g_FastSine_01  
MT_D_Load530g_FastSine_02  
MT_D_Load530g_FastSine_03  
MT_D_Load530g_SlowSine_01  
MT_D_Load530g_SlowSine_02  
MT_D_Load530g_SlowSine_03  

MT_D_LoadDive_01           
MT_D_LoadDive_02           
MT_D_LoadDive_03           
MT_D_LoadDive_04           
MT_D_LoadDive_05           
MT_D_LoadDive_06           
MT_D_LoadDive_07           
MT_D_LoadDive_08           
MT_D_LoadDive_09           
MT_D_LoadDive_10           

MT_D_LoadSine_01           
MT_D_LoadSine_02           
MT_D_LoadSine_03           
MT_D_LoadSine_04           
MT_D_LoadSine_05           
MT_D_LoadSine_06           
MT_D_LoadSine_07           
MT_D_LoadSine_08           
MT_D_LoadSine_09           
MT_D_LoadSine_10           

MT_U_NoLoadBLWN_01         
MT_U_NoLoadBLWN_02         
MT_U_NoLoadBLWN_03         
MT_U_NoLoadDive_01         
MT_U_NoLoadDive_02         
MT_U_NoLoadDive_03         
MT_U_NoLoadDive_04         
MT_U_NoLoadDive_05         
MT_U_NoLoadDive_06         
MT_U_NoLoadDive_07         
MT_U_NoLoadDive_08         
MT_U_NoLoadDive_09         
MT_U_NoLoadDive_10         
MT_U_NoLoadSine_01         
MT_U_NoLoadSine_02         
MT_U_NoLoadSine_03         
MT_U_NoLoadSine_04         
MT_U_NoLoadSine_05         
MT_U_NoLoadSine_06         
MT_U_NoLoadSine_07         
MT_U_NoLoadSine_08         
MT_U_NoLoadSine_09         
MT_U_NoLoadSine_10         
MT_U_NoLoadSine_11         
MT_U_NoLoadSine_12         
MT_U_NoLoadSine_13         
MT_U_NoLoadSine_14         
MT_U_NoLoadSine_15         
MT_U_NoLoadSine_16         
MT_U_NoLoadSine_17         
MT_U_NoLoad_FastSine_01    
MT_U_NoLoad_FastSine_02    
MT_U_NoLoad_FastSine_03    
MT_U_NoLoad_SlowSine_01    
MT_U_NoLoad_SlowSine_02    
MT_U_NoLoad_SlowSine_03    
