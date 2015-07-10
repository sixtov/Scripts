function processAHRSdata()
    %%% Process AHRS data files
    ahrs_file = dir('*AHRS_data.csv');
    gps_file = dir('*GPS.csv');

    if ~isempty(ahrs_file)
        AHRS.DATA = decodeAHRS(ahrs_file.name);
    end
    if ~isempty(gps_file)
        AHRS.GPS = decodeAHRS_GPS(gps_file.name);
    end
    if exist('AHRS','var')
        save('AHRS.mat','AHRS');
    end
return
