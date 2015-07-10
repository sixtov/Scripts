function modeA = getAPMode(sysstatus)
N = length(sysstatus.mode);
modeA = cell(N,1);
for i=1:N
    switch (sysstatus.mode(i))
        case 0 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_UNINIT:
            switch (sysstatus.nav_mode(i))
                case 0 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_GROUNDED:
                    mode = 'Initialising';
            end
        case 2 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_MANUAL:
            mode = 'Manual';
        case 3 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_GUIDED:
            mode = 'Guided';
        case 5 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_TEST1:
            mode = 'Stabilize';
        case 6 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_TEST2:
            mode = 'FBW A'; % // fall though  old
            switch (sysstatus.nav_mode(i))
                case 1
                    mode = 'FBW A';
                case 2
                    mode = 'FBW B';
                case 3
                    mode = 'FBW C';
            end
        case 7 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_TEST3:
            mode = 'Circle';
        case 4 %(byte)ArdupilotMega.MAVLink.MAV_MODE.MAV_MODE_AUTO:
            switch (sysstatus.nav_mode(i))
                case 3 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_WAYPOINT:
                    mode = 'Auto';
                case 5 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_RETURNING:
                    mode = 'RTL';
                case 2 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_HOLD:
                    mode = 'Loiter';
                case 8 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_LOITER:
                    mode = 'Loiter';
                case 1 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_LIFTOFF:
                    mode = 'Takeoff';
                case 6 %(byte)ArdupilotMega.MAVLink.MAV_NAV.MAV_NAV_LANDING:
                    mode = 'Land';
            end
        otherwise
            mode = 'Unknown';
    end
    modeA{i} = mode;
end
return
