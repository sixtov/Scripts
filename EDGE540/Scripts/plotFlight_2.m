function plotFlight_2()
    file = dir('PC104.mat');
    if ~isempty(file)
        load(file.name)
        plotStructure('PC104',PC104);
    end
    
    file = dir('RCATS.mat');
    if ~isempty(file)
        load(file.name)
        plotStructure('RCATS',RCATS);
    end
    
    file = dir('AHRS.mat');
    if ~isempty(file)
        load(file.name)
        plotStructure('AHRS',AHRS);
    end

return
    
