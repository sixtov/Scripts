function CreateMultipleFolders(rootName,si,ei)
    for i=si:ei
        dName = sprintf('%s_%02d',rootName,i);
        mkdir(dName);
    end
return
