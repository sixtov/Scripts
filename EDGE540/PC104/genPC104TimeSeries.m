function P = genPC104TimeSeries(PC104)
% VN100 Data
    VNdt = median(diff(PC104.VN.time));
    P.roll_ts     = timeseries(PC104.VN.roll , PC104.VN.time);
    P.pitch_ts    = timeseries(PC104.VN.pitch, PC104.VN.time);
    P.yaw_ts      = timeseries(PC104.VN.yaw  , PC104.VN.time);
    
% RCATS Data
    RCATSdt = median(diff(PC104.RCATS.time));
    P.ias_mps_ts  = timeseries(PC104.RCATS.ias./2.2369 , PC104.RCATS.time);
    P.rpm_ts      = timeseries(PC104.RCATS.rpm , PC104.RCATS.time);
    
% Voltage and Current Data
    if (isfield(PC104.AD1,'LLF20V'))
        AD = PC104.AD1;
    else
        if (isfield(PC104.AD2,'LLF20V'))
            AD = PC104.AD2;
        else
            AD = [];
        end
    end
    if (~isempty(AD))
        ADdt = median(diff(AD.time));
        P.llf20v_ts = timeseries(smooth(AD.time,AD.LLF20V,999),AD.time);
        P.ula20v_ts = timeseries(smooth(AD.time,AD.ULA20V,999),AD.time);
        P.lrf40v_ts = timeseries(smooth(AD.time,AD.LRF40V,999)-P.llf20v_ts.data,AD.time);
        P.ura40v_ts = timeseries(smooth(AD.time,AD.URA40V,999)-P.ula20v_ts.data,AD.time);
        
        P.llf20c_ts = timeseries(smooth(AD.time,AD.LLF20C,999),AD.time);
        P.ula20c_ts = timeseries(smooth(AD.time,AD.ULA20C,999),AD.time);
        P.lrf40c_ts = timeseries(smooth(AD.time,AD.LRF40C,999),AD.time);
        P.ura40c_ts = timeseries(smooth(AD.time,AD.URA40C,999),AD.time);
        ollf20c = mean(P.llf20c_ts.data(P.llf20c_ts.time<100));
        oula20c = mean(P.ula20c_ts.data(P.ula20c_ts.time<100));
        olrf40c = mean(P.lrf40c_ts.data(P.lrf40c_ts.time<100));
        oura40c = mean(P.ura40c_ts.data(P.ura40c_ts.time<100));
        P.llf20c_ts.data = P.llf20c_ts.data-ollf20c;
        P.ula20c_ts.data = P.ula20c_ts.data-oula20c;
        P.lrf40c_ts.data = P.lrf40c_ts.data-olrf40c;
        P.ura40c_ts.data = P.ura40c_ts.data-oura40c;
        
        subplot(2,2,1)
        hold off
        plot(AD.time,AD.ULA20C-oula20c)
        hold all
        plot(P.ula20c_ts.time,P.ula20c_ts.data)
        grid on
        subplot(2,2,2)
        hold off
        plot(AD.time,AD.URA40C-oura40c)
        hold all
        plot(P.ura40c_ts.time,P.ura40c_ts.data)
        grid on
        subplot(2,2,3)
        hold off
        plot(AD.time,AD.LLF20C-ollf20c)
        hold all
        plot(P.llf20c_ts.time,P.llf20c_ts.data)
        grid on
        subplot(2,2,4)
        hold off
        plot(AD.time,AD.LRF40C-olrf40c)
        hold all
        plot(P.lrf40c_ts.time,P.lrf40c_ts.data)
        grid on
        
        P.llf20p_ts = timeseries(P.llf20v_ts.data.*P.llf20c_ts.data, AD.time);
        P.ula20p_ts = timeseries(P.ula20v_ts.data.*P.ula20c_ts.data, AD.time);
        P.lrf40p_ts = timeseries(P.lrf40v_ts.data.*P.lrf40c_ts.data, AD.time);
        P.ura40p_ts = timeseries(P.ura40v_ts.data.*P.ura40c_ts.data, AD.time);
    end

% GPS Data
    GPSdt = median(diff(PC104.GPS.time));
    P.lat_ts      = timeseries(PC104.GPS.lat , PC104.GPS.time);
    P.lon_ts      = timeseries(PC104.GPS.lon , PC104.GPS.time);
    P.alt_ts      = timeseries(PC104.GPS.alt , PC104.GPS.time);
    P.hdg_ts      = timeseries(PC104.GPS.head, PC104.GPS.time);
    
% BHM Data
    BHMdt = median(diff(PC104.BHM.time));
    P.soc1_ts      = timeseries(PC104.BHM.soc1 , PC104.BHM.time);
    P.soc2_ts      = timeseries(PC104.BHM.soc2 , PC104.BHM.time);
    P.soc3_ts      = timeseries(PC104.BHM.soc3 , PC104.BHM.time);
    P.soc4_ts      = timeseries(PC104.BHM.soc4 , PC104.BHM.time);

    warning('off','interpolation:interpolation:noextrap');
    P.lat_ts     = resample( P.lat_ts,   P.roll_ts.time,'linear');
    P.lon_ts     = resample( P.lon_ts,   P.roll_ts.time,'linear');
    P.alt_ts     = resample( P.alt_ts,   P.roll_ts.time,'linear');
    P.hdg_ts     = resample( P.hdg_ts,   P.roll_ts.time,'linear');
    P.soc1_ts    = resample(P.soc1_ts,   P.roll_ts.time,'linear');
    P.soc2_ts    = resample(P.soc2_ts,   P.roll_ts.time,'linear');
    P.soc3_ts    = resample(P.soc3_ts,   P.roll_ts.time,'linear');
    P.soc4_ts    = resample(P.soc4_ts,   P.roll_ts.time,'linear');
    P.llf20v_ts  = resample(P.llf20v_ts, P.roll_ts.time,'linear');
    P.ula20v_ts  = resample(P.ula20v_ts, P.roll_ts.time,'linear');
    P.lrf40v_ts  = resample(P.lrf40v_ts, P.roll_ts.time,'linear');
    P.ura40v_ts  = resample(P.ura40v_ts, P.roll_ts.time,'linear');
    P.llf20c_ts  = resample(P.llf20c_ts, P.roll_ts.time,'linear');
    P.ula20c_ts  = resample(P.ula20c_ts, P.roll_ts.time,'linear');
    P.lrf40c_ts  = resample(P.lrf40c_ts, P.roll_ts.time,'linear');
    P.ura40c_ts  = resample(P.ura40c_ts, P.roll_ts.time,'linear');
    P.llf20p_ts  = resample(P.llf20p_ts, P.roll_ts.time,'linear');
    P.ula20p_ts  = resample(P.ula20p_ts, P.roll_ts.time,'linear');
    P.lrf40p_ts  = resample(P.lrf40p_ts, P.roll_ts.time,'linear');
    P.ura40p_ts  = resample(P.ura40p_ts, P.roll_ts.time,'linear');
    P.ias_mps_ts = resample(P.ias_mps_ts,P.roll_ts.time,'linear');
    P.rpm_ts     = resample(P.rpm_ts,    P.roll_ts.time,'linear');
    warning('on','interpolation:interpolation:noextrap');
%     warning('query','last');
return