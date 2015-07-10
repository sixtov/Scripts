function S = appendStructDataPoint(S1,Sp)
    S = [];
    S1e = isempty(S1);
    Spe = isempty(Sp);
    
    % if both empty, return
    if (S1e && Spe), return; end
    
    % if new data point is empty, return original structure
    if (Spe), S = S1; return; end
    
    % if original structure is empty, return new data point
    if (S1e), S = Sp; return; end
    
    % if function reached here, none are empty, but need to check that they
    % are structures and they are the same structure
    if (isstruct(S1)), S1_names = fieldnames(S1); else S1_names = []; end
    if (isstruct(Sp)), Sp_names = fieldnames(Sp); else Sp_names = []; end
    
    % will assume for now that S1_names and Sp_names are not empty
    N = length(S1_names);
    M = length(Sp_names);
    if (N ~= M), return; end
    
    for i=1:N
        if (~strcmp(S1_names{i}, Sp_names{i})), return; end
    end
    
    % Ready to copy new data into existing structure
    for i=1:N
        S.(S1_names{i}) = [S1.(S1_names{i}); Sp.(Sp_names{i})];
    end
return
