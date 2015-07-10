function PC104 = FindPC104_TS_UsagefromSegments(PC104,seg)
    PC104.seg = seg;
    PC104.use1 = diff(reshape(PC104.soc1_ts.data(fliplr(PC104.seg)),size(PC104.seg)),1,2);
    PC104.use2 = diff(reshape(PC104.soc2_ts.data(fliplr(PC104.seg)),size(PC104.seg)),1,2);
    PC104.use3 = diff(reshape(PC104.soc3_ts.data(fliplr(PC104.seg)),size(PC104.seg)),1,2);
    PC104.use4 = diff(reshape(PC104.soc4_ts.data(fliplr(PC104.seg)),size(PC104.seg)),1,2);
    PC104.abat = (PC104.use1+PC104.use3)/2;
    PC104.fbat = (PC104.use2+PC104.use4)/2;
    PC104.time = round(diff(reshape(PC104.soc1_ts.time(PC104.seg),size(PC104.seg)),1,2));
    lat1 = PC104.lat_ts.data(PC104.seg(:,1));
    lat2 = PC104.lat_ts.data(PC104.seg(:,2));
    lon1 = PC104.lon_ts.data(PC104.seg(:,1));
    lon2 = PC104.lon_ts.data(PC104.seg(:,2));
    PC104.dist = round(GPSdistance(lat1,lon1,lat2,lon2));
    PC104.speed = PC104.dist./PC104.time;
    
    N = size(seg,1);
    PC104.llfP = zeros(N,1);
    PC104.ulaP = zeros(N,1);
    PC104.lrfP = zeros(N,1);
    PC104.uraP = zeros(N,1);
    for i=1:N
        PC104.llfP(i) = mean(PC104.llf20p_ts.data(seg(i,1):seg(i,2)));
        PC104.ulaP(i) = mean(PC104.ula20p_ts.data(seg(i,1):seg(i,2)));
        PC104.lrfP(i) = mean(PC104.lrf40p_ts.data(seg(i,1):seg(i,2)));
        PC104.uraP(i) = mean(PC104.ura40p_ts.data(seg(i,1):seg(i,2)));
    end
    disp(sprintf('%% Flight xx Segment Data'))
    disp(sprintf('%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\t; ...\n',[PC104.dist PC104.speed PC104.llfP PC104.ulaP PC104.lrfP PC104.uraP PC104.use1 PC104.use2 PC104.use3 PC104.use4]'))
return