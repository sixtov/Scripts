function [t1 d1 t2 d2] = matchTimeData(t1,d1,t2,d2)
    ts1 = timeseries(d1,t1);
    ts2 = timeseries(d2,t2);
    if length(t1)<length(t2)
        ts2 = resample(ts2,t1);
    else
        ts1 = resample(ts1,t2);
    end
    t1 = ts1.time;
    d1 = ts1.data;
    t2 = ts2.time;
    d2 = ts2.data;
return
