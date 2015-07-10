function pArray = extractParameters(p,pList)
    N = length(pList);
    count = 0;
    for i=1:N
        if isfield(p,pList{i})
            count = count+1;
            if count==1
                %pArray.uni = p.(pList{i}).uni;
                %pArray.bip = p.(pList{i}).bip;
                pArray = p.(pList{i});
                %names = fieldnames(pArray.bip);
                names = fieldnames(pArray);
                M = length(names);
            else
                %pArray.uni = appendItems(pArray.uni,p.(pList{i}).uni,names,M);
                %pArray.bip = appendItems(pArray.bip,p.(pList{i}).bip,names,M);
                pArray = appendItems(pArray,p.(pList{i}),names,M);
            end
        end
    end
    
    %% Keep delLim bounded to 3
    if isfield(pArray,'delLim_low')
        pArray.delLim_low(abs(pArray.delLim_low)>3) = sign(pArray.delLim_low(abs(pArray.delLim_low)>3))*3;
    end
    if isfield(pArray,'delLim_hi')
        pArray.delLim_hi(abs(pArray.delLim_hi)>3) = sign(pArray.delLim_hi(abs(pArray.delLim_hi)>3))*3;
    end
return

function pArray = appendItems(pArray,p,names,M)
    for j=1:M
        pArray.(names{j}) = [pArray.(names{j}) p.(names{j})];
    end
return