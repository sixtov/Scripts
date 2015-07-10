%%% Process AHRS data files
ahrs_file = dir('*AHRS_data.csv');
gps_file = dir('*GPS.csv');
ypr_file = dir('*ypr.csv');

%%%
importAHRSfile(ahrs_file.name);

%%%
G = csvread(gps_file.name);
