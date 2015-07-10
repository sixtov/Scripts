function [myTok dArray sidx] = getLineTokens(dArray,tokSep,startLineChar,endLineChar)
    tArray = char(dArray);
    % '$' == 36
    sidx = find(tArray(1:end)==startLineChar,1,'first');
    eidx = find(tArray(sidx+1:end)==endLineChar  ,1,'first')+sidx-1;
    didx = find(tArray(sidx+1:end)==startLineChar,1,'first')+sidx-1;
    fidx = min(eidx,didx);
    
    tline = tArray(sidx:fidx)';
    dline = dArray(sidx:fidx)';
    tf = isstrprop(tline, 'print');
    tline = tline(tf);
    dline = dline(tf);
    %disp(dline)
    disp(sprintf('>%s<',tline))
    
    myTok = {};
    while ~isempty(tline)
        [aTok tline] = strtok(tline,tokSep);
        myTok = [myTok {aTok}];
    end

    dArray = dArray(fidx+1:end);
return

