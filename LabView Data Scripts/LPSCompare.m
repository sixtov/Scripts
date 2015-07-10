function LPSCompare (ONcase ,OFFcase, SPon_Offset)
Fs = 200;  %Hz
decimation = 5;
filterLimit = 0.2;
winTime = 430; % window size in seconds
verbose = 0;

[simLPSon nf] = getSimData(ONcase, 0);
simLPSon.TimeStamp = decimate(simLPSon.TimeStamp,decimation); 
simLPSon.nzbody = preprocess_data(simLPSon.nzbody, decimation, filterLimit);
simLPSon.lon_stk = preprocess_data(simLPSon.lon_stk, decimation, filterLimit);
simLPSon.ELLOB = preprocess_data(simLPSon.ELLOB, decimation, filterLimit);

pc104LPSon = tsClassify (ONcase, Fs, decimation, filterLimit, winTime, verbose);
pc104LPSon.time = pc104LPSon.time;  % - 66.45;

[simLPSoff nf] = getSimData(OFFcase, 0);
simLPSoff.TimeStamp = decimate(simLPSoff.TimeStamp,decimation); 
simLPSoff.nzbody = preprocess_data(simLPSoff.nzbody, decimation, filterLimit);
simLPSoff.lon_stk = preprocess_data(simLPSoff.lon_stk, decimation, filterLimit);
simLPSoff.ELLOB = preprocess_data(simLPSoff.ELLOB, decimation, filterLimit);

pc104LPSoff = tsClassify (OFFcase, Fs, decimation, filterLimit, winTime, verbose);
pc104LPSoff.time = pc104LPSoff.time;  % - 66.45;

msplots(sprintf('%s_vs_%s',ONcase, OFFcase), simLPSon,pc104LPSon,  simLPSoff, pc104LPSoff, SPon_Offset);
