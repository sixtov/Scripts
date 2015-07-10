%%
function a = getFlightDataforXPlane(flight)
    load(flight);
    dt = mean(diff(MavLink_tsc.APM_GPS_RAW_lat.time));
    if (dt < 0.1)
        maxTime = max(MavLink_tsc.APM_GPS_RAW_lat.time);
        newTime = 0:0.1:maxTime;
        MavLink_tsc = resample(MavLink_tsc, newTime,'linear');
    end
        %Look for takeoff and landing
    idx = find(MavLink_tsc.APM_ANALOG_EU_RPM.data>4000,1,'first')-100;
    if (idx<1) , idx = 1; end
    N = length(MavLink_tsc.APM_GPS_RAW_lat.data(idx:end));
    yzero1 = mean(MavLink_tsc.APM_GPS_RAW_alt.data(idx:idx+100));
    yzero2 = mean(MavLink_tsc.APM_GPS_RAW_alt.data(N-100:N));
    mzero = yzero1; %max([yzero1 yzero2]);
    disp(sprintf('Altitude %f %f',yzero1,yzero2))
    a  = [MavLink_tsc.APM_GPS_RAW_lat.data(idx:end) ...
          MavLink_tsc.APM_GPS_RAW_lon.data(idx:end) ...
          (MavLink_tsc.APM_GPS_RAW_alt.data(idx:end)-mzero) ...
          MavLink_tsc.APM_ATTITUDE_roll.data(idx:end) ...
          MavLink_tsc.APM_ATTITUDE_pitch.data(idx:end)+5 ...
          mod(MavLink_tsc.APM_ATTITUDE_yaw.data(idx:end),360) ...
          ];
return
