function [t1idx t2idx] = pairUpTimeValues(time1,time2)
    dt1 = mean(diff(time1));
    dt2 = mean(diff(time2));
    
    if dt1>dt2  % time2 has higher sampling rate than time1
        tslow = time1;
        tfast = time2;
        dt = dt2;
    else
        tslow = time2;
        tfast = time1;
        dt = dt1;
    end
    
    N = length(tslow);
    sidx = [];
    fidx = [];
    for i=1:N
        [delta midx] = min(abs(tfast-tslow(i)));
        if delta<dt
            sidx = [sidx; i];
            fidx = [fidx; midx];
        end
    end
    
    if dt1>dt2  % time2 has higher sampling rate than time1
        t1idx = sidx;
        t2idx = fidx;
    else
        t1idx = fidx;
        t2idx = sidx;
    end
return
