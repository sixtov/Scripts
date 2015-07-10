%% createEDGEStructure
%% RCATS Decoding
    rList = dir('*.log');
    N = length(rList);
    for i=1:N
        matFileExist = logical(length(dir(sprintf('%s*.mat',rList(i).name(1:end-4)))));
        if ~matFileExist
            sFile = decodeRCATS(rList(i).name);
            %load(sFile);
            %plotFlight();
        end
    end
    clear

%% PC104 Decoding
    pList = dir('*_F100*.mat');
    N = length(pList);
    disp(sprintf('Found %d _F100 PC104 files',N))
    for i=1:N
        mask = pList(i).name(1:strfind(pList(i).name,'_F100')-1);
        matFileExist = logical(length(dir(sprintf('PC104_%s.mat',mask))));
        if ~matFileExist
            processPC104Flight(mask);
        end
    end
    clear

%%
    SyncRCATSandPC104byFlightNum(15);
    
%%
    SyncRCATSandPC104byFlightNum(8);
    SyncRCATSandPC104byFlightNum(9);
    SyncRCATSandPC104byFlightNum(10);
        