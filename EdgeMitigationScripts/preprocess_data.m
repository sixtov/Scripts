function data = preprocess_data(channel, decimation, filterLimit,zFlag)
    [b a] = butter(4,filterLimit);
    data = filtfilt(b,a,channel);
    data = decimate(data,decimation);
    if zFlag, data = data - mean(data); end

return

