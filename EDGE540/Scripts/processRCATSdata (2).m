function processRCATSdata()
    %%% Process RCATS data files
    rcats_file = dir('RCATS*.log');

    if ~isempty(rcats_file)
        [RCATS.DATA RCATS.GPS] = decodeRCATS(rcats_file.name);
    end
    if exist('RCATS','var')
        save('RCATS.mat','RCATS');
    end
return
