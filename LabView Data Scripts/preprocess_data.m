function data = preprocess_data(channel, decimation, filterLimit)

    [b a] = butter(4,filterLimit);
    data = filtfilt(b,a,channel);
    data = decimate(data,decimation);
    data = data - mean(data);

return

