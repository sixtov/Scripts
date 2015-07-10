function S = parseMavLink_0_9_Packet(S,p)
	switch(p.messid)
		case 111
			%% analog channels raw (counts from ADC 0-1024)
			S.ANALOG_RAW = parse_ANALOG_RAW(S.ANALOG_RAW,p);
		case 112
			%% analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
			%% Amps, degrees, etc)
			S.ANALOG_EU = parse_ANALOG_EU(S.ANALOG_EU,p);
		case 113
			%% Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
			%% to resolve conflicts and includes flags and values for heading,altitude,and 
			%% speed changes as well as a max time duration
			S.CDNR_CONTROLLER = parse_CDNR_CONTROLLER(S.CDNR_CONTROLLER,p);
		case 114
			%% Message that provides 6 dof position data about other traffic. This includes: Vehicle 
			%% number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
			%% (deg), heading(deg)
			S.TRAFFIC_DATA = parse_TRAFFIC_DATA(S.TRAFFIC_DATA,p);
		case 115
			%% Message that provides information about the state of the aircraft
			S.STATE_DATA = parse_STATE_DATA(S.STATE_DATA,p);
		case 116
			%% Message that provides timing information about the traffic simulation
			S.TRAFFIC_SIM_TIMING = parse_TRAFFIC_SIM_TIMING(S.TRAFFIC_SIM_TIMING,p);
		case 117
			%% Message that provides information about the state of the aircraft
			S.STATE_DATA_AUG = parse_STATE_DATA_AUG(S.STATE_DATA_AUG,p);
		case 120
			%% Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
			%% and State-Of-Charge(SOC) information
			S.BHM_SOC_EOD_RUL = parse_BHM_SOC_EOD_RUL(S.BHM_SOC_EOD_RUL,p);
		case 121
			%% Message that provides Battery Current, Voltage, RPM, and an alert status
			S.BHM_CURRENT_VOLTAGE = parse_BHM_CURRENT_VOLTAGE(S.BHM_CURRENT_VOLTAGE,p);
		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			S.HEARTBEAT = parse_HEARTBEAT(S.HEARTBEAT,p);
		case 1
			%% The boot message indicates that a system is starting. The onboard software version 
			%% allows to keep track of onboard soft/firmware revisions.
			S.BOOT = parse_BOOT(S.BOOT,p);
		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			S.SYSTEM_TIME = parse_SYSTEM_TIME(S.SYSTEM_TIME,p);
		case 3
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			S.PING = parse_PING(S.PING,p);
		case 4
			%% UTC date and time from GPS module
			S.SYSTEM_TIME_UTC = parse_SYSTEM_TIME_UTC(S.SYSTEM_TIME_UTC,p);
		case 5
			%% Request to control this MAV
			S.CHANGE_OPERATOR_CONTROL = parse_CHANGE_OPERATOR_CONTROL(S.CHANGE_OPERATOR_CONTROL,p);
		case 6
			%% Accept / deny control of this MAV
			S.CHANGE_OPERATOR_CONTROL_ACK = parse_CHANGE_OPERATOR_CONTROL_ACK(S.CHANGE_OPERATOR_CONTROL_ACK,p);
		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			S.AUTH_KEY = parse_AUTH_KEY(S.AUTH_KEY,p);
		case 9
			%% This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
			%% negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
			%% ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			S.ACTION_ACK = parse_ACTION_ACK(S.ACTION_ACK,p);
		case 10
			%% An action message allows to execute a certain onboard action. These include liftoff, 
			%% land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
			%% in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			S.ACTION = parse_ACTION(S.ACTION,p);
		case 11
			%% Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
			%% There is no target component id as the mode is by definition for the overall 
			%% aircraft, not only for one component.
			S.SET_MODE = parse_SET_MODE(S.SET_MODE,p);
		case 12
			%% Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
			%% The navigation mode applies to the whole aircraft and thus all 
			%% components.
			S.SET_NAV_MODE = parse_SET_NAV_MODE(S.SET_NAV_MODE,p);
		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			S.PARAM_REQUEST_READ = parse_PARAM_REQUEST_READ(S.PARAM_REQUEST_READ,p);
		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			S.PARAM_REQUEST_LIST = parse_PARAM_REQUEST_LIST(S.PARAM_REQUEST_LIST,p);
		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			S.PARAM_VALUE = parse_PARAM_VALUE(S.PARAM_VALUE,p);
		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			S.PARAM_SET = parse_PARAM_SET(S.PARAM_SET,p);
		case 25
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			S.GPS_RAW_INT = parse_GPS_RAW_INT(S.GPS_RAW_INT,p);
		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU = parse_SCALED_IMU(S.SCALED_IMU,p);
		case 27
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			S.GPS_STATUS = parse_GPS_STATUS(S.GPS_STATUS,p);
		case 28
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			S.RAW_IMU = parse_RAW_IMU(S.RAW_IMU,p);
		case 29
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			S.RAW_PRESSURE = parse_RAW_PRESSURE(S.RAW_PRESSURE,p);
		case 38
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			S.SCALED_PRESSURE = parse_SCALED_PRESSURE(S.SCALED_PRESSURE,p);
		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			S.ATTITUDE = parse_ATTITUDE(S.ATTITUDE,p);
		case 31
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame)
			S.LOCAL_POSITION = parse_LOCAL_POSITION(S.LOCAL_POSITION,p);
		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
			%% is right-handed, Z-axis up (GPS frame)
			S.GLOBAL_POSITION = parse_GLOBAL_POSITION(S.GLOBAL_POSITION,p);
		case 32
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			S.GPS_RAW = parse_GPS_RAW(S.GPS_RAW,p);
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
			S.SYS_STATUS = parse_SYS_STATUS(S.SYS_STATUS,p);
		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			S.RC_CHANNELS_RAW = parse_RC_CHANNELS_RAW(S.RC_CHANNELS_RAW,p);
		case 36
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000
			S.RC_CHANNELS_SCALED = parse_RC_CHANNELS_SCALED(S.RC_CHANNELS_SCALED,p);
		case 37
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			S.SERVO_OUTPUT_RAW = parse_SERVO_OUTPUT_RAW(S.SERVO_OUTPUT_RAW,p);
		case 39
			%% Message encoding a waypoint. This message is emitted to announce      the presence 
			%% of a waypoint and to set a waypoint on the system. The waypoint can be either 
			%% in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
			%% right handed, global frame is Z-up, right handed
			S.WAYPOINT = parse_WAYPOINT(S.WAYPOINT,p);
		case 40
			%% Request the information of the waypoint with the sequence number seq. The response 
			%% of the system to this message should be a WAYPOINT message.
			S.WAYPOINT_REQUEST = parse_WAYPOINT_REQUEST(S.WAYPOINT_REQUEST,p);
		case 41
			%% Set the waypoint with sequence number seq as current waypoint. This means that the 
			%% MAV will continue to this waypoint on the shortest path (not following the waypoints 
			%% in-between).
			S.WAYPOINT_SET_CURRENT = parse_WAYPOINT_SET_CURRENT(S.WAYPOINT_SET_CURRENT,p);
		case 42
			%% Message that announces the sequence number of the current active waypoint. The MAV 
			%% will fly towards this waypoint.
			S.WAYPOINT_CURRENT = parse_WAYPOINT_CURRENT(S.WAYPOINT_CURRENT,p);
		case 43
			%% Request the overall list of waypoints from the system/component.
			S.WAYPOINT_REQUEST_LIST = parse_WAYPOINT_REQUEST_LIST(S.WAYPOINT_REQUEST_LIST,p);
		case 44
			%% This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
			%% can then request the individual waypoints based on the knowledge of the total number 
			%% of waypoints.
			S.WAYPOINT_COUNT = parse_WAYPOINT_COUNT(S.WAYPOINT_COUNT,p);
		case 45
			%% Delete all waypoints at once.
			S.WAYPOINT_CLEAR_ALL = parse_WAYPOINT_CLEAR_ALL(S.WAYPOINT_CLEAR_ALL,p);
		case 46
			%% A certain waypoint has been reached. The system will either hold this position (or 
			%% circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
			%% next waypoint.
			S.WAYPOINT_REACHED = parse_WAYPOINT_REACHED(S.WAYPOINT_REACHED,p);
		case 47
			%% Ack message during waypoint handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			S.WAYPOINT_ACK = parse_WAYPOINT_ACK(S.WAYPOINT_ACK,p);
		case 48
			%% As local waypoints exist, the global waypoint reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should 
			%% move from in- to outdoor.
			S.GPS_SET_GLOBAL_ORIGIN = parse_GPS_SET_GLOBAL_ORIGIN(S.GPS_SET_GLOBAL_ORIGIN,p);
		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			S.GPS_LOCAL_ORIGIN_SET = parse_GPS_LOCAL_ORIGIN_SET(S.GPS_LOCAL_ORIGIN_SET,p);
		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/waypoint planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			S.LOCAL_POSITION_SETPOINT_SET = parse_LOCAL_POSITION_SETPOINT_SET(S.LOCAL_POSITION_SETPOINT_SET,p);
		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.LOCAL_POSITION_SETPOINT = parse_LOCAL_POSITION_SETPOINT(S.LOCAL_POSITION_SETPOINT,p);
		case 52
			S.CONTROL_STATUS = parse_CONTROL_STATUS(S.CONTROL_STATUS,p);
		case 53
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/waypoints to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			S.SAFETY_SET_ALLOWED_AREA = parse_SAFETY_SET_ALLOWED_AREA(S.SAFETY_SET_ALLOWED_AREA,p);
		case 54
			%% Read out the safety zone the MAV currently assumes.
			S.SAFETY_ALLOWED_AREA = parse_SAFETY_ALLOWED_AREA(S.SAFETY_ALLOWED_AREA,p);
		case 55
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_THRUST = parse_SET_ROLL_PITCH_YAW_THRUST(S.SET_ROLL_PITCH_YAW_THRUST,p);
		case 56
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_SPEED_THRUST = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST(S.SET_ROLL_PITCH_YAW_SPEED_THRUST,p);
		case 57
			%% Setpoint in roll, pitch, yaw currently active on the system.
			S.ROLL_PITCH_YAW_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_THRUST_SETPOINT(S.ROLL_PITCH_YAW_THRUST_SETPOINT,p);
		case 58
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT,p);
		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters 
			S.NAV_CONTROLLER_OUTPUT = parse_NAV_CONTROLLER_OUTPUT(S.NAV_CONTROLLER_OUTPUT,p);
		case 63
			%% The goal position of the system. This position is the input to any navigation or 
			%% path planning algorithm and does NOT represent the current controller setpoint.
			S.POSITION_TARGET = parse_POSITION_TARGET(S.POSITION_TARGET,p);
		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			S.STATE_CORRECTION = parse_STATE_CORRECTION(S.STATE_CORRECTION,p);
		case 65
			S.SET_ALTITUDE = parse_SET_ALTITUDE(S.SET_ALTITUDE,p);
		case 66
			S.REQUEST_DATA_STREAM = parse_REQUEST_DATA_STREAM(S.REQUEST_DATA_STREAM,p);
		case 67
			%% This packet is useful for high throughput                 applications such as hardware 
			%% in the loop simulations.             
			S.HIL_STATE = parse_HIL_STATE(S.HIL_STATE,p);
		case 68
			%% Hardware in the loop control outputs
			S.HIL_CONTROLS = parse_HIL_CONTROLS(S.HIL_CONTROLS,p);
		case 69
			S.MANUAL_CONTROL = parse_MANUAL_CONTROL(S.MANUAL_CONTROL,p);
		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of -1 means no change to that channel. A value of 0 means 
			%% control of that channel should be released back to the RC radio. The standard PPM 
			%% modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual 
			%% receivers/transmitters might violate this specification.
			S.RC_CHANNELS_OVERRIDE = parse_RC_CHANNELS_OVERRIDE(S.RC_CHANNELS_OVERRIDE,p);
		case 73
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up)
			S.GLOBAL_POSITION_INT = parse_GLOBAL_POSITION_INT(S.GLOBAL_POSITION_INT,p);
		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			S.VFR_HUD = parse_VFR_HUD(S.VFR_HUD,p);
		case 75
			%% Send a command with up to four parameters to the MAV
			S.COMMAND = parse_COMMAND(S.COMMAND,p);
		case 76
			%% Report status of a command. Includes feedback wether the command was executed
			S.COMMAND_ACK = parse_COMMAND_ACK(S.COMMAND_ACK,p);
		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			S.OPTICAL_FLOW = parse_OPTICAL_FLOW(S.OPTICAL_FLOW,p);
		case 140
			%% Object has been detected
			S.OBJECT_DETECTION_EVENT = parse_OBJECT_DETECTION_EVENT(S.OBJECT_DETECTION_EVENT,p);
		case 251
			S.DEBUG_VECT = parse_DEBUG_VECT(S.DEBUG_VECT,p);
		case 252
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_FLOAT = parse_NAMED_VALUE_FLOAT(S.NAMED_VALUE_FLOAT,p);
		case 253
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_INT = parse_NAMED_VALUE_INT(S.NAMED_VALUE_INT,p);
		case 254
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			S.STATUSTEXT = parse_STATUSTEXT(S.STATUSTEXT,p);
		case 255
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			S.DEBUG = parse_DEBUG(S.DEBUG,p);
		case 150
			%% Offsets and calibrations values for hardware         sensors. This makes it easier 
			%% to debug the calibration process.
			S.SENSOR_OFFSETS = parse_SENSOR_OFFSETS(S.SENSOR_OFFSETS,p);
		case 151
			%% set the magnetometer offsets
			S.SET_MAG_OFFSETS = parse_SET_MAG_OFFSETS(S.SET_MAG_OFFSETS,p);
		case 152
			%% state of APM memory
			S.MEMINFO = parse_MEMINFO(S.MEMINFO,p);
		case 153
			%% raw ADC output
			S.AP_ADC = parse_AP_ADC(S.AP_ADC,p);
		case 154
			%% Configure on-board Camera Control System.
			S.DIGICAM_CONFIGURE = parse_DIGICAM_CONFIGURE(S.DIGICAM_CONFIGURE,p);
		case 155
			%% Control on-board Camera Control System to take shots.
			S.DIGICAM_CONTROL = parse_DIGICAM_CONTROL(S.DIGICAM_CONTROL,p);
		case 156
			%% Message to configure a camera mount, directional antenna, etc.
			S.MOUNT_CONFIGURE = parse_MOUNT_CONFIGURE(S.MOUNT_CONFIGURE,p);
		case 157
			%% Message to control a camera mount, directional antenna, etc.
			S.MOUNT_CONTROL = parse_MOUNT_CONTROL(S.MOUNT_CONTROL,p);
		case 158
			%% Message with some status from APM to GCS about camera or antenna mount
			S.MOUNT_STATUS = parse_MOUNT_STATUS(S.MOUNT_STATUS,p);
		case 160
			%% A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
			%% a point from MAV -> GCS
			S.FENCE_POINT = parse_FENCE_POINT(S.FENCE_POINT,p);
		case 161
			%% Request a current fence point from MAV
			S.FENCE_FETCH_POINT = parse_FENCE_FETCH_POINT(S.FENCE_FETCH_POINT,p);
		case 162
			%% Status of geo-fencing. Sent in extended      status stream when fencing enabled
			S.FENCE_STATUS = parse_FENCE_STATUS(S.FENCE_STATUS,p);
		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
	end
return

%%  case: 111
%%~ analog channels raw (counts from ADC 0-1024)
function S = parse_ANALOG_RAW(S,p)
	name = [ ...
		{'chan01'}	 ... %% adc channel_01
		{'chan02'}	 ... %% adc channel_02
		{'chan03'}	 ... %% adc channel_03
		{'chan04'}	 ... %% adc channel_04
		{'chan05'}	 ... %% adc channel_05
		{'chan06'}	 ... %% adc channel_06
		{'chan07'}	 ... %% adc channel_07
		{'chan08'}	 ... %% adc channel_08
		{'chan09'}	 ... %% adc channel_09
		{'chan10'}	 ... %% adc channel_10
		{'chan11'}	 ... %% adc channel_11
		{'chan12'}	 ... %% adc channel_12
		{'chan13'}	 ... %% adc channel_13
		{'chan14'}	 ... %% adc channel_14
		{'chan15'}	 ... %% adc channel_15
		{'chan16'}	 ... %% adc channel_16
		{'usec'}	 ... %% time
		];
	byte = [ 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 8 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 112
%%~ analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
%%~ Amps, degrees, etc)
function S = parse_ANALOG_EU(S,p)
	name = [ ...
		{'chan01'}	 ... %% adc channel_01
		{'chan02'}	 ... %% adc channel_02
		{'chan03'}	 ... %% adc channel_03
		{'chan04'}	 ... %% adc channel_04
		{'chan05'}	 ... %% adc channel_05
		{'chan06'}	 ... %% adc channel_06
		{'chan07'}	 ... %% adc channel_07
		{'chan08'}	 ... %% adc channel_08
		{'chan09'}	 ... %% adc channel_09
		{'chan10'}	 ... %% adc channel_10
		{'chan11'}	 ... %% adc channel_11
		{'chan12'}	 ... %% adc channel_12
		{'chan13'}	 ... %% adc channel_13
		{'chan14'}	 ... %% adc channel_14
		{'chan15'}	 ... %% adc channel_15
		{'chan16'}	 ... %% adc channel_16
		{'usec'}	 ... %% time
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 8 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 113
%%~ Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
%%~ to resolve conflicts and includes flags and values for heading,altitude,and 
%%~ speed changes as well as a max time duration
function S = parse_CDNR_CONTROLLER(S,p)
	name = [ ...
		{'h_flag'}		 ... %% enables/disables new heading command
		{'s_flag'}		 ... %% enables/disables new airspeed command
		{'a_flag'}		 ... %% enables/disables new altitude command
		{'t_flag'}		 ... %% enables/disables max time command
		{'new_heading'}	 ... %% value for new heading
		{'new_airspeed'} ... %% value for new airspeed
		{'new_altitude'} ... %% value for new altitude
		{'max_time'}	 ... %% maximum time to hold this command
		];
	byte = [ 1 1 1 1 2 2 2 2 ];
	type = [ {'int8'} {'int8'} {'int8'} {'int8'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 114
%%~ Message that provides 6 dof position data about other traffic. This includes: Vehicle 
%%~ number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
%%~ (deg), heading(deg)
function S = parse_TRAFFIC_DATA(S,p)
	name = [ ...
		{'ID'}			 ... %% vehicle ID
		{'lat'}			 ... %% latitude (deg)
		{'lon'}			 ... %% longitude (deg)
		{'alt'}			 ... %% altitude (meters)
		{'roll'}		 ... %% roll (deg)
		{'pitch'}		 ... %% pitch (deg)
		{'heading'}		 ... %% heading (deg)
		{'ownship_flag'} ... %% identifies whether the aircraft is ownship (1) or not (0)
		];
	byte = [ 8 4 4 4 4 4 4 1 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 115
%%~ Message that provides information about the state of the aircraft
function S = parse_STATE_DATA(S,p)
	name = [ ...
		{'num'}		 ... %% Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
		{'atloiter'} ... %% if 0, vehicle is not currently loitering, if 1, vehicle is loitering
		{'mode'}	 ... %% mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
		{'usec'}	 ... %% time
		];
	byte = [ 1 1 1 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 116
%%~ Message that provides timing information about the traffic simulation
function S = parse_TRAFFIC_SIM_TIMING(S,p)
	name = [ ...
		{'sim_time'}	 ... %% Traffic simulation absolute time
		{'time_to_wpt'}	 ... %% Absolute time to reach the next waypoint
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 117
%%~ Message that provides information about the state of the aircraft
function S = parse_STATE_DATA_AUG(S,p)
	name = [ ...
		{'num'}		 ... %% Vehicle number, e.g. 1 for R1, 2 for R2, 3 for R3
		{'atloiter'} ... %% if 0, vehicle is not currently loitering, if 1, vehicle is loitering
		{'mode'}	 ... %% mode: MANUAL=0, CIRCLE=1, STABILIZE=2, FLY_BY_WIRE_A=5, FLY_BY_WIRE_B=6, FLY_BY_WIRE_C=7, AUTO=10, RTL=11, LOITER=12, GUIDED=15, INITIALISING=16
		{'RC_state'} ... %% state: OFF=0, ON=1, FAILSAFE=255
		{'usec'}	 ... %% time
		];
	byte = [ 1 1 1 1 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 120
%%~ Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
%%~ and State-Of-Charge(SOC) information
function S = parse_BHM_SOC_EOD_RUL(S,p)
	name = [ ...
		{'ura_eod'}	 ... %% Upper Right Aft Motor EOD (seconds)
		{'ura_rul'}	 ... %% Upper Right Aft Motor RUL (seconds
		{'ura_soc'}	 ... %% Upper Right Aft Motor SOC (percent)
		{'lrf_eod'}	 ... %% Lower Right Fwd Motor EOD (seconds)
		{'lrf_rul'}	 ... %% Lower Right Fwd Motor RUL (seconds
		{'lrf_soc'}	 ... %% Lower Right Fwd Motor SOC (percent)
		{'ula_eod'}	 ... %% Upper Left Aft Motor EOD (seconds)
		{'ula_rul'}	 ... %% Upper Left Aft Motor RUL (seconds
		{'ula_soc'}	 ... %% Upper Left Aft Motor SOC (percent)
		{'llf_eod'}	 ... %% Lower Left Fwd Motor EOD (seconds)
		{'llf_rul'}	 ... %% Lower Left Fwd Motor RUL (seconds
		{'llf_soc'}	 ... %% Lower Left Fwd Motor SOC (percent)
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 121
%%~ Message that provides Battery Current, Voltage, RPM, and an alert status
function S = parse_BHM_CURRENT_VOLTAGE(S,p)
	name = [ ...
		{'fwd_mtr_cur'}	 ... %% Fwd Motor Current (A)
		{'aft_mtr_cur'}	 ... %% Aft Motor Current (A)
		{'RPM'}			 ... %% Revolutions. Per Minute
		{'llf20v'}		 ... %% Lower Left Fwd Mtr 20-Volt Battery Voltage (V)
		{'ula20v'}		 ... %% Upper Left Aft Mtr 20-Volt Battery Voltage (V)
		{'lrf40v'}		 ... %% Lower Right Fwd Mtr 40-Volt Battery Voltage (V)
		{'ura40v'}		 ... %% Upper Right Aft Mtr 40-Volt Battery Voltage (V)
		{'llf20c'}		 ... %% Lower Left Fwd Mtr 20-Volt Battery Current (A)
		{'ula20c'}		 ... %% Upper Left Aft Mtr 20-Volt Battery Current (A)
		{'lrf40c'}		 ... %% Lower Right Fwd Mtr 40-Volt Battery Current (A)
		{'ura40c'}		 ... %% Upper Right Aft Mtr 40-Volt Battery Current (A)
		{'alert'}		 ... %% Alert Flag (boolean)
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function S = parse_HEARTBEAT(S,p)
	name = [ ...
		{'type'}			 ... %% Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
		{'autopilot'}		 ... %% Type of the Autopilot: 0: Generic, 1: PIXHAWK, 2: SLUGS, 3: Ardupilot (up to 15 types), defined in MAV_AUTOPILOT_TYPE ENUM
		{'mavlink_version'}	 ... %% MAVLink version
		{'vehicleID'}		 ... %% Vehicle ID: 1: R1, 2: R2, 3: R3 (up to xx types), defined in "mydefines.h"
		{'numWpts'}			 ... %% Number of Waypoints in Flight Plan
		];
	byte = [ 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 1
%%~ The boot message indicates that a system is starting. The onboard software version 
%%~ allows to keep track of onboard soft/firmware revisions.
function S = parse_BOOT(S,p)
	name = [ ...
		{'version'}	 ... %% The onboard software version
		];
	byte = [ 4 ];
	type = [ {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 2
%%~ The system time is the time of the master clock, typically the computer clock of 
%%~ the main onboard computer.
function S = parse_SYSTEM_TIME(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		];
	byte = [ 8 ];
	type = [ {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 3
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function S = parse_PING(S,p)
	name = [ ...
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'time'}			 ... %% Unix timestamp in microseconds
		];
	byte = [ 4 1 1 8 ];
	type = [ {'uint32'} {'uint8'} {'uint8'} {'uint64'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 4
%%~ UTC date and time from GPS module
function S = parse_SYSTEM_TIME_UTC(S,p)
	name = [ ...
		{'utc_date'} ... %% GPS UTC date ddmmyy
		{'utc_time'} ... %% GPS UTC time hhmmss
		];
	byte = [ 4 4 ];
	type = [ {'uint32'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 5
%%~ Request to control this MAV
function S = parse_CHANGE_OPERATOR_CONTROL(S,p)
	name = [ ...
		{'target_system'}	 ... %% System the GCS requests control for
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'version'}			 ... %% 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
		{'passkey'}			 ... %% Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
		];
	byte = [ 1 1 1 25 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 6
%%~ Accept / deny control of this MAV
function S = parse_CHANGE_OPERATOR_CONTROL_ACK(S,p)
	name = [ ...
		{'gcs_system_id'}	 ... %% ID of the GCS this message 
		{'control_request'}	 ... %% 0: request control of this MAV, 1: Release control of this MAV
		{'ack'}				 ... %% 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 7
%%~ Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
%%~ has been kept simple, so transmitting the key requires an encrypted channel 
%%~ for true safety.
function S = parse_AUTH_KEY(S,p)
	name = [ ...
		{'key'}	 ... %% key
		];
	byte = [ 32 ];
	type = [ {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 9
%%~ This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
%%~ negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
%%~ ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function S = parse_ACTION_ACK(S,p)
	name = [ ...
		{'action'}	 ... %% The action id
		{'result'}	 ... %% 0: Action DENIED, 1: Action executed
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 10
%%~ An action message allows to execute a certain onboard action. These include liftoff, 
%%~ land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
%%~ in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
function S = parse_ACTION(S,p)
	name = [ ...
		{'target'}			 ... %% The system executing the action
		{'target_component'} ... %% The component executing the action
		{'action'}			 ... %% The action id
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
%%~ There is no target component id as the mode is by definition for the overall 
%%~ aircraft, not only for one component.
function S = parse_SET_MODE(S,p)
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'mode'}	 ... %% The new mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 12
%%~ Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
%%~ The navigation mode applies to the whole aircraft and thus all 
%%~ components.
function S = parse_SET_NAV_MODE(S,p)
	name = [ ...
		{'target'}	 ... %% The system setting the mode
		{'nav_mode'} ... %% The new navigation mode
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 20
%%~ Request to read the onboard parameter with the param_id string id. Onboard parameters 
%%~ are stored as key[const char*] -> value[float]. This allows to send a parameter 
%%~ to any other component (such as the GCS) without the need of previous knowledge 
%%~ of possible parameter names. Thus the same GCS can store different parameters 
%%~ for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
%%~ for a full documentation of QGroundControl and IMU code.
function S = parse_PARAM_REQUEST_READ(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id
		{'param_index'}		 ... %% Parameter index. Send -1 to use the param ID field as identifier
		];
	byte = [ 1 1 15 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 21
%%~ Request all parameters of this component. After his request, all parameters are 
%%~ emitted.
function S = parse_PARAM_REQUEST_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 22
%%~ Emit the value of a onboard parameter. The inclusion of param_count and param_index 
%%~ in the message allows the recipient to keep track of received parameters and 
%%~ allows him to re-request missing parameters after a loss or timeout.
function S = parse_PARAM_VALUE(S,p)
	name = [ ...
		{'param_id'}	 ... %% Onboard parameter id
		{'param_value'}	 ... %% Onboard parameter value
		{'param_count'}	 ... %% Total number of onboard parameters
		{'param_index'}	 ... %% Index of this onboard parameter
		];
	byte = [ 15 4 2 2 ];
	type = [ {'uint8'} {'single'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 23
%%~ Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
%%~ reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
%%~ to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
%%~ parameter value by sending a param_value message to all communication partners. 
%%~ This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
%%~ If the sending GCS did not receive a PARAM_VALUE message within its timeout 
%%~ time, it should re-send the PARAM_SET message.
function S = parse_PARAM_SET(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'param_id'}		 ... %% Onboard parameter id
		{'param_value'}		 ... %% Onboard parameter value
		];
	byte = [ 1 1 15 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 25
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function S = parse_GPS_RAW_INT(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'} ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}		 ... %% Latitude in 1E7 degrees
		{'lon'}		 ... %% Longitude in 1E7 degrees
		{'alt'}		 ... %% Altitude in 1E3 meters (millimeters)
		{'eph'}		 ... %% GPS HDOP
		{'epv'}		 ... %% GPS VDOP
		{'v'}		 ... %% GPS ground speed (m/s)
		{'hdg'}		 ... %% Compass heading in degrees, 0..360 degrees
		];
	byte = [ 8 1 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 26
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
%%~ the scaled values to the described units
function S = parse_SCALED_IMU(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'xacc'}	 ... %% X acceleration (mg)
		{'yacc'}	 ... %% Y acceleration (mg)
		{'zacc'}	 ... %% Z acceleration (mg)
		{'xgyro'}	 ... %% Angular speed around X axis (millirad /sec)
		{'ygyro'}	 ... %% Angular speed around Y axis (millirad /sec)
		{'zgyro'}	 ... %% Angular speed around Z axis (millirad /sec)
		{'xmag'}	 ... %% X Magnetic field (milli tesla)
		{'ymag'}	 ... %% Y Magnetic field (milli tesla)
		{'zmag'}	 ... %% Z Magnetic field (milli tesla)
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 27
%%~ The positioning status, as reported by GPS. This message is intended to display 
%%~ status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
%%~ for the global position estimate. This message can contain information 
%%~ for up to 20 satellites.
function S = parse_GPS_STATUS(S,p)
	name = [ ...
		{'satellites_visible'}	 ... %% Number of satellites visible
		{'satellite_prn'}		 ... %% Global satellite ID
		{'satellite_used'}		 ... %% 0: Satellite not used, 1: used for localization
		{'satellite_elevation'}	 ... %% Elevation (0: right on top of receiver, 90: on the horizon) of satellite
		{'satellite_azimuth'}	 ... %% Direction of satellite, 0: 0 deg, 255: 360 deg.
		{'satellite_snr'}		 ... %% Signal to noise ratio of satellite
		];
	byte = [ 1 20 20 20 20 20 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 28
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
%%~ contain the true raw values without any scaling to allow data capture and system 
%%~ debugging.
function S = parse_RAW_IMU(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'xacc'}	 ... %% X acceleration (raw)
		{'yacc'}	 ... %% Y acceleration (raw)
		{'zacc'}	 ... %% Z acceleration (raw)
		{'xgyro'}	 ... %% Angular speed around X axis (raw)
		{'ygyro'}	 ... %% Angular speed around Y axis (raw)
		{'zgyro'}	 ... %% Angular speed around Z axis (raw)
		{'xmag'}	 ... %% X Magnetic field (raw)
		{'ymag'}	 ... %% Y Magnetic field (raw)
		{'zmag'}	 ... %% Z Magnetic field (raw)
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 29
%%~ The RAW pressure readings for the typical setup of one absolute pressure and one 
%%~ differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
%%~ values.
function S = parse_RAW_PRESSURE(S,p)
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (raw)
		{'press_diff1'}	 ... %% Differential pressure 1 (raw)
		{'press_diff2'}	 ... %% Differential pressure 2 (raw)
		{'temperature'}	 ... %% Raw Temperature measurement (raw)
		];
	byte = [ 8 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 38
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function S = parse_SCALED_PRESSURE(S,p)
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (hectopascal)
		{'press_diff'}	 ... %% Differential pressure 1 (hectopascal)
		{'temperature'}	 ... %% Temperature measurement (0.01 degrees celsius)
		];
	byte = [ 8 4 4 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 30
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
function S = parse_ATTITUDE(S,p)
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad)
		{'pitch'}		 ... %% Pitch angle (rad)
		{'yaw'}			 ... %% Yaw angle (rad)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 31
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame)
function S = parse_LOCAL_POSITION(S,p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'x'}	 ... %% X Position
		{'y'}	 ... %% Y Position
		{'z'}	 ... %% Z Position
		{'vx'}	 ... %% X Speed
		{'vy'}	 ... %% Y Speed
		{'vz'}	 ... %% Z Speed
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
%%~ is right-handed, Z-axis up (GPS frame)
function S = parse_GLOBAL_POSITION(S,p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds since unix epoch)
		{'lat'}	 ... %% Latitude, in degrees
		{'lon'}	 ... %% Longitude, in degrees
		{'alt'}	 ... %% Absolute altitude, in meters
		{'vx'}	 ... %% X Speed (in Latitude direction, positive: going north)
		{'vy'}	 ... %% Y Speed (in Longitude direction, positive: going east)
		{'vz'}	 ... %% Z Speed (in Altitude direction, positive: going up)
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 32
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~ NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
%%~ message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
%%~ right-handed, Z-axis up (GPS frame)
function S = parse_GPS_RAW(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'} ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}		 ... %% Latitude in degrees
		{'lon'}		 ... %% Longitude in degrees
		{'alt'}		 ... %% Altitude in meters
		{'eph'}		 ... %% GPS HDOP
		{'epv'}		 ... %% GPS VDOP
		{'v'}		 ... %% GPS ground speed
		{'hdg'}		 ... %% Compass heading in degrees, 0..360 degrees
		];
	byte = [ 8 1 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 34
%%~ The general system state. If the system is following the MAVLink standard, the system 
%%~ state is mainly defined by three orthogonal states/modes: The system mode, 
%%~ which is either LOCKED (motors shut down and locked), MANUAL (system under RC control), 
%%~ GUIDED (system with autonomous position control, position setpoint controlled 
%%~ manually) or AUTO (system guided by path/waypoint planner). The NAV_MODE 
%%~ defined the current flight state: LIFTOFF (often an open-loop maneuver), LANDING, 
%%~ WAYPOINTS or VECTOR. This represents the internal navigation state machine. The 
%%~ system status shows wether the system is currently active or not and if an emergency 
%%~ occured. During the CRITICAL and EMERGENCY states the MAV is still considered 
%%~ to be active, but should start emergency procedures autonomously. After a failure 
%%~ occured it should first move from active to critical to allow manual intervention 
%%~ and then move to emergency after a certain timeout.
function S = parse_SYS_STATUS(S,p)
	name = [ ...
		{'mode'}				 ... %% System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
		{'nav_mode'}			 ... %% Navigation mode, see MAV_NAV_MODE ENUM
		{'status'}				 ... %% System status flag, see MAV_STATUS ENUM
		{'load'}				 ... %% Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
		{'vbat'}				 ... %% Battery voltage, in millivolts (1 = 1 millivolt)
		{'battery_remaining'}	 ... %% Remaining battery energy: (0%: 0, 100%: 1000)
		{'packet_drop'}			 ... %% Dropped packets (packets that were corrupted on reception on the MAV)
		];
	byte = [ 1 1 1 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 35
%%~ The RAW values of the RC channels received. The standard PPM modulation is as follows: 
%%~ 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
%%~ might violate this specification.
function S = parse_RC_CHANNELS_RAW(S,p)
	name = [ ...
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 36
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000
function S = parse_RC_CHANNELS_SCALED(S,p)
	name = [ ...
		{'chan1_scaled'} ... %% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan2_scaled'} ... %% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan3_scaled'} ... %% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan4_scaled'} ... %% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan5_scaled'} ... %% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan6_scaled'} ... %% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan7_scaled'} ... %% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'chan8_scaled'} ... %% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 2 2 2 2 2 2 2 2 1 ];
	type = [ {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 37
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function S = parse_SERVO_OUTPUT_RAW(S,p)
	name = [ ...
		{'servo1_raw'}	 ... %% Servo output 1 value, in microseconds
		{'servo2_raw'}	 ... %% Servo output 2 value, in microseconds
		{'servo3_raw'}	 ... %% Servo output 3 value, in microseconds
		{'servo4_raw'}	 ... %% Servo output 4 value, in microseconds
		{'servo5_raw'}	 ... %% Servo output 5 value, in microseconds
		{'servo6_raw'}	 ... %% Servo output 6 value, in microseconds
		{'servo7_raw'}	 ... %% Servo output 7 value, in microseconds
		{'servo8_raw'}	 ... %% Servo output 8 value, in microseconds
		];
	byte = [ 2 2 2 2 2 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 39
%%~ Message encoding a waypoint. This message is emitted to announce      the presence 
%%~ of a waypoint and to set a waypoint on the system. The waypoint can be either 
%%~ in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
%%~ right handed, global frame is Z-up, right handed
function S = parse_WAYPOINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		{'frame'}			 ... %% The coordinate system of the waypoint. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the waypoint. see MAV_COMMAND in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1 / For NAV command waypoints: Radius in which the waypoint is accepted as reached, in meters
		{'param2'}			 ... %% PARAM2 / For NAV command waypoints: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
		{'param3'}			 ... %% PARAM3 / For LOITER command waypoints: Orbit to circle around the waypoint, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
		{'param4'}			 ... %% PARAM4 / For NAV and LOITER command waypoints: Yaw orientation in degrees, [0..360] 0 = NORTH
		{'x'}				 ... %% PARAM5 / local: x position, global: latitude
		{'y'}				 ... %% PARAM6 / y position: global: longitude
		{'z'}				 ... %% PARAM7 / z position: global: altitude
		];
	byte = [ 1 1 2 1 1 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 40
%%~ Request the information of the waypoint with the sequence number seq. The response 
%%~ of the system to this message should be a WAYPOINT message.
function S = parse_WAYPOINT_REQUEST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 41
%%~ Set the waypoint with sequence number seq as current waypoint. This means that the 
%%~ MAV will continue to this waypoint on the shortest path (not following the waypoints 
%%~ in-between).
function S = parse_WAYPOINT_SET_CURRENT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 42
%%~ Message that announces the sequence number of the current active waypoint. The MAV 
%%~ will fly towards this waypoint.
function S = parse_WAYPOINT_CURRENT(S,p)
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 43
%%~ Request the overall list of waypoints from the system/component.
function S = parse_WAYPOINT_REQUEST_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 44
%%~ This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
%%~ can then request the individual waypoints based on the knowledge of the total number 
%%~ of waypoints.
function S = parse_WAYPOINT_COUNT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'count'}			 ... %% Number of Waypoints in the Sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 45
%%~ Delete all waypoints at once.
function S = parse_WAYPOINT_CLEAR_ALL(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		];
	byte = [ 1 1 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 46
%%~ A certain waypoint has been reached. The system will either hold this position (or 
%%~ circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
%%~ next waypoint.
function S = parse_WAYPOINT_REACHED(S,p)
	name = [ ...
		{'seq'}	 ... %% Sequence
		];
	byte = [ 2 ];
	type = [ {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 47
%%~ Ack message during waypoint handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function S = parse_WAYPOINT_ACK(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'type'}			 ... %% 0: OK, 1: Error
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 48
%%~ As local waypoints exist, the global waypoint reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should 
%%~ move from in- to outdoor.
function S = parse_GPS_SET_GLOBAL_ORIGIN(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'latitude'}		 ... %% global position * 1E7
		{'longitude'}		 ... %% global position * 1E7
		{'altitude'}		 ... %% global position * 1000
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function S = parse_GPS_LOCAL_ORIGIN_SET(S,p)
	name = [ ...
		{'latitude'}	 ... %% Latitude (WGS84), expressed as * 1E7
		{'longitude'}	 ... %% Longitude (WGS84), expressed as * 1E7
		{'altitude'}	 ... %% Altitude(WGS84), expressed as * 1000
		];
	byte = [ 4 4 4 ];
	type = [ {'int32'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 50
%%~ Set the setpoint for a local position controller. This is the position in local 
%%~ coordinates the MAV should fly to. This message is sent by the path/waypoint planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
function S = parse_LOCAL_POSITION_SETPOINT_SET(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 51
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function S = parse_LOCAL_POSITION_SETPOINT(S,p)
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% Desired yaw angle
		];
	byte = [ 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 52
function S = parse_CONTROL_STATUS(S,p)
	name = [ ...
		{'position_fix'}	 ... %% Position fix: 0: lost, 2: 2D position fix, 3: 3D position fix 
		{'vision_fix'}		 ... %% Vision position fix: 0: lost, 1: 2D local position hold, 2: 2D global position fix, 3: 3D global position fix 
		{'gps_fix'}			 ... %% GPS position fix: 0: no reception, 1: Minimum 1 satellite, but no position fix, 2: 2D position fix, 3: 3D position fix 
		{'ahrs_health'}		 ... %% Attitude estimation health: 0: poor, 255: excellent
		{'control_att'}		 ... %% 0: Attitude control disabled, 1: enabled
		{'control_pos_xy'}	 ... %% 0: X, Y position control disabled, 1: enabled
		{'control_pos_z'}	 ... %% 0: Z position control disabled, 1: enabled
		{'control_pos_yaw'}	 ... %% 0: Yaw angle control disabled, 1: enabled
		];
	byte = [ 1 1 1 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 53
%%~ Set a safety zone (volume), which is defined by two corners of a cube. This message 
%%~ can be used to tell the MAV which setpoints/waypoints to accept and which to 
%%~ reject. Safety areas are often enforced by national or competition regulations.
function S = parse_SAFETY_SET_ALLOWED_AREA(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'frame'}			 ... %% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		{'p1x'}				 ... %% x position 1 / Latitude 1
		{'p1y'}				 ... %% y position 1 / Longitude 1
		{'p1z'}				 ... %% z position 1 / Altitude 1
		{'p2x'}				 ... %% x position 2 / Latitude 2
		{'p2y'}				 ... %% y position 2 / Longitude 2
		{'p2z'}				 ... %% z position 2 / Altitude 2
		];
	byte = [ 1 1 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 54
%%~ Read out the safety zone the MAV currently assumes.
function S = parse_SAFETY_ALLOWED_AREA(S,p)
	name = [ ...
		{'frame'}	 ... %% Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		{'p1x'}		 ... %% x position 1 / Latitude 1
		{'p1y'}		 ... %% y position 1 / Longitude 1
		{'p1z'}		 ... %% z position 1 / Altitude 1
		{'p2x'}		 ... %% x position 2 / Latitude 2
		{'p2y'}		 ... %% y position 2 / Longitude 2
		{'p2z'}		 ... %% z position 2 / Altitude 2
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 55
%%~ Set roll, pitch and yaw.
function S = parse_SET_ROLL_PITCH_YAW_THRUST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'roll'}			 ... %% Desired roll angle in radians
		{'pitch'}			 ... %% Desired pitch angle in radians
		{'yaw'}				 ... %% Desired yaw angle in radians
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 56
%%~ Set roll, pitch and yaw.
function S = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'roll_speed'}		 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}		 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}		 ... %% Desired yaw angular speed in rad/s
		{'thrust'}			 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 57
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function S = parse_ROLL_PITCH_YAW_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_us'}	 ... %% Timestamp in micro seconds since unix epoch
		{'roll'}	 ... %% Desired roll angle in radians
		{'pitch'}	 ... %% Desired pitch angle in radians
		{'yaw'}		 ... %% Desired yaw angle in radians
		{'thrust'}	 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 8 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 58
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function S = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_us'}		 ... %% Timestamp in micro seconds since unix epoch
		{'roll_speed'}	 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}	 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}	 ... %% Desired yaw angular speed in rad/s
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 8 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 62
%%~ Outputs of the APM navigation controller. The primary use of this message is to 
%%~ check the response and signs of the controller before actual flight and to assist 
%%~ with tuning controller parameters 
function S = parse_NAV_CONTROLLER_OUTPUT(S,p)
	name = [ ...
		{'nav_roll'}		 ... %% Current desired roll in degrees
		{'nav_pitch'}		 ... %% Current desired pitch in degrees
		{'nav_bearing'}		 ... %% Current desired heading in degrees
		{'target_bearing'}	 ... %% Bearing to current waypoint/target in degrees
		{'wp_dist'}			 ... %% Distance to active waypoint in meters
		{'alt_error'}		 ... %% Current altitude error in meters
		{'aspd_error'}		 ... %% Current airspeed error in meters/second
		{'xtrack_error'}	 ... %% Current crosstrack error on x-y plane in meters
		];
	byte = [ 4 4 2 2 2 4 4 4 ];
	type = [ {'single'} {'single'} {'int16'} {'int16'} {'uint16'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 63
%%~ The goal position of the system. This position is the input to any navigation or 
%%~ path planning algorithm and does NOT represent the current controller setpoint.
function S = parse_POSITION_TARGET(S,p)
	name = [ ...
		{'x'}	 ... %% x position
		{'y'}	 ... %% y position
		{'z'}	 ... %% z position
		{'yaw'}	 ... %% yaw orientation in radians, 0 = NORTH
		];
	byte = [ 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 64
%%~ Corrects the systems state by adding an error correction term to the position and 
%%~ velocity, and by rotating the attitude by a correction angle.
function S = parse_STATE_CORRECTION(S,p)
	name = [ ...
		{'xErr'}	 ... %% x position error
		{'yErr'}	 ... %% y position error
		{'zErr'}	 ... %% z position error
		{'rollErr'}	 ... %% roll error (radians)
		{'pitchErr'} ... %% pitch error (radians)
		{'yawErr'}	 ... %% yaw error (radians)
		{'vxErr'}	 ... %% x velocity
		{'vyErr'}	 ... %% y velocity
		{'vzErr'}	 ... %% z velocity
		];
	byte = [ 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 65
function S = parse_SET_ALTITUDE(S,p)
	name = [ ...
		{'target'}	 ... %% The system setting the altitude
		{'mode'}	 ... %% The new altitude in meters
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 66
function S = parse_REQUEST_DATA_STREAM(S,p)
	name = [ ...
		{'target_system'}	 ... %% The target requested to send the message stream.
		{'target_component'} ... %% The target requested to send the message stream.
		{'req_stream_id'}	 ... %% The ID of the requested message type
		{'req_message_rate'} ... %% Update rate in Hertz
		{'start_stop'}		 ... %% 1 to start sending, 0 to stop sending.
		];
	byte = [ 1 1 1 2 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 67
%%~ This packet is useful for high throughput                 applications such as hardware 
%%~ in the loop simulations.             
function S = parse_HIL_STATE(S,p)
	name = [ ...
		{'usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad)
		{'pitch'}		 ... %% Pitch angle (rad)
		{'yaw'}			 ... %% Yaw angle (rad)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		{'lat'}			 ... %% Latitude, expressed as * 1E7
		{'lon'}			 ... %% Longitude, expressed as * 1E7
		{'alt'}			 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}			 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}			 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}			 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'xacc'}		 ... %% X acceleration (mg)
		{'yacc'}		 ... %% Y acceleration (mg)
		{'zacc'}		 ... %% Z acceleration (mg)
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 68
%%~ Hardware in the loop control outputs
function S = parse_HIL_CONTROLS(S,p)
	name = [ ...
		{'time_us'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll_ailerons'}	 ... %% Control output -3 .. 1
		{'pitch_elevator'}	 ... %% Control output -1 .. 1
		{'yaw_rudder'}		 ... %% Control output -1 .. 1
		{'throttle'}		 ... %% Throttle 0 .. 1
		{'mode'}			 ... %% System mode (MAV_MODE)
		{'nav_mode'}		 ... %% Navigation mode (MAV_NAV_MODE)
		];
	byte = [ 8 4 4 4 4 1 1 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 69
function S = parse_MANUAL_CONTROL(S,p)
	name = [ ...
		{'target'}			 ... %% The system to be controlled
		{'roll'}			 ... %% roll
		{'pitch'}			 ... %% pitch
		{'yaw'}				 ... %% yaw
		{'thrust'}			 ... %% thrust
		{'roll_manual'}		 ... %% roll control enabled auto:0, manual:1
		{'pitch_manual'}	 ... %% pitch auto:0, manual:1
		{'yaw_manual'}		 ... %% yaw auto:0, manual:1
		{'thrust_manual'}	 ... %% thrust auto:0, manual:1
		];
	byte = [ 1 4 4 4 4 1 1 1 1 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of -1 means no change to that channel. A value of 0 means 
%%~ control of that channel should be released back to the RC radio. The standard PPM 
%%~ modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual 
%%~ receivers/transmitters might violate this specification.
function S = parse_RC_CHANNELS_OVERRIDE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'chan1_raw'}		 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}		 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}		 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}		 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}		 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}		 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}		 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}		 ... %% RC channel 8 value, in microseconds
		];
	byte = [ 1 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 73
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up)
function S = parse_GLOBAL_POSITION_INT(S,p)
	name = [ ...
		{'lat'}	 ... %% Latitude, expressed as * 1E7
		{'lon'}	 ... %% Longitude, expressed as * 1E7
		{'alt'}	 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}	 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}	 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}	 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		];
	byte = [ 4 4 4 2 2 2 ];
	type = [ {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 74
%%~ Metrics typically displayed on a HUD for fixed wing aircraft
function S = parse_VFR_HUD(S,p)
	name = [ ...
		{'airspeed'}	 ... %% Current airspeed in m/s
		{'groundspeed'}	 ... %% Current ground speed in m/s
		{'heading'}		 ... %% Current heading in degrees, in compass units (0..360, 0=north)
		{'throttle'}	 ... %% Current throttle setting in integer percent, 0 to 100
		{'alt'}			 ... %% Current altitude (MSL), in meters
		{'climb'}		 ... %% Current climb rate in meters/second
		];
	byte = [ 4 4 2 2 4 4 ];
	type = [ {'single'} {'single'} {'int16'} {'uint16'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 75
%%~ Send a command with up to four parameters to the MAV
function S = parse_COMMAND(S,p)
	name = [ ...
		{'target_system'}	 ... %% System which should execute the command
		{'target_component'} ... %% Component which should execute the command, 0 for all components
		{'command'}			 ... %% Command ID, as defined by MAV_CMD enum.
		{'confirmation'}	 ... %% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
		{'param1'}			 ... %% Parameter 1, as defined by MAV_CMD enum.
		{'param2'}			 ... %% Parameter 2, as defined by MAV_CMD enum.
		{'param3'}			 ... %% Parameter 3, as defined by MAV_CMD enum.
		{'param4'}			 ... %% Parameter 4, as defined by MAV_CMD enum.
		];
	byte = [ 1 1 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 76
%%~ Report status of a command. Includes feedback wether the command was executed
function S = parse_COMMAND_ACK(S,p)
	name = [ ...
		{'command'}	 ... %% Current airspeed in m/s
		{'result'}	 ... %% 1: Action ACCEPTED and EXECUTED, 1: Action TEMPORARY REJECTED/DENIED, 2: Action PERMANENTLY DENIED, 3: Action UNKNOWN/UNSUPPORTED, 4: Requesting CONFIRMATION
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 100
%%~ Optical flow from a flow sensor (e.g. optical mouse sensor)
function S = parse_OPTICAL_FLOW(S,p)
	name = [ ...
		{'time'}			 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels in x-sensor direction
		{'flow_y'}			 ... %% Flow in pixels in y-sensor direction
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters
		];
	byte = [ 8 1 2 2 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 140
%%~ Object has been detected
function S = parse_OBJECT_DETECTION_EVENT(S,p)
	name = [ ...
		{'time'}		 ... %% Timestamp in milliseconds since system boot
		{'object_id'}	 ... %% Object ID
		{'type'}		 ... %% Object type: 0: image, 1: letter, 2: ground vehicle, 3: air vehicle, 4: surface vehicle, 5: sub-surface vehicle, 6: human, 7: animal
		{'name'}		 ... %% Name of the object as defined by the detector
		{'quality'}		 ... %% Detection quality / confidence. 0: bad, 255: maximum confidence
		{'bearing'}		 ... %% Angle of the object with respect to the body frame in NED coordinates in radians. 0: front
		{'distance'}	 ... %% Ground distance in meters
		];
	byte = [ 4 2 1 20 1 4 4 ];
	type = [ {'uint32'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 251
function S = parse_DEBUG_VECT(S,p)
	name = [ ...
		{'name'} ... %% Name
		{'usec'} ... %% Timestamp
		{'x'}	 ... %% x
		{'y'}	 ... %% y
		{'z'}	 ... %% z
		];
	byte = [ 10 8 4 4 4 ];
	type = [ {'uint8'} {'uint64'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 252
%%~ Send a key-value pair as float. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_FLOAT(S,p)
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Floating point value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 253
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_INT(S,p)
	name = [ ...
		{'name'}	 ... %% Name of the debug variable
		{'value'}	 ... %% Signed integer value
		];
	byte = [ 10 4 ];
	type = [ {'uint8'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 254
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function S = parse_STATUSTEXT(S,p)
	name = [ ...
		{'severity'} ... %% Severity of status, 0 = info message, 255 = critical fault
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'int8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 255
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function S = parse_DEBUG(S,p)
	name = [ ...
		{'ind'}		 ... %% index of debug variable
		{'value'}	 ... %% DEBUG value
		];
	byte = [ 1 4 ];
	type = [ {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 150
%%~ Offsets and calibrations values for hardware         sensors. This makes it easier 
%%~ to debug the calibration process.
function S = parse_SENSOR_OFFSETS(S,p)
	name = [ ...
		{'mag_ofs_x'}		 ... %% magnetometer X offset
		{'mag_ofs_y'}		 ... %% magnetometer Y offset
		{'mag_ofs_z'}		 ... %% magnetometer Z offset
		{'mag_declination'}	 ... %% magnetic declination (radians)
		{'raw_press'}		 ... %% raw pressure from barometer
		{'raw_temp'}		 ... %% raw temperature from barometer
		{'gyro_cal_x'}		 ... %% gyro X calibration
		{'gyro_cal_y'}		 ... %% gyro Y calibration
		{'gyro_cal_z'}		 ... %% gyro Z calibration
		{'accel_cal_x'}		 ... %% accel X calibration
		{'accel_cal_y'}		 ... %% accel Y calibration
		{'accel_cal_z'}		 ... %% accel Z calibration
		];
	byte = [ 2 2 2 4 4 4 4 4 4 4 4 4 ];
	type = [ {'int16'} {'int16'} {'int16'} {'single'} {'int32'} {'int32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 151
%%~ set the magnetometer offsets
function S = parse_SET_MAG_OFFSETS(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mag_ofs_x'}		 ... %% magnetometer X offset
		{'mag_ofs_y'}		 ... %% magnetometer Y offset
		{'mag_ofs_z'}		 ... %% magnetometer Z offset
		];
	byte = [ 1 1 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 152
%%~ state of APM memory
function S = parse_MEMINFO(S,p)
	name = [ ...
		{'brkval'}	 ... %% heap top
		{'freemem'}	 ... %% free memory
		];
	byte = [ 2 2 ];
	type = [ {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 153
%%~ raw ADC output
function S = parse_AP_ADC(S,p)
	name = [ ...
		{'adc1'} ... %% ADC output 1
		{'adc2'} ... %% ADC output 2
		{'adc3'} ... %% ADC output 3
		{'adc4'} ... %% ADC output 4
		{'adc5'} ... %% ADC output 5
		{'adc6'} ... %% ADC output 6
		];
	byte = [ 2 2 2 2 2 2 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 154
%%~ Configure on-board Camera Control System.
function S = parse_DIGICAM_CONFIGURE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mode'}			 ... %% Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
		{'shutter_speed'}	 ... %% Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
		{'aperture'}		 ... %% F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
		{'iso'}				 ... %% ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
		{'exposure_type'}	 ... %% Exposure type enumeration from 1 to N (0 means ignore)
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'engine_cut_off'}	 ... %% Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 2 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 155
%%~ Control on-board Camera Control System to take shots.
function S = parse_DIGICAM_CONTROL(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'session'}			 ... %% 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
		{'zoom_pos'}		 ... %% 1 to N //Zoom's absolute position (0 means ignore)
		{'zoom_step'}		 ... %% -100 to 100 //Zooming step value to offset zoom from the current position
		{'focus_lock'}		 ... %% 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
		{'shot'}			 ... %% 0: ignore, 1: shot or start filming
		{'command_id'}		 ... %% Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		{'extra_param'}		 ... %% Extra parameters enumeration (0 means ignore)
		{'extra_value'}		 ... %% Correspondent value to given extra_param
		];
	byte = [ 1 1 1 1 1 1 1 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 156
%%~ Message to configure a camera mount, directional antenna, etc.
function S = parse_MOUNT_CONFIGURE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'mount_mode'}		 ... %% mount operating mode (see MAV_MOUNT_MODE enum)
		{'stab_roll'}		 ... %% (1 = yes, 0 = no)
		{'stab_pitch'}		 ... %% (1 = yes, 0 = no)
		{'stab_yaw'}		 ... %% (1 = yes, 0 = no)
		];
	byte = [ 1 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 157
%%~ Message to control a camera mount, directional antenna, etc.
function S = parse_MOUNT_CONTROL(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'input_a'}			 ... %% pitch(deg*100) or lat, depending on mount mode
		{'input_b'}			 ... %% roll(deg*100) or lon depending on mount mode
		{'input_c'}			 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		{'save_position'}	 ... %% if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
		];
	byte = [ 1 1 4 4 4 1 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 158
%%~ Message with some status from APM to GCS about camera or antenna mount
function S = parse_MOUNT_STATUS(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'pointing_a'}		 ... %% pitch(deg*100) or lat, depending on mount mode
		{'pointing_b'}		 ... %% roll(deg*100) or lon depending on mount mode
		{'pointing_c'}		 ... %% yaw(deg*100) or alt (in cm) depending on mount mode
		];
	byte = [ 1 1 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'int32'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 160
%%~ A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
%%~ a point from MAV -> GCS
function S = parse_FENCE_POINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 1, 0 is for return point)
		{'count'}			 ... %% total number of points (for sanity checking)
		{'lat'}				 ... %% Latitude of point
		{'lng'}				 ... %% Longitude of point
		];
	byte = [ 1 1 1 1 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 161
%%~ Request a current fence point from MAV
function S = parse_FENCE_FETCH_POINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 1, 0 is for return point)
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 162
%%~ Status of geo-fencing. Sent in extended      status stream when fencing enabled
function S = parse_FENCE_STATUS(S,p)
	name = [ ...
		{'breach_status'}	 ... %% 0 if currently inside fence, 1 if outside
		{'breach_count'}	 ... %% number of fence breaches
		{'breach_type'}		 ... %% last breach type (see FENCE_BREACH_* enum)
		{'breach_time'}		 ... %% time of last breach in milliseconds since boot
		];
	byte = [ 1 2 1 4 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

