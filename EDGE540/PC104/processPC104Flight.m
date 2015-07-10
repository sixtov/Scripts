%%
function PC104 = processPC104Flight(mask)
    PC104.RAW = [];
    PC104.EU = [];
    PC104.VN100 = [];
    PC104.GPS = [];
    PC104.MATRIX = [];

%%
    outFile = sprintf('PC104_%s.mat',mask);
    fList = dir(sprintf('%s*',mask));
    N = length(fList);
    %if N~=4 return; end

%%
    for i=1:N
        srcFile = fList(i).name;
        if exist('pc104','var'), clear pc104; end
        warning off all; load(srcFile,'pc104'); warning on all;
        if exist('pc104','var')
            if strfind(srcFile,'_F100_')    % RAW File
                disp('   Processing RAW data')
                csvFile = dir('*RAW_EU*.csv');
                csvFile = csvFile.name;
                PC104 = mapPC104Channels(pc104,csvFile);
            end
            if strfind(srcFile,'_F200_')    % VN100 File
                disp('   Processing VN100 data')
                PC104.VN100 = parseVN100(pc104.data);
            end
            if strfind(srcFile,'_F201_')    % GPS File
                disp('   Processing GPS data')
                PC104.GPS = parseGPS(pc104.data);
            end
        end
    end

%%
    save(outFile,'PC104');
    disp('   Done!')
return

