function S = parseMavLink_v0_9_Packet(S,p)
	switch(p.messid)
		case 111
			%% analog channels raw (counts from ADC 0-1024)
			S.ANALOG_RAW = parse_ANALOG_RAW_v0_9(S.ANALOG_RAW,p);

		case 112
			%% analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
			%% Amps, degrees, etc)
			S.ANALOG_EU = parse_ANALOG_EU_v0_9(S.ANALOG_EU,p);

		case 113
			%% Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
			%% to resolve conflicts and includes flags and values for heading,altitude,and 
			%% speed changes as well as a max time duration
			S.CDNR_CONTROLLER = parse_CDNR_CONTROLLER_v0_9(S.CDNR_CONTROLLER,p);

		case 114
			%% Message that provides 6 dof position data about other traffic. This includes: Vehicle 
			%% number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
			%% (deg), heading(deg)
			S.TRAFFIC_DATA = parse_TRAFFIC_DATA_v0_9(S.TRAFFIC_DATA,p);

		case 115
			%% Message that provides information about the state of the aircraft
			S.STATE_DATA = parse_STATE_DATA_v0_9(S.STATE_DATA,p);

		case 116
			%% Message that provides timing information about the traffic simulation
			S.TRAFFIC_SIM_TIMING = parse_TRAFFIC_SIM_TIMING_v0_9(S.TRAFFIC_SIM_TIMING,p);

		case 117
			%% Message that provides information about the state of the aircraft
			S.STATE_DATA_AUG = parse_STATE_DATA_AUG_v0_9(S.STATE_DATA_AUG,p);

		case 120
			%% Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
			%% and State-Of-Charge(SOC) information
			S.BHM_SOC_EOD_RUL = parse_BHM_SOC_EOD_RUL_v0_9(S.BHM_SOC_EOD_RUL,p);

		case 121
			%% Message that provides Battery Current, Voltage, RPM, and an alert status
			S.BHM_CURRENT_VOLTAGE = parse_BHM_CURRENT_VOLTAGE_v0_9(S.BHM_CURRENT_VOLTAGE,p);

		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			S.HEARTBEAT = parse_HEARTBEAT_v0_9(S.HEARTBEAT,p);

		case 1
			%% The boot message indicates that a system is starting. The onboard software version 
			%% allows to keep track of onboard soft/firmware revisions.
			S.BOOT = parse_BOOT_v0_9(S.BOOT,p);

		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			S.SYSTEM_TIME = parse_SYSTEM_TIME_v0_9(S.SYSTEM_TIME,p);

		case 3
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			S.PING = parse_PING_v0_9(S.PING,p);

		case 4
			%% UTC date and time from GPS module
			S.SYSTEM_TIME_UTC = parse_SYSTEM_TIME_UTC_v0_9(S.SYSTEM_TIME_UTC,p);

		case 5
			%% Request to control this MAV
			S.CHANGE_OPERATOR_CONTROL = parse_CHANGE_OPERATOR_CONTROL_v0_9(S.CHANGE_OPERATOR_CONTROL,p);

		case 6
			%% Accept / deny control of this MAV
			S.CHANGE_OPERATOR_CONTROL_ACK = parse_CHANGE_OPERATOR_CONTROL_ACK_v0_9(S.CHANGE_OPERATOR_CONTROL_ACK,p);

		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			S.AUTH_KEY = parse_AUTH_KEY_v0_9(S.AUTH_KEY,p);

		case 9
			%% This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
			%% negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
			%% ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			S.ACTION_ACK = parse_ACTION_ACK_v0_9(S.ACTION_ACK,p);

		case 10
			%% An action message allows to execute a certain onboard action. These include liftoff, 
			%% land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
			%% in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			S.ACTION = parse_ACTION_v0_9(S.ACTION,p);

		case 11
			%% Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
			%% There is no target component id as the mode is by definition for the overall 
			%% aircraft, not only for one component.
			S.SET_MODE = parse_SET_MODE_v0_9(S.SET_MODE,p);

		case 12
			%% Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
			%% The navigation mode applies to the whole aircraft and thus all 
			%% components.
			S.SET_NAV_MODE = parse_SET_NAV_MODE_v0_9(S.SET_NAV_MODE,p);

		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			S.PARAM_REQUEST_READ = parse_PARAM_REQUEST_READ_v0_9(S.PARAM_REQUEST_READ,p);

		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			S.PARAM_REQUEST_LIST = parse_PARAM_REQUEST_LIST_v0_9(S.PARAM_REQUEST_LIST,p);

		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			S.PARAM_VALUE = parse_PARAM_VALUE_v0_9(S.PARAM_VALUE,p);

		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			S.PARAM_SET = parse_PARAM_SET_v0_9(S.PARAM_SET,p);

		case 25
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			S.GPS_RAW_INT = parse_GPS_RAW_INT_v0_9(S.GPS_RAW_INT,p);

		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU = parse_SCALED_IMU_v0_9(S.SCALED_IMU,p);

		case 27
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			S.GPS_STATUS = parse_GPS_STATUS_v0_9(S.GPS_STATUS,p);

		case 28
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			S.RAW_IMU = parse_RAW_IMU_v0_9(S.RAW_IMU,p);

		case 29
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			S.RAW_PRESSURE = parse_RAW_PRESSURE_v0_9(S.RAW_PRESSURE,p);

		case 38
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			S.SCALED_PRESSURE = parse_SCALED_PRESSURE_v0_9(S.SCALED_PRESSURE,p);

		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			S.ATTITUDE = parse_ATTITUDE_v0_9(S.ATTITUDE,p);

		case 31
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame)
			S.LOCAL_POSITION = parse_LOCAL_POSITION_v0_9(S.LOCAL_POSITION,p);

		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
			%% is right-handed, Z-axis up (GPS frame)
			S.GLOBAL_POSITION = parse_GLOBAL_POSITION_v0_9(S.GLOBAL_POSITION,p);

		case 32
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			S.GPS_RAW = parse_GPS_RAW_v0_9(S.GPS_RAW,p);

		case 34
			%% The general system state. If the system is following the MAVLink standard, the system 
			%% state is mainly defined by three orthogonal states/modes: The system mode, 
			%% which is either LOCKED (motors shut down and locked), MANUAL (system under RC control), 
			%% GUIDED (system with autonomous position control, position setpoint controlled 
			%% manually) or AUTO (system guided by path/waypoint planner). The NAV_MODE 
			%% defined the current flight state: LIFTOFF (often an open-loop maneuver), LANDING, 
			%% WAYPOINTS or VECTOR. This represents the internal navigation state machine. The 
			%% system status shows wether the system is currently active or not and if an emergency 
			%% occured. During the CRITICAL and EMERGENCY states the MAV is still considered 
			%% to be active, but should start emergency procedures autonomously. After a failure 
			%% occured it should first move from active to critical to allow manual intervention 
			%% and then move to emergency after a certain timeout.
			S.SYS_STATUS = parse_SYS_STATUS_v0_9(S.SYS_STATUS,p);

		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			S.RC_CHANNELS_RAW = parse_RC_CHANNELS_RAW_v0_9(S.RC_CHANNELS_RAW,p);

		case 36
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000
			S.RC_CHANNELS_SCALED = parse_RC_CHANNELS_SCALED_v0_9(S.RC_CHANNELS_SCALED,p);

		case 37
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			S.SERVO_OUTPUT_RAW = parse_SERVO_OUTPUT_RAW_v0_9(S.SERVO_OUTPUT_RAW,p);

		case 39
			%% Message encoding a waypoint. This message is emitted to announce      the presence 
			%% of a waypoint and to set a waypoint on the system. The waypoint can be either 
			%% in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
			%% right handed, global frame is Z-up, right handed
			S.WAYPOINT = parse_WAYPOINT_v0_9(S.WAYPOINT,p);

		case 40
			%% Request the information of the waypoint with the sequence number seq. The response 
			%% of the system to this message should be a WAYPOINT message.
			S.WAYPOINT_REQUEST = parse_WAYPOINT_REQUEST_v0_9(S.WAYPOINT_REQUEST,p);

		case 41
			%% Set the waypoint with sequence number seq as current waypoint. This means that the 
			%% MAV will continue to this waypoint on the shortest path (not following the waypoints 
			%% in-between).
			S.WAYPOINT_SET_CURRENT = parse_WAYPOINT_SET_CURRENT_v0_9(S.WAYPOINT_SET_CURRENT,p);

		case 42
			%% Message that announces the sequence number of the current active waypoint. The MAV 
			%% will fly towards this waypoint.
			S.WAYPOINT_CURRENT = parse_WAYPOINT_CURRENT_v0_9(S.WAYPOINT_CURRENT,p);

		case 43
			%% Request the overall list of waypoints from the system/component.
			S.WAYPOINT_REQUEST_LIST = parse_WAYPOINT_REQUEST_LIST_v0_9(S.WAYPOINT_REQUEST_LIST,p);

		case 44
			%% This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
			%% can then request the individual waypoints based on the knowledge of the total number 
			%% of waypoints.
			S.WAYPOINT_COUNT = parse_WAYPOINT_COUNT_v0_9(S.WAYPOINT_COUNT,p);

		case 45
			%% Delete all waypoints at once.
			S.WAYPOINT_CLEAR_ALL = parse_WAYPOINT_CLEAR_ALL_v0_9(S.WAYPOINT_CLEAR_ALL,p);

		case 46
			%% A certain waypoint has been reached. The system will either hold this position (or 
			%% circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
			%% next waypoint.
			S.WAYPOINT_REACHED = parse_WAYPOINT_REACHED_v0_9(S.WAYPOINT_REACHED,p);

		case 47
			%% Ack message during waypoint handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			S.WAYPOINT_ACK = parse_WAYPOINT_ACK_v0_9(S.WAYPOINT_ACK,p);

		case 48
			%% As local waypoints exist, the global waypoint reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should 
			%% move from in- to outdoor.
			S.GPS_SET_GLOBAL_ORIGIN = parse_GPS_SET_GLOBAL_ORIGIN_v0_9(S.GPS_SET_GLOBAL_ORIGIN,p);

		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			S.GPS_LOCAL_ORIGIN_SET = parse_GPS_LOCAL_ORIGIN_SET_v0_9(S.GPS_LOCAL_ORIGIN_SET,p);

		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/waypoint planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			S.LOCAL_POSITION_SETPOINT_SET = parse_LOCAL_POSITION_SETPOINT_SET_v0_9(S.LOCAL_POSITION_SETPOINT_SET,p);

		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.LOCAL_POSITION_SETPOINT = parse_LOCAL_POSITION_SETPOINT_v0_9(S.LOCAL_POSITION_SETPOINT,p);

		case 52
			S.CONTROL_STATUS = parse_CONTROL_STATUS_v0_9(S.CONTROL_STATUS,p);

		case 53
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/waypoints to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			S.SAFETY_SET_ALLOWED_AREA = parse_SAFETY_SET_ALLOWED_AREA_v0_9(S.SAFETY_SET_ALLOWED_AREA,p);

		case 54
			%% Read out the safety zone the MAV currently assumes.
			S.SAFETY_ALLOWED_AREA = parse_SAFETY_ALLOWED_AREA_v0_9(S.SAFETY_ALLOWED_AREA,p);

		case 55
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_THRUST = parse_SET_ROLL_PITCH_YAW_THRUST_v0_9(S.SET_ROLL_PITCH_YAW_THRUST,p);

		case 56
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_SPEED_THRUST = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST_v0_9(S.SET_ROLL_PITCH_YAW_SPEED_THRUST,p);

		case 57
			%% Setpoint in roll, pitch, yaw currently active on the system.
			S.ROLL_PITCH_YAW_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_THRUST_SETPOINT_v0_9(S.ROLL_PITCH_YAW_THRUST_SETPOINT,p);

		case 58
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v0_9(S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT,p);

		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters 
			S.NAV_CONTROLLER_OUTPUT = parse_NAV_CONTROLLER_OUTPUT_v0_9(S.NAV_CONTROLLER_OUTPUT,p);

		case 63
			%% The goal position of the system. This position is the input to any navigation or 
			%% path planning algorithm and does NOT represent the current controller setpoint.
			S.POSITION_TARGET = parse_POSITION_TARGET_v0_9(S.POSITION_TARGET,p);

		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			S.STATE_CORRECTION = parse_STATE_CORRECTION_v0_9(S.STATE_CORRECTION,p);

		case 65
			S.SET_ALTITUDE = parse_SET_ALTITUDE_v0_9(S.SET_ALTITUDE,p);

		case 66
			S.REQUEST_DATA_STREAM = parse_REQUEST_DATA_STREAM_v0_9(S.REQUEST_DATA_STREAM,p);

		case 67
			%% This packet is useful for high throughput                 applications such as hardware 
			%% in the loop simulations.             
			S.HIL_STATE = parse_HIL_STATE_v0_9(S.HIL_STATE,p);

		case 68
			%% Hardware in the loop control outputs
			S.HIL_CONTROLS = parse_HIL_CONTROLS_v0_9(S.HIL_CONTROLS,p);

		case 69
			S.MANUAL_CONTROL = parse_MANUAL_CONTROL_v0_9(S.MANUAL_CONTROL,p);

		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of -1 means no change to that channel. A value of 0 means 
			%% control of that channel should be released back to the RC radio. The standard PPM 
			%% modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual 
			%% receivers/transmitters might violate this specification.
			S.RC_CHANNELS_OVERRIDE = parse_RC_CHANNELS_OVERRIDE_v0_9(S.RC_CHANNELS_OVERRIDE,p);

		case 73
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up)
			S.GLOBAL_POSITION_INT = parse_GLOBAL_POSITION_INT_v0_9(S.GLOBAL_POSITION_INT,p);

		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			S.VFR_HUD = parse_VFR_HUD_v0_9(S.VFR_HUD,p);

		case 75
			%% Send a command with up to four parameters to the MAV
			S.COMMAND = parse_COMMAND_v0_9(S.COMMAND,p);

		case 76
			%% Report status of a command. Includes feedback wether the command was executed
			S.COMMAND_ACK = parse_COMMAND_ACK_v0_9(S.COMMAND_ACK,p);

		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			S.OPTICAL_FLOW = parse_OPTICAL_FLOW_v0_9(S.OPTICAL_FLOW,p);

		case 140
			%% Object has been detected
			S.OBJECT_DETECTION_EVENT = parse_OBJECT_DETECTION_EVENT_v0_9(S.OBJECT_DETECTION_EVENT,p);

		case 251
			S.DEBUG_VECT = parse_DEBUG_VECT_v0_9(S.DEBUG_VECT,p);

		case 252
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_FLOAT = parse_NAMED_VALUE_FLOAT_v0_9(S.NAMED_VALUE_FLOAT,p);

		case 253
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_INT = parse_NAMED_VALUE_INT_v0_9(S.NAMED_VALUE_INT,p);

		case 254
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			S.STATUSTEXT = parse_STATUSTEXT_v0_9(S.STATUSTEXT,p);

		case 255
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			S.DEBUG = parse_DEBUG_v0_9(S.DEBUG,p);

		case 150
			%% Offsets and calibrations values for hardware         sensors. This makes it easier 
			%% to debug the calibration process.
			S.SENSOR_OFFSETS = parse_SENSOR_OFFSETS_v0_9(S.SENSOR_OFFSETS,p);

		case 151
			%% set the magnetometer offsets
			S.SET_MAG_OFFSETS = parse_SET_MAG_OFFSETS_v0_9(S.SET_MAG_OFFSETS,p);

		case 152
			%% state of APM memory
			S.MEMINFO = parse_MEMINFO_v0_9(S.MEMINFO,p);

		case 153
			%% raw ADC output
			S.AP_ADC = parse_AP_ADC_v0_9(S.AP_ADC,p);

		case 154
			%% Configure on-board Camera Control System.
			S.DIGICAM_CONFIGURE = parse_DIGICAM_CONFIGURE_v0_9(S.DIGICAM_CONFIGURE,p);

		case 155
			%% Control on-board Camera Control System to take shots.
			S.DIGICAM_CONTROL = parse_DIGICAM_CONTROL_v0_9(S.DIGICAM_CONTROL,p);

		case 156
			%% Message to configure a camera mount, directional antenna, etc.
			S.MOUNT_CONFIGURE = parse_MOUNT_CONFIGURE_v0_9(S.MOUNT_CONFIGURE,p);

		case 157
			%% Message to control a camera mount, directional antenna, etc.
			S.MOUNT_CONTROL = parse_MOUNT_CONTROL_v0_9(S.MOUNT_CONTROL,p);

		case 158
			%% Message with some status from APM to GCS about camera or antenna mount
			S.MOUNT_STATUS = parse_MOUNT_STATUS_v0_9(S.MOUNT_STATUS,p);

		case 160
			%% A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
			%% a point from MAV -> GCS
			S.FENCE_POINT = parse_FENCE_POINT_v0_9(S.FENCE_POINT,p);

		case 161
			%% Request a current fence point from MAV
			S.FENCE_FETCH_POINT = parse_FENCE_FETCH_POINT_v0_9(S.FENCE_FETCH_POINT,p);

		case 162
			%% Status of geo-fencing. Sent in extended      status stream when fencing enabled
			S.FENCE_STATUS = parse_FENCE_STATUS_v0_9(S.FENCE_STATUS,p);

		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
	end
return

