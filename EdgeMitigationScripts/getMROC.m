%get ROC stats for a particular classifier coef given the known good and
%bad cases
function roc = getMROC (G,C,K,L,Q) 
    roc.K = K;
    roc.L = L;
    roc.Q = Q;
    
    % get stats on each group
    N = length(G);
    cnt = 0;
    for i=1:N
        if strcmp(G{i},C{i})
            cnt = cnt+1; 
        end
    end
    roc.ACC = cnt/N;
    return
