%% Searches all folders matching MASK for *.mat files
 %% creates a folder for each '.mat' file and copies
 %% all files matching the file rootname into the newly
 %% created folder.
 
MASK = '2010*SFDI';
dList = dir(MASK);
N = length(dList);

for i=1:N
    if dList(i).isdir
        source = sprintf('%s\\*.mat',dList(i).name);
        fList = dir(source);
        M = length(fList);
        for j=1:M
            dName = fList(j).name(1:end-4);
            cList = dir(dName);
            if isempty(cList)
                mkdir(dName);
            end
            source = sprintf('%s\\%s.*',dList(i).name,dName);
            copyfile(source,dName);
        end
    end
end

