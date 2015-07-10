%%
function MavLink = MavLink_EU_units(MavLink,packetID)
    oldPacketID = 85;
    newPacketID = 254;

    %% Conversion Factors
    m2feet = 3.2808399;
    mps2mph = 2.23693629;
    mps2knots = 1.94384449;
    rad2deg = 180/pi;
    
    %% Analog Block
    if (isfield(MavLink,'ANALOG_RAW'))
        MavLink.ANALOG_EU.left_ail   = ( 40.0 / 360) * double(MavLink.ANALOG_RAW.chan01) - ( 61.77  );    %CALIBRATED
        MavLink.ANALOG_EU.left_flap  = ( 20.0 / 238) * double(MavLink.ANALOG_RAW.chan02) - ( 48.99  );    %CALIBRATED
        MavLink.ANALOG_EU.left_elev  = ( 45.0 / 424) * double(MavLink.ANALOG_RAW.chan03) - ( 60.18  );    %CALIBRATED
        MavLink.ANALOG_EU.right_elev = ( 40.5 / 406) * double(MavLink.ANALOG_RAW.chan04) - ( 52.37  );    %CALIBRATED
        MavLink.ANALOG_EU.right_flap = ( 20.0 / 203) * double(MavLink.ANALOG_RAW.chan05) - ( 57.14  );    %CALIBRATED
        MavLink.ANALOG_EU.right_ail  = ( 41.5 / 355) * double(MavLink.ANALOG_RAW.chan06) - ( 61.77  );    %CALIBRATED
        MavLink.ANALOG_EU.rudder     = ( 50.0 / 293) * double(MavLink.ANALOG_RAW.chan07) - ( 98.12  );    %CALIBRATED
        MavLink.ANALOG_EU.alpha      = (360.0 / 860) * double(MavLink.ANALOG_RAW.chan08) - (229.20  );    %CALIBRATED
        MavLink.ANALOG_EU.beta       = (360.0 / 860) * double(MavLink.ANALOG_RAW.chan09) - (226.30  );    %CALIBRATED
        MavLink.ANALOG_EU.mtrTemp    = (0.165)       * double(MavLink.ANALOG_RAW.chan10) + ( 59.211 );    %CALIBRATED
        MavLink.ANALOG_EU.notUsed    = (1.0)         * double(MavLink.ANALOG_RAW.chan11) + (  0.0   );    %NOT USED
        MavLink.ANALOG_EU.RPM        = (8.040868)    * double(MavLink.ANALOG_RAW.chan12) + (  0.0   );    %CALIBRATED
        MavLink.ANALOG_EU.fwdCurr    = (0.1230)      * double(MavLink.ANALOG_RAW.chan13) - (  2.2160);    %CALIBRATED
        MavLink.ANALOG_EU.aftCurr    = (0.1239)      * double(MavLink.ANALOG_RAW.chan14) - (  1.8683);    %CALIBRATED
        
        MavLink.ANALOG_EU.MUX        = zeros(size(MavLink.ANALOG_RAW.chan15));
        MavLink.ANALOG_EU.MUX(MavLink.ANALOG_RAW.chan15>350) = 1;
        
        MavLink.ANALOG_EU.sync       = (1.0)         * double(MavLink.ANALOG_RAW.chan16) + (  0.0   );    %CALIBRATED
        MavLink.ANALOG_EU.usec       =                        MavLink.ANALOG_RAW.usec;
        MavLink.ANALOG_EU.time       =                        MavLink.ANALOG_RAW.time;
    end
    
    %% RC_CHANNELS_SCALED Block
    if (isfield(MavLink,'RC_CHANNELS_SCALED'))
        chanScale = 10000;
        MavLink.RC_CHANNELS_SCALED.chan1_scaled = MavLink.RC_CHANNELS_SCALED.chan1_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan2_scaled = MavLink.RC_CHANNELS_SCALED.chan2_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan3_scaled = MavLink.RC_CHANNELS_SCALED.chan3_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan4_scaled = MavLink.RC_CHANNELS_SCALED.chan4_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan5_scaled = MavLink.RC_CHANNELS_SCALED.chan5_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan6_scaled = MavLink.RC_CHANNELS_SCALED.chan6_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan7_scaled = MavLink.RC_CHANNELS_SCALED.chan7_scaled / chanScale;
        MavLink.RC_CHANNELS_SCALED.chan8_scaled = MavLink.RC_CHANNELS_SCALED.chan8_scaled / chanScale;
    end
    
    %% ATTITUDE Block
    if (isfield(MavLink,'ATTITUDE'))
        MavLink.ATTITUDE.roll       = rad2deg * MavLink.ATTITUDE.roll;
        MavLink.ATTITUDE.pitch      = rad2deg * MavLink.ATTITUDE.pitch;
        MavLink.ATTITUDE.yaw        = rad2deg * MavLink.ATTITUDE.yaw;
        idx = find(MavLink.ATTITUDE.yaw<0);
        MavLink.ATTITUDE.yaw(idx) = MavLink.ATTITUDE.yaw(idx)+360;
        MavLink.ATTITUDE.rollspeed  = rad2deg * MavLink.ATTITUDE.rollspeed;
        MavLink.ATTITUDE.pitchspeed = rad2deg * MavLink.ATTITUDE.pitchspeed;
        MavLink.ATTITUDE.yawspeed   = rad2deg * MavLink.ATTITUDE.yawspeed;
    end
    
    %% GPS_RAW Block
    if (isfield(MavLink,'GPS_RAW'))
        MavLink.GPS_RAW.alt = m2feet  * MavLink.GPS_RAW.alt; % feet
        MavLink.GPS_RAW.eph = m2feet  * MavLink.GPS_RAW.eph; % feet
        MavLink.GPS_RAW.epv = m2feet  * MavLink.GPS_RAW.epv; % feet
        MavLink.GPS_RAW.v   = mps2knots * MavLink.GPS_RAW.v;   % mph
    end
    
    %% GLOBAL_POSITION_INT Block
    if (isfield(MavLink,'GLOBAL_POSITION_INT'))
        MavLink.GLOBAL_POSITION_INT.lat = double(MavLink.GLOBAL_POSITION_INT.lat * 1e-7); % deg
        MavLink.GLOBAL_POSITION_INT.lon = double(MavLink.GLOBAL_POSITION_INT.lon * 1e-7); % deg
        MavLink.GLOBAL_POSITION_INT.alt = double(m2feet  * MavLink.GLOBAL_POSITION_INT.alt / 1000); % feet
        MavLink.GLOBAL_POSITION_INT.vx  = double(mps2knots * MavLink.GLOBAL_POSITION_INT.vx / 100);   % mph
        MavLink.GLOBAL_POSITION_INT.vy  = double(mps2knots * MavLink.GLOBAL_POSITION_INT.vy / 100);   % mph
        MavLink.GLOBAL_POSITION_INT.vz  = double(mps2knots * MavLink.GLOBAL_POSITION_INT.vz / 100);   % mph
    end
    
    %% HUD Block
    if (isfield(MavLink,'VFR_HUD'))
        MavLink.VFR_HUD.airspeed    = mps2knots * MavLink.VFR_HUD.airspeed;
        MavLink.VFR_HUD.groundspeed = mps2knots * MavLink.VFR_HUD.groundspeed;
        MavLink.VFR_HUD.alt         = m2feet  * MavLink.VFR_HUD.alt;
    end
    
    %% SYS_STATUS Block
    if (isfield(MavLink,'SYS_STATUS'))
        switch (packetID)
            case oldPacketID
                MavLink.SYS_STATUS.load = MavLink.SYS_STATUS.load/10;
                MavLink.SYS_STATUS.battery_remaining = MavLink.SYS_STATUS.battery_remaining/10;
                MavLink.SYS_STATUS.vbat = MavLink.SYS_STATUS.vbat/1000;
                MavLink.SYS_STATUS.packet_drop = MavLink.SYS_STATUS.packet_drop/100;
            case newPacketID
                MavLink.SYS_STATUS.load = MavLink.SYS_STATUS.load/10;
                MavLink.SYS_STATUS.battery_remaining = MavLink.SYS_STATUS.battery_remaining/10;
                MavLink.SYS_STATUS.voltage_battery = MavLink.SYS_STATUS.voltage_battery/1000;
                MavLink.SYS_STATUS.current_battery = MavLink.SYS_STATUS.current_battery/100;
                MavLink.SYS_STATUS.drop_rate_comm = MavLink.SYS_STATUS.drop_rate_comm/100;
        end
    end

%     %% RAW_IMU Block
%     if (isfield(MavLink,'RAW_IMU'))
%         MavLink.RAW_IMU.xacc = MavLink.RAW_IMU.xacc/1000;
%         MavLink.RAW_IMU.yacc = MavLink.RAW_IMU.yacc/1000;
%         MavLink.RAW_IMU.zacc = MavLink.RAW_IMU.zacc/1000;
%         MavLink.RAW_IMU.xgyro = rad2deg*MavLink.RAW_IMU.xgyro/1000;
%         MavLink.RAW_IMU.ygyro = rad2deg*MavLink.RAW_IMU.ygyro/1000;
%         MavLink.RAW_IMU.zgyro = rad2deg*MavLink.RAW_IMU.zgyro/1000;
%     end
    
    %% HEARTBEAT Block
    %% PARAM_REQUEST_LIST Block
    %% PARAM_VALUE Block
    %% GPS_STATUS Block
    %% RAW_IMU Block
    %% SCALED_PRESSURE Block
    %% ATTITUDE Block
    %% GPS_RAW Block
    %% SYS_STATUS Block
    %% WAYPOINT Block
    %% WAYPOINT_REQUEST Block
    %% WAYPOINT_CURRENT Block
    %% WAYPOINT_REQUEST_LIST Block
    %% WAYPOINT_COUNT Block
    %% WAYPOINT_ACK Block
    %% NAV_CONTROLLER_OUTPUT Block
    %% REQUEST_DATA_STREAM Block
    %% GLOBAL_POSITION_INT Block
    %% VFR_HUD Block
    %% STATUSTEXT Block
    %% SENSOR_OFFSETS Block
    
return
