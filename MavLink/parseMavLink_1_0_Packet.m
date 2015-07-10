function S = parseMavLink_1_0_Packet(S,p)
	switch(p.messid)
		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			S.HEARTBEAT = parse_HEARTBEAT(S.HEARTBEAT,p);
		case 1
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
		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			S.SYSTEM_TIME = parse_SYSTEM_TIME(S.SYSTEM_TIME,p);
		case 4
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			S.PING = parse_PING(S.PING,p);
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
		case 11
			%% Set the system mode, as defined by enum MAV_MODE. There is no target component id 
			%% as the mode is by definition for the overall aircraft, not only for one component.
			S.SET_MODE = parse_SET_MODE(S.SET_MODE,p);
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
		case 24
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                 NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			S.GPS_RAW_INT = parse_GPS_RAW_INT(S.GPS_RAW_INT,p);
		case 25
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			S.GPS_STATUS = parse_GPS_STATUS(S.GPS_STATUS,p);
		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU = parse_SCALED_IMU(S.SCALED_IMU,p);
		case 27
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			S.RAW_IMU = parse_RAW_IMU(S.RAW_IMU,p);
		case 28
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			S.RAW_PRESSURE = parse_RAW_PRESSURE(S.RAW_PRESSURE,p);
		case 29
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			S.SCALED_PRESSURE = parse_SCALED_PRESSURE(S.SCALED_PRESSURE,p);
		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			S.ATTITUDE = parse_ATTITUDE(S.ATTITUDE,p);
		case 31
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
			%% expressed as quaternion.
			S.ATTITUDE_QUATERNION = parse_ATTITUDE_QUATERNION(S.ATTITUDE_QUATERNION,p);
		case 32
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
			%% convention)
			S.LOCAL_POSITION_NED = parse_LOCAL_POSITION_NED(S.LOCAL_POSITION_NED,p);
		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
			%% message since the resolution of float is not sufficient.
			S.GLOBAL_POSITION_INT = parse_GLOBAL_POSITION_INT(S.GLOBAL_POSITION_INT,p);
		case 34
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000. Channels that are inactive should be set to UINT16_MAX.
			S.RC_CHANNELS_SCALED = parse_RC_CHANNELS_SCALED(S.RC_CHANNELS_SCALED,p);
		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			S.RC_CHANNELS_RAW = parse_RC_CHANNELS_RAW(S.RC_CHANNELS_RAW,p);
		case 36
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			S.SERVO_OUTPUT_RAW = parse_SERVO_OUTPUT_RAW(S.SERVO_OUTPUT_RAW,p);
		case 37
			%% Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
			%% If start and end index are the same, just 
			%% send one waypoint.
			S.MISSION_REQUEST_PARTIAL_LIST = parse_MISSION_REQUEST_PARTIAL_LIST(S.MISSION_REQUEST_PARTIAL_LIST,p);
		case 38
			%% This message is sent to the MAV to write a partial list. If start index == end index, 
			%% only one item will be transmitted / updated. If the start index is NOT 0 and 
			%% above the current list size, this request should be REJECTED!
			S.MISSION_WRITE_PARTIAL_LIST = parse_MISSION_WRITE_PARTIAL_LIST(S.MISSION_WRITE_PARTIAL_LIST,p);
		case 39
			%% Message encoding a mission item. This message is emitted to announce            
			%%      the presence of a mission item and to set a mission item on the system. The 
			%% mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
			%% Local frame is Z-down, right handed (NED), global frame is Z-up, right 
			%% handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
			S.MISSION_ITEM = parse_MISSION_ITEM(S.MISSION_ITEM,p);
		case 40
			%% Request the information of the mission item with the sequence number seq. The response 
			%% of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
			S.MISSION_REQUEST = parse_MISSION_REQUEST(S.MISSION_REQUEST,p);
		case 41
			%% Set the mission item with sequence number seq as current item. This means that the 
			%% MAV will continue to this mission item on the shortest path (not following the 
			%% mission items in-between).
			S.MISSION_SET_CURRENT = parse_MISSION_SET_CURRENT(S.MISSION_SET_CURRENT,p);
		case 42
			%% Message that announces the sequence number of the current active mission item. The 
			%% MAV will fly towards this mission item.
			S.MISSION_CURRENT = parse_MISSION_CURRENT(S.MISSION_CURRENT,p);
		case 43
			%% Request the overall list of mission items from the system/component.
			S.MISSION_REQUEST_LIST = parse_MISSION_REQUEST_LIST(S.MISSION_REQUEST_LIST,p);
		case 44
			%% This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
			%% a write transaction. The GCS can then request the individual mission item 
			%% based on the knowledge of the total number of MISSIONs.
			S.MISSION_COUNT = parse_MISSION_COUNT(S.MISSION_COUNT,p);
		case 45
			%% Delete all mission items at once.
			S.MISSION_CLEAR_ALL = parse_MISSION_CLEAR_ALL(S.MISSION_CLEAR_ALL,p);
		case 46
			%% A certain mission item has been reached. The system will either hold this position 
			%% (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
			%% to the next MISSION.
			S.MISSION_ITEM_REACHED = parse_MISSION_ITEM_REACHED(S.MISSION_ITEM_REACHED,p);
		case 47
			%% Ack message during MISSION handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			S.MISSION_ACK = parse_MISSION_ACK(S.MISSION_ACK,p);
		case 48
			%% As local waypoints exist, the global MISSION reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should move 
			%% from in- to outdoor.
			S.SET_GPS_GLOBAL_ORIGIN = parse_SET_GPS_GLOBAL_ORIGIN(S.SET_GPS_GLOBAL_ORIGIN,p);
		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			S.GPS_GLOBAL_ORIGIN = parse_GPS_GLOBAL_ORIGIN(S.GPS_GLOBAL_ORIGIN,p);
		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			S.SET_LOCAL_POSITION_SETPOINT = parse_SET_LOCAL_POSITION_SETPOINT(S.SET_LOCAL_POSITION_SETPOINT,p);
		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.LOCAL_POSITION_SETPOINT = parse_LOCAL_POSITION_SETPOINT(S.LOCAL_POSITION_SETPOINT,p);
		case 52
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.GLOBAL_POSITION_SETPOINT_INT = parse_GLOBAL_POSITION_SETPOINT_INT(S.GLOBAL_POSITION_SETPOINT_INT,p);
		case 53
			%% Set the current global position setpoint.
			S.SET_GLOBAL_POSITION_SETPOINT_INT = parse_SET_GLOBAL_POSITION_SETPOINT_INT(S.SET_GLOBAL_POSITION_SETPOINT_INT,p);
		case 54
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/MISSIONs to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			S.SAFETY_SET_ALLOWED_AREA = parse_SAFETY_SET_ALLOWED_AREA(S.SAFETY_SET_ALLOWED_AREA,p);
		case 55
			%% Read out the safety zone the MAV currently assumes.
			S.SAFETY_ALLOWED_AREA = parse_SAFETY_ALLOWED_AREA(S.SAFETY_ALLOWED_AREA,p);
		case 56
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_THRUST = parse_SET_ROLL_PITCH_YAW_THRUST(S.SET_ROLL_PITCH_YAW_THRUST,p);
		case 57
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_SPEED_THRUST = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST(S.SET_ROLL_PITCH_YAW_SPEED_THRUST,p);
		case 58
			%% Setpoint in roll, pitch, yaw currently active on the system.
			S.ROLL_PITCH_YAW_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_THRUST_SETPOINT(S.ROLL_PITCH_YAW_THRUST_SETPOINT,p);
		case 59
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT,p);
		case 60
			%% Setpoint in the four motor speeds
			S.SET_QUAD_MOTORS_SETPOINT = parse_SET_QUAD_MOTORS_SETPOINT(S.SET_QUAD_MOTORS_SETPOINT,p);
		case 61
			%% Setpoint for up to four quadrotors in a group / wing
			S.SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST = parse_SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST(S.SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST,p);
		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters.
			S.NAV_CONTROLLER_OUTPUT = parse_NAV_CONTROLLER_OUTPUT(S.NAV_CONTROLLER_OUTPUT,p);
		case 63
			%% Setpoint for up to four quadrotors in a group / wing
			S.SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST = parse_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST(S.SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST,p);
		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			S.STATE_CORRECTION = parse_STATE_CORRECTION(S.STATE_CORRECTION,p);
		case 66
			S.REQUEST_DATA_STREAM = parse_REQUEST_DATA_STREAM(S.REQUEST_DATA_STREAM,p);
		case 67
			S.DATA_STREAM = parse_DATA_STREAM(S.DATA_STREAM,p);
		case 69
			%% This message provides an API for manually controlling the vehicle using standard 
			%% joystick axes nomenclature, along with a joystick-like input device. Unused axes 
			%% can be disabled an buttons are also transmit as boolean values of their 
			S.MANUAL_CONTROL = parse_MANUAL_CONTROL(S.MANUAL_CONTROL,p);
		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
			%% 0 means control of that channel should be released back to the RC radio. The standard 
			%% PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			S.RC_CHANNELS_OVERRIDE = parse_RC_CHANNELS_OVERRIDE(S.RC_CHANNELS_OVERRIDE,p);
		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			S.VFR_HUD = parse_VFR_HUD(S.VFR_HUD,p);
		case 76
			%% Send a command with up to seven parameters to the MAV
			S.COMMAND_LONG = parse_COMMAND_LONG(S.COMMAND_LONG,p);
		case 77
			%% Report status of a command. Includes feedback wether the command was executed.
			S.COMMAND_ACK = parse_COMMAND_ACK(S.COMMAND_ACK,p);
		case 80
			%% Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
			S.ROLL_PITCH_YAW_RATES_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT(S.ROLL_PITCH_YAW_RATES_THRUST_SETPOINT,p);
		case 81
			%% Setpoint in roll, pitch, yaw and thrust from the operator
			S.MANUAL_SETPOINT = parse_MANUAL_SETPOINT(S.MANUAL_SETPOINT,p);
		case 89
			%% The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
			%% the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
			%% Z-axis down (aeronautical frame, NED / north-east-down convention)
			S.LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET = parse_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET(S.LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET,p);
		case 90
			%% DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
			%% Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
			%% autopilot. This packet is useful for high throughput applications such as hardware 
			%% in the loop simulations.
			S.HIL_STATE = parse_HIL_STATE(S.HIL_STATE,p);
		case 91
			%% Sent from autopilot to simulation. Hardware in the loop control outputs
			S.HIL_CONTROLS = parse_HIL_CONTROLS(S.HIL_CONTROLS,p);
		case 92
			%% Sent from simulation to autopilot. The RAW values of the RC channels received. The 
			%% standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			S.HIL_RC_INPUTS_RAW = parse_HIL_RC_INPUTS_RAW(S.HIL_RC_INPUTS_RAW,p);
		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			S.OPTICAL_FLOW = parse_OPTICAL_FLOW(S.OPTICAL_FLOW,p);
		case 101
			S.GLOBAL_VISION_POSITION_ESTIMATE = parse_GLOBAL_VISION_POSITION_ESTIMATE(S.GLOBAL_VISION_POSITION_ESTIMATE,p);
		case 102
			S.VISION_POSITION_ESTIMATE = parse_VISION_POSITION_ESTIMATE(S.VISION_POSITION_ESTIMATE,p);
		case 103
			S.VISION_SPEED_ESTIMATE = parse_VISION_SPEED_ESTIMATE(S.VISION_SPEED_ESTIMATE,p);
		case 104
			S.VICON_POSITION_ESTIMATE = parse_VICON_POSITION_ESTIMATE(S.VICON_POSITION_ESTIMATE,p);
		case 105
			%% The IMU readings in SI units in NED body frame
			S.HIGHRES_IMU = parse_HIGHRES_IMU(S.HIGHRES_IMU,p);
		case 106
			%% Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
			S.OMNIDIRECTIONAL_FLOW = parse_OMNIDIRECTIONAL_FLOW(S.OMNIDIRECTIONAL_FLOW,p);
		case 107
			%% The IMU readings in SI units in NED body frame
			S.HIL_SENSOR = parse_HIL_SENSOR(S.HIL_SENSOR,p);
		case 108
			%% Status of simulation environment, if used
			S.SIM_STATE = parse_SIM_STATE(S.SIM_STATE,p);
		case 109
			%% Status generated by radio
			S.RADIO_STATUS = parse_RADIO_STATUS(S.RADIO_STATUS,p);
		case 110
			%% Begin file transfer
			S.FILE_TRANSFER_START = parse_FILE_TRANSFER_START(S.FILE_TRANSFER_START,p);
		case 111
			%% Get directory listing
			S.FILE_TRANSFER_DIR_LIST = parse_FILE_TRANSFER_DIR_LIST(S.FILE_TRANSFER_DIR_LIST,p);
		case 112
			%% File transfer result
			S.FILE_TRANSFER_RES = parse_FILE_TRANSFER_RES(S.FILE_TRANSFER_RES,p);
		case 113
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                  NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			S.HIL_GPS = parse_HIL_GPS(S.HIL_GPS,p);
		case 114
			%% Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
			S.HIL_OPTICAL_FLOW = parse_HIL_OPTICAL_FLOW(S.HIL_OPTICAL_FLOW,p);
		case 115
			%% Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
			%% This packet is useful for high throughput applications such as hardware in the 
			%% loop simulations.
			S.HIL_STATE_QUATERNION = parse_HIL_STATE_QUATERNION(S.HIL_STATE_QUATERNION,p);
		case 116
			%% The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU2 = parse_SCALED_IMU2(S.SCALED_IMU2,p);
		case 117
			%% Request a list of available logs. On some systems calling this may stop on-board 
			%% logging until LOG_REQUEST_END is called.
			S.LOG_REQUEST_LIST = parse_LOG_REQUEST_LIST(S.LOG_REQUEST_LIST,p);
		case 118
			%% Reply to LOG_REQUEST_LIST
			S.LOG_ENTRY = parse_LOG_ENTRY(S.LOG_ENTRY,p);
		case 119
			%% Request a chunk of a log
			S.LOG_REQUEST_DATA = parse_LOG_REQUEST_DATA(S.LOG_REQUEST_DATA,p);
		case 120
			%% Reply to LOG_REQUEST_DATA
			S.LOG_DATA = parse_LOG_DATA(S.LOG_DATA,p);
		case 121
			%% Erase all logs
			S.LOG_ERASE = parse_LOG_ERASE(S.LOG_ERASE,p);
		case 122
			%% Stop log transfer and resume normal logging
			S.LOG_REQUEST_END = parse_LOG_REQUEST_END(S.LOG_REQUEST_END,p);
		case 147
			%% Transmitte battery informations for a accu pack.
			S.BATTERY_STATUS = parse_BATTERY_STATUS(S.BATTERY_STATUS,p);
		case 148
			%% Set the 8 DOF setpoint for a controller.
			S.SETPOINT_8DOF = parse_SETPOINT_8DOF(S.SETPOINT_8DOF,p);
		case 149
			%% Set the 6 DOF setpoint for a attitude and position controller.
			S.SETPOINT_6DOF = parse_SETPOINT_6DOF(S.SETPOINT_6DOF,p);
		case 249
			%% Send raw controller memory. The use of this message is discouraged for normal packets, 
			%% but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.MEMORY_VECT = parse_MEMORY_VECT(S.MEMORY_VECT,p);
		case 250
			S.DEBUG_VECT = parse_DEBUG_VECT(S.DEBUG_VECT,p);
		case 251
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_FLOAT = parse_NAMED_VALUE_FLOAT(S.NAMED_VALUE_FLOAT,p);
		case 252
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_INT = parse_NAMED_VALUE_INT(S.NAMED_VALUE_INT,p);
		case 253
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			S.STATUSTEXT = parse_STATUSTEXT(S.STATUSTEXT,p);
		case 254
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
		case 163
			%% Status of DCM attitude estimator
			S.AHRS = parse_AHRS(S.AHRS,p);
		case 164
			%% Status of simulation environment, if used
			S.SIMSTATE = parse_SIMSTATE(S.SIMSTATE,p);
		case 165
			%% Status of key hardware
			S.HWSTATUS = parse_HWSTATUS(S.HWSTATUS,p);
		case 166
			%% Status generated by radio
			S.RADIO = parse_RADIO(S.RADIO,p);
		case 167
			%% Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
			S.LIMITS_STATUS = parse_LIMITS_STATUS(S.LIMITS_STATUS,p);
		case 168
			%% Wind estimation
			S.WIND = parse_WIND(S.WIND,p);
		case 169
			%% Data packet, size 16
			S.DATA16 = parse_DATA16(S.DATA16,p);
		case 170
			%% Data packet, size 32
			S.DATA32 = parse_DATA32(S.DATA32,p);
		case 171
			%% Data packet, size 64
			S.DATA64 = parse_DATA64(S.DATA64,p);
		case 172
			%% Data packet, size 96
			S.DATA96 = parse_DATA96(S.DATA96,p);
		case 173
			%% Rangefinder reporting
			S.RANGEFINDER = parse_RANGEFINDER(S.RANGEFINDER,p);
		case 174
			%% Airspeed auto-calibration
			S.AIRSPEED_AUTOCAL = parse_AIRSPEED_AUTOCAL(S.AIRSPEED_AUTOCAL,p);
		case 175
			%% A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
			%% from MAV -> GCS
			S.RALLY_POINT = parse_RALLY_POINT(S.RALLY_POINT,p);
		case 176
			%% Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
			%% MAV should not respond if the request is invalid.
			S.RALLY_FETCH_POINT = parse_RALLY_FETCH_POINT(S.RALLY_FETCH_POINT,p);
		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
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
		{'autopilot'}		 ... %% Autopilot type / class. defined in MAV_AUTOPILOT ENUM
		{'base_mode'}		 ... %% System mode bitfield, see MAV_MODE_FLAGS ENUM in mavlink/include/mavlink_types.h
		{'custom_mode'}		 ... %% A bitfield for use for autopilot-specific flags.
		{'system_status'}	 ... %% System status flag, see MAV_STATE ENUM
		{'mavlink_version'}	 ... %% MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
		];
	byte = [ 1 1 1 4 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 1
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
		{'onboard_control_sensors_present'}	 ... %% Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		{'onboard_control_sensors_enabled'}	 ... %% Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		{'onboard_control_sensors_health'}	 ... %% Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		{'load'}							 ... %% Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
		{'voltage_battery'}					 ... %% Battery voltage, in millivolts (1 = 1 millivolt)
		{'current_battery'}					 ... %% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		{'battery_remaining'}				 ... %% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot estimate the remaining battery
		{'drop_rate_comm'}					 ... %% Communication drops in percent, (0%: 0, 100%: 10'000), (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
		{'errors_comm'}						 ... %% Communication errors (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
		{'errors_count1'}					 ... %% Autopilot-specific errors
		{'errors_count2'}					 ... %% Autopilot-specific errors
		{'errors_count3'}					 ... %% Autopilot-specific errors
		{'errors_count4'}					 ... %% Autopilot-specific errors
		];
	byte = [ 4 4 4 2 2 2 1 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'uint32'} {'uint32'} {'uint16'} {'uint16'} {'int16'} {'int8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
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
		{'time_unix_usec'}	 ... %% Timestamp of the master clock in microseconds since UNIX epoch.
		{'time_boot_ms'}	 ... %% Timestamp of the component clock since boot time in milliseconds.
		];
	byte = [ 8 4 ];
	type = [ {'uint64'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 4
%%~ A ping message either requesting or responding to a ping. This allows to measure 
%%~ the system latencies, including serial port, radio modem and UDP connections.
function S = parse_PING(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Unix timestamp in microseconds
		{'seq'}				 ... %% PING sequence
		{'target_system'}	 ... %% 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		{'target_component'} ... %% 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
		];
	byte = [ 8 4 1 1 ];
	type = [ {'uint64'} {'uint32'} {'uint8'} {'uint8'} ];
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


%%  case: 11
%%~ Set the system mode, as defined by enum MAV_MODE. There is no target component id 
%%~ as the mode is by definition for the overall aircraft, not only for one component.
function S = parse_SET_MODE(S,p)
	name = [ ...
		{'target_system'}	 ... %% The system setting the mode
		{'base_mode'}		 ... %% The new base mode
		{'custom_mode'}		 ... %% The new autopilot-specific mode. This field can be ignored by an autopilot.
		];
	byte = [ 1 1 4 ];
	type = [ {'uint8'} {'uint8'} {'uint32'} ];
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
		{'param_id'}		 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_index'}		 ... %% Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)
		];
	byte = [ 1 1 16 2 ];
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
		{'param_id'}	 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_value'}	 ... %% Onboard parameter value
		{'param_type'}	 ... %% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
		{'param_count'}	 ... %% Total number of onboard parameters
		{'param_index'}	 ... %% Index of this onboard parameter
		];
	byte = [ 16 4 1 2 2 ];
	type = [ {'uint8'} {'single'} {'uint8'} {'uint16'} {'uint16'} ];
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
		{'param_id'}		 ... %% Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		{'param_value'}		 ... %% Onboard parameter value
		{'param_type'}		 ... %% Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
		];
	byte = [ 1 1 16 4 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 24
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~                 NOT the global position estimate of the sytem, but rather a RAW 
%%~ sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
%%~ frame is right-handed, Z-axis up (GPS frame).
function S = parse_GPS_RAW_INT(S,p)
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'}			 ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}					 ... %% Latitude (WGS84), in degrees * 1E7
		{'lon'}					 ... %% Longitude (WGS84), in degrees * 1E7
		{'alt'}					 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'eph'}					 ... %% GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		{'epv'}					 ... %% GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		{'vel'}					 ... %% GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
		{'cog'}					 ... %% Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		{'satellites_visible'}	 ... %% Number of satellites visible. If unknown, set to 255
		];
	byte = [ 8 1 4 4 4 2 2 2 2 1 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 25
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


%%  case: 26
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
%%~ the scaled values to the described units
function S = parse_SCALED_IMU(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'xacc'}		 ... %% X acceleration (mg)
		{'yacc'}		 ... %% Y acceleration (mg)
		{'zacc'}		 ... %% Z acceleration (mg)
		{'xgyro'}		 ... %% Angular speed around X axis (millirad /sec)
		{'ygyro'}		 ... %% Angular speed around Y axis (millirad /sec)
		{'zgyro'}		 ... %% Angular speed around Z axis (millirad /sec)
		{'xmag'}		 ... %% X Magnetic field (milli tesla)
		{'ymag'}		 ... %% Y Magnetic field (milli tesla)
		{'zmag'}		 ... %% Z Magnetic field (milli tesla)
		];
	byte = [ 4 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 27
%%~ The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
%%~ contain the true raw values without any scaling to allow data capture and system 
%%~ debugging.
function S = parse_RAW_IMU(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'xacc'}		 ... %% X acceleration (raw)
		{'yacc'}		 ... %% Y acceleration (raw)
		{'zacc'}		 ... %% Z acceleration (raw)
		{'xgyro'}		 ... %% Angular speed around X axis (raw)
		{'ygyro'}		 ... %% Angular speed around Y axis (raw)
		{'zgyro'}		 ... %% Angular speed around Z axis (raw)
		{'xmag'}		 ... %% X Magnetic field (raw)
		{'ymag'}		 ... %% Y Magnetic field (raw)
		{'zmag'}		 ... %% Z Magnetic field (raw)
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 28
%%~ The RAW pressure readings for the typical setup of one absolute pressure and one 
%%~ differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
%%~ values.
function S = parse_RAW_PRESSURE(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
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


%%  case: 29
%%~ The pressure readings for the typical setup of one absolute and differential pressure 
%%~ sensor. The units are as specified in each field.
function S = parse_SCALED_PRESSURE(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'press_abs'}	 ... %% Absolute pressure (hectopascal)
		{'press_diff'}	 ... %% Differential pressure 1 (hectopascal)
		{'temperature'}	 ... %% Temperature measurement (0.01 degrees celsius)
		];
	byte = [ 4 4 4 2 ];
	type = [ {'uint32'} {'single'} {'single'} {'int16'} ];
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
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad, -pi..+pi)
		{'pitch'}		 ... %% Pitch angle (rad, -pi..+pi)
		{'yaw'}			 ... %% Yaw angle (rad, -pi..+pi)
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 31
%%~ The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
%%~ expressed as quaternion.
function S = parse_ATTITUDE_QUATERNION(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'q1'}			 ... %% Quaternion component 1
		{'q2'}			 ... %% Quaternion component 2
		{'q3'}			 ... %% Quaternion component 3
		{'q4'}			 ... %% Quaternion component 4
		{'rollspeed'}	 ... %% Roll angular speed (rad/s)
		{'pitchspeed'}	 ... %% Pitch angular speed (rad/s)
		{'yawspeed'}	 ... %% Yaw angular speed (rad/s)
		];
	byte = [ 4 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 32
%%~ The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
%%~ frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
%%~ convention)
function S = parse_LOCAL_POSITION_NED(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'x'}			 ... %% X Position
		{'y'}			 ... %% Y Position
		{'z'}			 ... %% Z Position
		{'vx'}			 ... %% X Speed
		{'vy'}			 ... %% Y Speed
		{'vz'}			 ... %% Z Speed
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 33
%%~ The filtered global position (e.g. fused GPS and accelerometers). The position is 
%%~ in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
%%~ message since the resolution of float is not sufficient.
function S = parse_GLOBAL_POSITION_INT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'lat'}			 ... %% Latitude, expressed as * 1E7
		{'lon'}			 ... %% Longitude, expressed as * 1E7
		{'alt'}			 ... %% Altitude in meters, expressed as * 1000 (millimeters), above MSL
		{'relative_alt'} ... %% Altitude above ground in meters, expressed as * 1000 (millimeters)
		{'vx'}			 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}			 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}			 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'hdg'}			 ... %% Compass heading in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		];
	byte = [ 4 4 4 4 4 2 2 2 2 ];
	type = [ {'uint32'} {'int32'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 34
%%~ The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
%%~ 10000. Channels that are inactive should be set to UINT16_MAX.
function S = parse_RC_CHANNELS_SCALED(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		{'chan1_scaled'} ... %% RC channel 1 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan2_scaled'} ... %% RC channel 2 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan3_scaled'} ... %% RC channel 3 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan4_scaled'} ... %% RC channel 4 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan5_scaled'} ... %% RC channel 5 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan6_scaled'} ... %% RC channel 6 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan7_scaled'} ... %% RC channel 7 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'chan8_scaled'} ... %% RC channel 8 value scaled, (-100%) -10000, (0%) 0, (100%) 10000, (invalid) INT16_MAX.
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint32'} {'uint8'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint8'} ];
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
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 100: 100%, 255: invalid/unknown.
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 36
%%~ The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
%%~ messages). The standard PPM modulation is as follows: 1000 microseconds: 
%%~ 0%, 2000 microseconds: 100%.
function S = parse_SERVO_OUTPUT_RAW(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since system boot)
		{'port'}		 ... %% Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows to encode more than 8 servos.
		{'servo1_raw'}	 ... %% Servo output 1 value, in microseconds
		{'servo2_raw'}	 ... %% Servo output 2 value, in microseconds
		{'servo3_raw'}	 ... %% Servo output 3 value, in microseconds
		{'servo4_raw'}	 ... %% Servo output 4 value, in microseconds
		{'servo5_raw'}	 ... %% Servo output 5 value, in microseconds
		{'servo6_raw'}	 ... %% Servo output 6 value, in microseconds
		{'servo7_raw'}	 ... %% Servo output 7 value, in microseconds
		{'servo8_raw'}	 ... %% Servo output 8 value, in microseconds
		];
	byte = [ 4 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 37
%%~ Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
%%~ If start and end index are the same, just 
%%~ send one waypoint.
function S = parse_MISSION_REQUEST_PARTIAL_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default
		{'end_index'}		 ... %% End index, -1 by default (-1: send list to end). Else a valid index of the list
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 38
%%~ This message is sent to the MAV to write a partial list. If start index == end index, 
%%~ only one item will be transmitted / updated. If the start index is NOT 0 and 
%%~ above the current list size, this request should be REJECTED!
function S = parse_MISSION_WRITE_PARTIAL_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start_index'}		 ... %% Start index, 0 by default and smaller / equal to the largest index of the current onboard list.
		{'end_index'}		 ... %% End index, equal or greater than start index.
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 39
%%~ Message encoding a mission item. This message is emitted to announce            
%%~      the presence of a mission item and to set a mission item on the system. The 
%%~ mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
%%~ Local frame is Z-down, right handed (NED), global frame is Z-up, right 
%%~ handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
function S = parse_MISSION_ITEM(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'seq'}				 ... %% Sequence
		{'frame'}			 ... %% The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
		{'command'}			 ... %% The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
		{'current'}			 ... %% false:0, true:1
		{'autocontinue'}	 ... %% autocontinue to next wp
		{'param1'}			 ... %% PARAM1 / For NAV command MISSIONs: Radius in which the MISSION is accepted as reached, in meters
		{'param2'}			 ... %% PARAM2 / For NAV command MISSIONs: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
		{'param3'}			 ... %% PARAM3 / For LOITER command MISSIONs: Orbit to circle around the MISSION, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
		{'param4'}			 ... %% PARAM4 / For NAV and LOITER command MISSIONs: Yaw orientation in degrees, [0..360] 0 = NORTH
		{'x'}				 ... %% PARAM5 / local: x position, global: latitude
		{'y'}				 ... %% PARAM6 / y position: global: longitude
		{'z'}				 ... %% PARAM7 / z position: global: altitude
		];
	byte = [ 1 1 2 1 2 1 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'uint16'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 40
%%~ Request the information of the mission item with the sequence number seq. The response 
%%~ of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
function S = parse_MISSION_REQUEST(S,p)
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
%%~ Set the mission item with sequence number seq as current item. This means that the 
%%~ MAV will continue to this mission item on the shortest path (not following the 
%%~ mission items in-between).
function S = parse_MISSION_SET_CURRENT(S,p)
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
%%~ Message that announces the sequence number of the current active mission item. The 
%%~ MAV will fly towards this mission item.
function S = parse_MISSION_CURRENT(S,p)
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
%%~ Request the overall list of mission items from the system/component.
function S = parse_MISSION_REQUEST_LIST(S,p)
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
%%~ This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
%%~ a write transaction. The GCS can then request the individual mission item 
%%~ based on the knowledge of the total number of MISSIONs.
function S = parse_MISSION_COUNT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'count'}			 ... %% Number of mission items in the sequence
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
%%~ Delete all mission items at once.
function S = parse_MISSION_CLEAR_ALL(S,p)
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
%%~ A certain mission item has been reached. The system will either hold this position 
%%~ (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
%%~ to the next MISSION.
function S = parse_MISSION_ITEM_REACHED(S,p)
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
%%~ Ack message during MISSION handling. The type field states if this message is a 
%%~ positive ack (type=0) or if an error happened (type=non-zero).
function S = parse_MISSION_ACK(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'type'}			 ... %% See MAV_MISSION_RESULT enum
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
%%~ As local waypoints exist, the global MISSION reference allows to transform between 
%%~ the local coordinate frame and the global (GPS) coordinate frame. This can be 
%%~ necessary when e.g. in- and outdoor settings are connected and the MAV should move 
%%~ from in- to outdoor.
function S = parse_SET_GPS_GLOBAL_ORIGIN(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84, in degrees * 1E7
		{'altitude'}		 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		];
	byte = [ 1 4 4 4 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 49
%%~ Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
%%~ (0,0,0) position
function S = parse_GPS_GLOBAL_ORIGIN(S,p)
	name = [ ...
		{'latitude'}	 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}	 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}	 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
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
%%~ coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
%%~ to the onboard position controller. As some MAVs have a degree of freedom in 
%%~ yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
function S = parse_SET_LOCAL_POSITION_SETPOINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 1 1 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
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
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		{'x'}				 ... %% x position
		{'y'}				 ... %% y position
		{'z'}				 ... %% z position
		{'yaw'}				 ... %% Desired yaw angle
		];
	byte = [ 1 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 52
%%~ Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
%%~ and to the GCS.
function S = parse_GLOBAL_POSITION_SETPOINT_INT(S,p)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}		 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'yaw'}				 ... %% Desired yaw angle in degrees * 100
		];
	byte = [ 1 4 4 4 2 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 53
%%~ Set the current global position setpoint.
function S = parse_SET_GLOBAL_POSITION_SETPOINT_INT(S,p)
	name = [ ...
		{'coordinate_frame'} ... %% Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		{'latitude'}		 ... %% Latitude (WGS84), in degrees * 1E7
		{'longitude'}		 ... %% Longitude (WGS84), in degrees * 1E7
		{'altitude'}		 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'yaw'}				 ... %% Desired yaw angle in degrees * 100
		];
	byte = [ 1 4 4 4 2 ];
	type = [ {'uint8'} {'int32'} {'int32'} {'int32'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 54
%%~ Set a safety zone (volume), which is defined by two corners of a cube. This message 
%%~ can be used to tell the MAV which setpoints/MISSIONs to accept and which to 
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


%%  case: 55
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


%%  case: 56
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


%%  case: 57
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


%%  case: 58
%%~ Setpoint in roll, pitch, yaw currently active on the system.
function S = parse_ROLL_PITCH_YAW_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll'}		 ... %% Desired roll angle in radians
		{'pitch'}		 ... %% Desired pitch angle in radians
		{'yaw'}			 ... %% Desired yaw angle in radians
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 59
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
function S = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll_speed'}	 ... %% Desired roll angular speed in rad/s
		{'pitch_speed'}	 ... %% Desired pitch angular speed in rad/s
		{'yaw_speed'}	 ... %% Desired yaw angular speed in rad/s
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 60
%%~ Setpoint in the four motor speeds
function S = parse_SET_QUAD_MOTORS_SETPOINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID of the system that should set these motor commands
		{'motor_front_nw'}	 ... %% Front motor in + configuration, front left motor in x configuration
		{'motor_right_ne'}	 ... %% Right motor in + configuration, front right motor in x configuration
		{'motor_back_se'}	 ... %% Back motor in + configuration, back right motor in x configuration
		{'motor_left_sw'}	 ... %% Left motor in + configuration, back left motor in x configuration
		];
	byte = [ 1 2 2 2 2 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 61
%%~ Setpoint for up to four quadrotors in a group / wing
function S = parse_SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST(S,p)
	name = [ ...
		{'group'}	 ... %% ID of the quadrotor group (0 - 255, up to 256 groups supported)
		{'mode'}	 ... %% ID of the flight mode (0 - 255, up to 256 modes supported)
		{'roll'}	 ... %% Desired roll angle in radians +-PI (+-INT16_MAX)
		{'pitch'}	 ... %% Desired pitch angle in radians +-PI (+-INT16_MAX)
		{'yaw'}		 ... %% Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
		{'thrust'}	 ... %% Collective thrust, scaled to uint16 (0..UINT16_MAX)
		];
	byte = [ 1 1 8 8 8 8 ];
	type = [ {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 62
%%~ Outputs of the APM navigation controller. The primary use of this message is to 
%%~ check the response and signs of the controller before actual flight and to assist 
%%~ with tuning controller parameters.
function S = parse_NAV_CONTROLLER_OUTPUT(S,p)
	name = [ ...
		{'nav_roll'}		 ... %% Current desired roll in degrees
		{'nav_pitch'}		 ... %% Current desired pitch in degrees
		{'nav_bearing'}		 ... %% Current desired heading in degrees
		{'target_bearing'}	 ... %% Bearing to current MISSION/target in degrees
		{'wp_dist'}			 ... %% Distance to active MISSION in meters
		{'alt_error'}		 ... %% Current altitude error in meters
		{'aspd_error'}		 ... %% Current airspeed error in meters/second
		{'xtrack_error'}	 ... %% Current crosstrack error on x-y plane in meters
		{'nav_wptrad'}		 ... %% Navigation waypoint radius in meters
		];
	byte = [ 4 4 2 2 2 4 4 4 4 ];
	type = [ {'single'} {'single'} {'int16'} {'int16'} {'uint16'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 63
%%~ Setpoint for up to four quadrotors in a group / wing
function S = parse_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST(S,p)
	name = [ ...
		{'group'}		 ... %% ID of the quadrotor group (0 - 255, up to 256 groups supported)
		{'mode'}		 ... %% ID of the flight mode (0 - 255, up to 256 modes supported)
		{'led_red'}		 ... %% RGB red channel (0-255)
		{'led_blue'}	 ... %% RGB green channel (0-255)
		{'led_green'}	 ... %% RGB blue channel (0-255)
		{'roll'}		 ... %% Desired roll angle in radians +-PI (+-INT16_MAX)
		{'pitch'}		 ... %% Desired pitch angle in radians +-PI (+-INT16_MAX)
		{'yaw'}			 ... %% Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
		{'thrust'}		 ... %% Collective thrust, scaled to uint16 (0..UINT16_MAX)
		];
	byte = [ 1 1 4 4 4 8 8 8 8 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int16'} {'int16'} {'int16'} {'uint16'} ];
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


%%  case: 66
function S = parse_REQUEST_DATA_STREAM(S,p)
	name = [ ...
		{'target_system'}	 ... %% The target requested to send the message stream.
		{'target_component'} ... %% The target requested to send the message stream.
		{'req_stream_id'}	 ... %% The ID of the requested data stream
		{'req_message_rate'} ... %% The requested interval between two messages of this type
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
function S = parse_DATA_STREAM(S,p)
	name = [ ...
		{'stream_id'}	 ... %% The ID of the requested data stream
		{'message_rate'} ... %% The requested interval between two messages of this type
		{'on_off'}		 ... %% 1 stream is enabled, 0 stream is stopped.
		];
	byte = [ 1 2 1 ];
	type = [ {'uint8'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 69
%%~ This message provides an API for manually controlling the vehicle using standard 
%%~ joystick axes nomenclature, along with a joystick-like input device. Unused axes 
%%~ can be disabled an buttons are also transmit as boolean values of their 
function S = parse_MANUAL_CONTROL(S,p)
	name = [ ...
		{'target'}	 ... %% The system to be controlled.
		{'x'}		 ... %% X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
		{'y'}		 ... %% Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
		{'z'}		 ... %% Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
		{'r'}		 ... %% R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
		{'buttons'}	 ... %% A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
		];
	byte = [ 1 2 2 2 2 2 ];
	type = [ {'uint8'} {'int16'} {'int16'} {'int16'} {'int16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 70
%%~ The RAW values of the RC channels sent to the MAV to override info received from 
%%~ the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
%%~ 0 means control of that channel should be released back to the RC radio. The standard 
%%~ PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function S = parse_RC_CHANNELS_OVERRIDE(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'chan1_raw'}		 ... %% RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan2_raw'}		 ... %% RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan3_raw'}		 ... %% RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan4_raw'}		 ... %% RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan5_raw'}		 ... %% RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan6_raw'}		 ... %% RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan7_raw'}		 ... %% RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		{'chan8_raw'}		 ... %% RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		];
	byte = [ 1 1 2 2 2 2 2 2 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} ];
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


%%  case: 76
%%~ Send a command with up to seven parameters to the MAV
function S = parse_COMMAND_LONG(S,p)
	name = [ ...
		{'target_system'}	 ... %% System which should execute the command
		{'target_component'} ... %% Component which should execute the command, 0 for all components
		{'command'}			 ... %% Command ID, as defined by MAV_CMD enum.
		{'confirmation'}	 ... %% 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
		{'param1'}			 ... %% Parameter 1, as defined by MAV_CMD enum.
		{'param2'}			 ... %% Parameter 2, as defined by MAV_CMD enum.
		{'param3'}			 ... %% Parameter 3, as defined by MAV_CMD enum.
		{'param4'}			 ... %% Parameter 4, as defined by MAV_CMD enum.
		{'param5'}			 ... %% Parameter 5, as defined by MAV_CMD enum.
		{'param6'}			 ... %% Parameter 6, as defined by MAV_CMD enum.
		{'param7'}			 ... %% Parameter 7, as defined by MAV_CMD enum.
		];
	byte = [ 1 1 2 1 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 77
%%~ Report status of a command. Includes feedback wether the command was executed.
function S = parse_COMMAND_ACK(S,p)
	name = [ ...
		{'command'}	 ... %% Command ID, as defined by MAV_CMD enum.
		{'result'}	 ... %% See MAV_RESULT enum
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 80
%%~ Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
function S = parse_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp in milliseconds since system boot
		{'roll_rate'}	 ... %% Desired roll rate in radians per second
		{'pitch_rate'}	 ... %% Desired pitch rate in radians per second
		{'yaw_rate'}	 ... %% Desired yaw rate in radians per second
		{'thrust'}		 ... %% Collective thrust, normalized to 0 .. 1
		];
	byte = [ 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 81
%%~ Setpoint in roll, pitch, yaw and thrust from the operator
function S = parse_MANUAL_SETPOINT(S,p)
	name = [ ...
		{'time_boot_ms'}			 ... %% Timestamp in milliseconds since system boot
		{'roll'}					 ... %% Desired roll rate in radians per second
		{'pitch'}					 ... %% Desired pitch rate in radians per second
		{'yaw'}						 ... %% Desired yaw rate in radians per second
		{'thrust'}					 ... %% Collective thrust, normalized to 0 .. 1
		{'mode_switch'}				 ... %% Flight mode switch position, 0.. 255
		{'manual_override_switch'}	 ... %% Override mode switch position, 0.. 255
		];
	byte = [ 4 4 4 4 4 1 1 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 89
%%~ The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
%%~ the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
%%~ Z-axis down (aeronautical frame, NED / north-east-down convention)
function S = parse_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'x'}			 ... %% X Position
		{'y'}			 ... %% Y Position
		{'z'}			 ... %% Z Position
		{'roll'}		 ... %% Roll
		{'pitch'}		 ... %% Pitch
		{'yaw'}			 ... %% Yaw
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'uint32'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 90
%%~ DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
%%~ Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
%%~ autopilot. This packet is useful for high throughput applications such as hardware 
%%~ in the loop simulations.
function S = parse_HIL_STATE(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll'}		 ... %% Roll angle (rad)
		{'pitch'}		 ... %% Pitch angle (rad)
		{'yaw'}			 ... %% Yaw angle (rad)
		{'rollspeed'}	 ... %% Body frame roll / phi angular speed (rad/s)
		{'pitchspeed'}	 ... %% Body frame pitch / theta angular speed (rad/s)
		{'yawspeed'}	 ... %% Body frame yaw / psi angular speed (rad/s)
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


%%  case: 91
%%~ Sent from autopilot to simulation. Hardware in the loop control outputs
function S = parse_HIL_CONTROLS(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'roll_ailerons'}	 ... %% Control output -1 .. 1
		{'pitch_elevator'}	 ... %% Control output -1 .. 1
		{'yaw_rudder'}		 ... %% Control output -1 .. 1
		{'throttle'}		 ... %% Throttle 0 .. 1
		{'aux1'}			 ... %% Aux 1, -1 .. 1
		{'aux2'}			 ... %% Aux 2, -1 .. 1
		{'aux3'}			 ... %% Aux 3, -1 .. 1
		{'aux4'}			 ... %% Aux 4, -1 .. 1
		{'mode'}			 ... %% System mode (MAV_MODE)
		{'nav_mode'}		 ... %% Navigation mode (MAV_NAV_MODE)
		];
	byte = [ 8 4 4 4 4 4 4 4 4 1 1 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 92
%%~ Sent from simulation to autopilot. The RAW values of the RC channels received. The 
%%~ standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
%%~ 100%. Individual receivers/transmitters might violate this specification.
function S = parse_HIL_RC_INPUTS_RAW(S,p)
	name = [ ...
		{'time_usec'}	 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'chan1_raw'}	 ... %% RC channel 1 value, in microseconds
		{'chan2_raw'}	 ... %% RC channel 2 value, in microseconds
		{'chan3_raw'}	 ... %% RC channel 3 value, in microseconds
		{'chan4_raw'}	 ... %% RC channel 4 value, in microseconds
		{'chan5_raw'}	 ... %% RC channel 5 value, in microseconds
		{'chan6_raw'}	 ... %% RC channel 6 value, in microseconds
		{'chan7_raw'}	 ... %% RC channel 7 value, in microseconds
		{'chan8_raw'}	 ... %% RC channel 8 value, in microseconds
		{'chan9_raw'}	 ... %% RC channel 9 value, in microseconds
		{'chan10_raw'}	 ... %% RC channel 10 value, in microseconds
		{'chan11_raw'}	 ... %% RC channel 11 value, in microseconds
		{'chan12_raw'}	 ... %% RC channel 12 value, in microseconds
		{'rssi'}		 ... %% Receive signal strength indicator, 0: 0%, 255: 100%
		];
	byte = [ 8 2 2 2 2 2 2 2 2 2 2 2 2 1 ];
	type = [ {'uint64'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} ];
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
		{'time_usec'}		 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels * 10 in x-sensor direction (dezi-pixels)
		{'flow_y'}			 ... %% Flow in pixels * 10 in y-sensor direction (dezi-pixels)
		{'flow_comp_m_x'}	 ... %% Flow in meters in x-sensor direction, angular-speed compensated
		{'flow_comp_m_y'}	 ... %% Flow in meters in y-sensor direction, angular-speed compensated
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 2 2 4 4 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'single'} {'single'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 101
function S = parse_GLOBAL_VISION_POSITION_ESTIMATE(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}		 ... %% Global X position
		{'y'}		 ... %% Global Y position
		{'z'}		 ... %% Global Z position
		{'roll'}	 ... %% Roll angle in rad
		{'pitch'}	 ... %% Pitch angle in rad
		{'yaw'}		 ... %% Yaw angle in rad
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 102
function S = parse_VISION_POSITION_ESTIMATE(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}		 ... %% Global X position
		{'y'}		 ... %% Global Y position
		{'z'}		 ... %% Global Z position
		{'roll'}	 ... %% Roll angle in rad
		{'pitch'}	 ... %% Pitch angle in rad
		{'yaw'}		 ... %% Yaw angle in rad
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 103
function S = parse_VISION_SPEED_ESTIMATE(S,p)
	name = [ ...
		{'usec'} ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}	 ... %% Global X speed
		{'y'}	 ... %% Global Y speed
		{'z'}	 ... %% Global Z speed
		];
	byte = [ 8 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 104
function S = parse_VICON_POSITION_ESTIMATE(S,p)
	name = [ ...
		{'usec'}	 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'x'}		 ... %% Global X position
		{'y'}		 ... %% Global Y position
		{'z'}		 ... %% Global Z position
		{'roll'}	 ... %% Roll angle in rad
		{'pitch'}	 ... %% Pitch angle in rad
		{'yaw'}		 ... %% Yaw angle in rad
		];
	byte = [ 8 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 105
%%~ The IMU readings in SI units in NED body frame
function S = parse_HIGHRES_IMU(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'xacc'}			 ... %% X acceleration (m/s^2)
		{'yacc'}			 ... %% Y acceleration (m/s^2)
		{'zacc'}			 ... %% Z acceleration (m/s^2)
		{'xgyro'}			 ... %% Angular speed around X axis (rad / sec)
		{'ygyro'}			 ... %% Angular speed around Y axis (rad / sec)
		{'zgyro'}			 ... %% Angular speed around Z axis (rad / sec)
		{'xmag'}			 ... %% X Magnetic field (Gauss)
		{'ymag'}			 ... %% Y Magnetic field (Gauss)
		{'zmag'}			 ... %% Z Magnetic field (Gauss)
		{'abs_pressure'}	 ... %% Absolute pressure in millibar
		{'diff_pressure'}	 ... %% Differential pressure in millibar
		{'pressure_alt'}	 ... %% Altitude calculated from pressure
		{'temperature'}		 ... %% Temperature in degrees celsius
		{'fields_updated'}	 ... %% Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 4 4 4 4 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 106
%%~ Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
function S = parse_OMNIDIRECTIONAL_FLOW(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'sensor_id'}		 ... %% Sensor ID
		{'left'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
		{'right'}			 ... %% Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'front_distance_m'} ... %% Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 20 20 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 107
%%~ The IMU readings in SI units in NED body frame
function S = parse_HIL_SENSOR(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (microseconds, synced to UNIX time or since system boot)
		{'xacc'}			 ... %% X acceleration (m/s^2)
		{'yacc'}			 ... %% Y acceleration (m/s^2)
		{'zacc'}			 ... %% Z acceleration (m/s^2)
		{'xgyro'}			 ... %% Angular speed around X axis in body frame (rad / sec)
		{'ygyro'}			 ... %% Angular speed around Y axis in body frame (rad / sec)
		{'zgyro'}			 ... %% Angular speed around Z axis in body frame (rad / sec)
		{'xmag'}			 ... %% X Magnetic field (Gauss)
		{'ymag'}			 ... %% Y Magnetic field (Gauss)
		{'zmag'}			 ... %% Z Magnetic field (Gauss)
		{'abs_pressure'}	 ... %% Absolute pressure in millibar
		{'diff_pressure'}	 ... %% Differential pressure (airspeed) in millibar
		{'pressure_alt'}	 ... %% Altitude calculated from pressure
		{'temperature'}		 ... %% Temperature in degrees celsius
		{'fields_updated'}	 ... %% Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
		];
	byte = [ 8 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 108
%%~ Status of simulation environment, if used
function S = parse_SIM_STATE(S,p)
	name = [ ...
		{'q1'}			 ... %% True attitude quaternion component 1
		{'q2'}			 ... %% True attitude quaternion component 2
		{'q3'}			 ... %% True attitude quaternion component 3
		{'q4'}			 ... %% True attitude quaternion component 4
		{'roll'}		 ... %% Attitude roll expressed as Euler angles, not recommended except for human-readable outputs
		{'pitch'}		 ... %% Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs
		{'yaw'}			 ... %% Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs
		{'xacc'}		 ... %% X acceleration m/s/s
		{'yacc'}		 ... %% Y acceleration m/s/s
		{'zacc'}		 ... %% Z acceleration m/s/s
		{'xgyro'}		 ... %% Angular speed around X axis rad/s
		{'ygyro'}		 ... %% Angular speed around Y axis rad/s
		{'zgyro'}		 ... %% Angular speed around Z axis rad/s
		{'lat'}			 ... %% Latitude in degrees
		{'lon'}			 ... %% Longitude in degrees
		{'alt'}			 ... %% Altitude in meters
		{'std_dev_horz'} ... %% Horizontal position standard deviation
		{'std_dev_vert'} ... %% Vertical position standard deviation
		{'vn'}			 ... %% True velocity in m/s in NORTH direction in earth-fixed NED frame
		{'ve'}			 ... %% True velocity in m/s in EAST direction in earth-fixed NED frame
		{'vd'}			 ... %% True velocity in m/s in DOWN direction in earth-fixed NED frame
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 109
%%~ Status generated by radio
function S = parse_RADIO_STATUS(S,p)
	name = [ ...
		{'rssi'}	 ... %% local signal strength
		{'remrssi'}	 ... %% remote signal strength
		{'txbuf'}	 ... %% how full the tx buffer is as a percentage
		{'noise'}	 ... %% background noise level
		{'remnoise'} ... %% remote background noise level
		{'rxerrors'} ... %% receive errors
		{'fixed'}	 ... %% count of error corrected packets
		];
	byte = [ 1 1 1 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 110
%%~ Begin file transfer
function S = parse_FILE_TRANSFER_START(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dest_path'}	 ... %% Destination path
		{'direction'}	 ... %% Transfer direction: 0: from requester, 1: to requester
		{'file_size'}	 ... %% File size in bytes
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 4 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 111
%%~ Get directory listing
function S = parse_FILE_TRANSFER_DIR_LIST(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'dir_path'}	 ... %% Directory path to list
		{'flags'}		 ... %% RESERVED
		];
	byte = [ 8 240 1 ];
	type = [ {'uint64'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 112
%%~ File transfer result
function S = parse_FILE_TRANSFER_RES(S,p)
	name = [ ...
		{'transfer_uid'} ... %% Unique transfer ID
		{'result'}		 ... %% 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
		];
	byte = [ 8 1 ];
	type = [ {'uint64'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 113
%%~ The global position, as returned by the Global Positioning System (GPS). This is 
%%~                  NOT the global position estimate of the sytem, but rather a RAW 
%%~ sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
%%~ frame is right-handed, Z-axis up (GPS frame).
function S = parse_HIL_GPS(S,p)
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'fix_type'}			 ... %% 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		{'lat'}					 ... %% Latitude (WGS84), in degrees * 1E7
		{'lon'}					 ... %% Longitude (WGS84), in degrees * 1E7
		{'alt'}					 ... %% Altitude (WGS84), in meters * 1000 (positive for up)
		{'eph'}					 ... %% GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: 65535
		{'epv'}					 ... %% GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: 65535
		{'vel'}					 ... %% GPS ground speed (m/s * 100). If unknown, set to: 65535
		{'vn'}					 ... %% GPS velocity in cm/s in NORTH direction in earth-fixed NED frame
		{'ve'}					 ... %% GPS velocity in cm/s in EAST direction in earth-fixed NED frame
		{'vd'}					 ... %% GPS velocity in cm/s in DOWN direction in earth-fixed NED frame
		{'cog'}					 ... %% Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: 65535
		{'satellites_visible'}	 ... %% Number of satellites visible. If unknown, set to 255
		];
	byte = [ 8 1 4 4 4 2 2 2 2 2 2 2 1 ];
	type = [ {'uint64'} {'uint8'} {'int32'} {'int32'} {'int32'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int16'} {'int16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 114
%%~ Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
function S = parse_HIL_OPTICAL_FLOW(S,p)
	name = [ ...
		{'time_usec'}		 ... %% Timestamp (UNIX)
		{'sensor_id'}		 ... %% Sensor ID
		{'flow_x'}			 ... %% Flow in pixels in x-sensor direction
		{'flow_y'}			 ... %% Flow in pixels in y-sensor direction
		{'flow_comp_m_x'}	 ... %% Flow in meters in x-sensor direction, angular-speed compensated
		{'flow_comp_m_y'}	 ... %% Flow in meters in y-sensor direction, angular-speed compensated
		{'quality'}			 ... %% Optical flow quality / confidence. 0: bad, 255: maximum quality
		{'ground_distance'}	 ... %% Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
		];
	byte = [ 8 1 2 2 4 4 1 4 ];
	type = [ {'uint64'} {'uint8'} {'int16'} {'int16'} {'single'} {'single'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 115
%%~ Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
%%~ This packet is useful for high throughput applications such as hardware in the 
%%~ loop simulations.
function S = parse_HIL_STATE_QUATERNION(S,p)
	name = [ ...
		{'time_usec'}			 ... %% Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		{'attitude_quaternion'}	 ... %% Vehicle attitude expressed as normalized quaternion
		{'rollspeed'}			 ... %% Body frame roll / phi angular speed (rad/s)
		{'pitchspeed'}			 ... %% Body frame pitch / theta angular speed (rad/s)
		{'yawspeed'}			 ... %% Body frame yaw / psi angular speed (rad/s)
		{'lat'}					 ... %% Latitude, expressed as * 1E7
		{'lon'}					 ... %% Longitude, expressed as * 1E7
		{'alt'}					 ... %% Altitude in meters, expressed as * 1000 (millimeters)
		{'vx'}					 ... %% Ground X Speed (Latitude), expressed as m/s * 100
		{'vy'}					 ... %% Ground Y Speed (Longitude), expressed as m/s * 100
		{'vz'}					 ... %% Ground Z Speed (Altitude), expressed as m/s * 100
		{'ind_airspeed'}		 ... %% Indicated airspeed, expressed as m/s * 100
		{'true_airspeed'}		 ... %% True airspeed, expressed as m/s * 100
		{'xacc'}				 ... %% X acceleration (mg)
		{'yacc'}				 ... %% Y acceleration (mg)
		{'zacc'}				 ... %% Z acceleration (mg)
		];
	byte = [ 8 16 4 4 4 4 4 4 2 2 2 2 2 2 2 2 ];
	type = [ {'uint64'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} {'int32'} {'int16'} {'int16'} {'int16'} {'uint16'} {'uint16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 116
%%~ The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
%%~ the scaled values to the described units
function S = parse_SCALED_IMU2(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'xacc'}		 ... %% X acceleration (mg)
		{'yacc'}		 ... %% Y acceleration (mg)
		{'zacc'}		 ... %% Z acceleration (mg)
		{'xgyro'}		 ... %% Angular speed around X axis (millirad /sec)
		{'ygyro'}		 ... %% Angular speed around Y axis (millirad /sec)
		{'zgyro'}		 ... %% Angular speed around Z axis (millirad /sec)
		{'xmag'}		 ... %% X Magnetic field (milli tesla)
		{'ymag'}		 ... %% Y Magnetic field (milli tesla)
		{'zmag'}		 ... %% Z Magnetic field (milli tesla)
		];
	byte = [ 4 2 2 2 2 2 2 2 2 2 ];
	type = [ {'uint32'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} {'int16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 117
%%~ Request a list of available logs. On some systems calling this may stop on-board 
%%~ logging until LOG_REQUEST_END is called.
function S = parse_LOG_REQUEST_LIST(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'start'}			 ... %% First log id (0 for first available)
		{'end'}				 ... %% Last log id (0xffff for last available)
		];
	byte = [ 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 118
%%~ Reply to LOG_REQUEST_LIST
function S = parse_LOG_ENTRY(S,p)
	name = [ ...
		{'id'}			 ... %% Log id
		{'num_logs'}	 ... %% Total number of logs
		{'last_log_num'} ... %% High log number
		{'time_utc'}	 ... %% UTC timestamp of log in seconds since 1970, or 0 if not available
		{'size'}		 ... %% Size of the log (may be approximate) in bytes
		];
	byte = [ 2 2 2 4 4 ];
	type = [ {'uint16'} {'uint16'} {'uint16'} {'uint32'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 119
%%~ Request a chunk of a log
function S = parse_LOG_REQUEST_DATA(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'id'}				 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}				 ... %% Offset into the log
		{'count'}			 ... %% Number of bytes
		];
	byte = [ 1 1 2 4 4 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} {'uint32'} {'uint32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 120
%%~ Reply to LOG_REQUEST_DATA
function S = parse_LOG_DATA(S,p)
	name = [ ...
		{'id'}		 ... %% Log id (from LOG_ENTRY reply)
		{'ofs'}		 ... %% Offset into the log
		{'count'}	 ... %% Number of bytes (zero for end of log)
		{'data'}	 ... %% log data
		];
	byte = [ 2 4 1 90 ];
	type = [ {'uint16'} {'uint32'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 121
%%~ Erase all logs
function S = parse_LOG_ERASE(S,p)
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


%%  case: 122
%%~ Stop log transfer and resume normal logging
function S = parse_LOG_REQUEST_END(S,p)
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


%%  case: 147
%%~ Transmitte battery informations for a accu pack.
function S = parse_BATTERY_STATUS(S,p)
	name = [ ...
		{'accu_id'}				 ... %% Accupack ID
		{'voltage_cell_1'}		 ... %% Battery voltage of cell 1, in millivolts (1 = 1 millivolt)
		{'voltage_cell_2'}		 ... %% Battery voltage of cell 2, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_3'}		 ... %% Battery voltage of cell 3, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_4'}		 ... %% Battery voltage of cell 4, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_5'}		 ... %% Battery voltage of cell 5, in millivolts (1 = 1 millivolt), -1: no cell
		{'voltage_cell_6'}		 ... %% Battery voltage of cell 6, in millivolts (1 = 1 millivolt), -1: no cell
		{'current_battery'}		 ... %% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		{'current_consumed'}	 ... %% Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
		{'energy_consumed'}		 ... %% Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
		{'battery_remaining'}	 ... %% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
		];
	byte = [ 1 2 2 2 2 2 2 2 4 4 1 ];
	type = [ {'uint8'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'uint16'} {'int16'} {'int32'} {'int32'} {'int8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 148
%%~ Set the 8 DOF setpoint for a controller.
function S = parse_SETPOINT_8DOF(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'val1'}			 ... %% Value 1
		{'val2'}			 ... %% Value 2
		{'val3'}			 ... %% Value 3
		{'val4'}			 ... %% Value 4
		{'val5'}			 ... %% Value 5
		{'val6'}			 ... %% Value 6
		{'val7'}			 ... %% Value 7
		{'val8'}			 ... %% Value 8
		];
	byte = [ 1 4 4 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 149
%%~ Set the 6 DOF setpoint for a attitude and position controller.
function S = parse_SETPOINT_6DOF(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'trans_x'}			 ... %% Translational Component in x
		{'trans_y'}			 ... %% Translational Component in y
		{'trans_z'}			 ... %% Translational Component in z
		{'rot_x'}			 ... %% Rotational Component in x
		{'rot_y'}			 ... %% Rotational Component in y
		{'rot_z'}			 ... %% Rotational Component in z
		];
	byte = [ 1 4 4 4 4 4 4 ];
	type = [ {'uint8'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 249
%%~ Send raw controller memory. The use of this message is discouraged for normal packets, 
%%~ but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_MEMORY_VECT(S,p)
	name = [ ...
		{'address'}	 ... %% Starting address of the debug variables
		{'ver'}		 ... %% Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
		{'type'}	 ... %% Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
		{'value'}	 ... %% Memory contents at specified address
		];
	byte = [ 2 1 1 32 ];
	type = [ {'uint16'} {'uint8'} {'uint8'} {'int8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 250
function S = parse_DEBUG_VECT(S,p)
	name = [ ...
		{'name'}		 ... %% Name
		{'time_usec'}	 ... %% Timestamp
		{'x'}			 ... %% x
		{'y'}			 ... %% y
		{'z'}			 ... %% z
		];
	byte = [ 10 8 4 4 4 ];
	type = [ {'uint8'} {'uint64'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 251
%%~ Send a key-value pair as float. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_FLOAT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'name'}		 ... %% Name of the debug variable
		{'value'}		 ... %% Floating point value
		];
	byte = [ 4 10 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 252
%%~ Send a key-value pair as integer. The use of this message is discouraged for normal 
%%~ packets, but a quite efficient way for testing new messages and getting experimental 
%%~ debug output.
function S = parse_NAMED_VALUE_INT(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'name'}		 ... %% Name of the debug variable
		{'value'}		 ... %% Signed integer value
		];
	byte = [ 4 10 4 ];
	type = [ {'uint32'} {'uint8'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 253
%%~ Status text message. These messages are printed in yellow in the COMM console of 
%%~ QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
%%~ status and error messages. If implemented wisely, these messages are buffered 
%%~ on the MCU and sent only at a limited rate (e.g. 10 Hz).
function S = parse_STATUSTEXT(S,p)
	name = [ ...
		{'severity'} ... %% Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
		{'text'}	 ... %% Status text message, without null termination character
		];
	byte = [ 1 50 ];
	type = [ {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 254
%%~ Send a debug value. The index is used to discriminate between values. These values 
%%~ show up in the plot of QGroundControl as DEBUG N.
function S = parse_DEBUG(S,p)
	name = [ ...
		{'time_boot_ms'} ... %% Timestamp (milliseconds since system boot)
		{'ind'}			 ... %% index of debug variable
		{'value'}		 ... %% DEBUG value
		];
	byte = [ 4 1 4 ];
	type = [ {'uint32'} {'uint8'} {'single'} ];
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


%%  case: 163
%%~ Status of DCM attitude estimator
function S = parse_AHRS(S,p)
	name = [ ...
		{'omegaIx'}		 ... %% X gyro drift estimate rad/s
		{'omegaIy'}		 ... %% Y gyro drift estimate rad/s
		{'omegaIz'}		 ... %% Z gyro drift estimate rad/s
		{'accel_weight'} ... %% average accel_weight
		{'renorm_val'}	 ... %% average renormalisation value
		{'error_rp'}	 ... %% average error_roll_pitch value
		{'error_yaw'}	 ... %% average error_yaw value
		];
	byte = [ 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 164
%%~ Status of simulation environment, if used
function S = parse_SIMSTATE(S,p)
	name = [ ...
		{'roll'}	 ... %% Roll angle (rad)
		{'pitch'}	 ... %% Pitch angle (rad)
		{'yaw'}		 ... %% Yaw angle (rad)
		{'xacc'}	 ... %% X acceleration m/s/s
		{'yacc'}	 ... %% Y acceleration m/s/s
		{'zacc'}	 ... %% Z acceleration m/s/s
		{'xgyro'}	 ... %% Angular speed around X axis rad/s
		{'ygyro'}	 ... %% Angular speed around Y axis rad/s
		{'zgyro'}	 ... %% Angular speed around Z axis rad/s
		{'lat'}		 ... %% Latitude in degrees * 1E7
		{'lng'}		 ... %% Longitude in degrees * 1E7
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'int32'} {'int32'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 165
%%~ Status of key hardware
function S = parse_HWSTATUS(S,p)
	name = [ ...
		{'Vcc'}		 ... %% board voltage (mV)
		{'I2Cerr'}	 ... %% I2C error count
		];
	byte = [ 2 1 ];
	type = [ {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 166
%%~ Status generated by radio
function S = parse_RADIO(S,p)
	name = [ ...
		{'rssi'}	 ... %% local signal strength
		{'remrssi'}	 ... %% remote signal strength
		{'txbuf'}	 ... %% how full the tx buffer is as a percentage
		{'noise'}	 ... %% background noise level
		{'remnoise'} ... %% remote background noise level
		{'rxerrors'} ... %% receive errors
		{'fixed'}	 ... %% count of error corrected packets
		];
	byte = [ 1 1 1 1 1 2 2 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint16'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 167
%%~ Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
function S = parse_LIMITS_STATUS(S,p)
	name = [ ...
		{'limits_state'}	 ... %% state of AP_Limits, (see enum LimitState, LIMITS_STATE)
		{'last_trigger'}	 ... %% time of last breach in milliseconds since boot
		{'last_action'}		 ... %% time of last recovery action in milliseconds since boot
		{'last_recovery'}	 ... %% time of last successful recovery in milliseconds since boot
		{'last_clear'}		 ... %% time of last all-clear in milliseconds since boot
		{'breach_count'}	 ... %% number of fence breaches
		{'mods_enabled'}	 ... %% AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)
		{'mods_required'}	 ... %% AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)
		{'mods_triggered'}	 ... %% AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)
		];
	byte = [ 1 4 4 4 4 2 1 1 1 ];
	type = [ {'uint8'} {'uint32'} {'uint32'} {'uint32'} {'uint32'} {'uint16'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 168
%%~ Wind estimation
function S = parse_WIND(S,p)
	name = [ ...
		{'direction'}	 ... %% wind direction that wind is coming from (degrees)
		{'speed'}		 ... %% wind speed in ground plane (m/s)
		{'speed_z'}		 ... %% vertical wind speed (m/s)
		];
	byte = [ 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 169
%%~ Data packet, size 16
function S = parse_DATA16(S,p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 16 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 170
%%~ Data packet, size 32
function S = parse_DATA32(S,p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 32 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 171
%%~ Data packet, size 64
function S = parse_DATA64(S,p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 64 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 172
%%~ Data packet, size 96
function S = parse_DATA96(S,p)
	name = [ ...
		{'type'} ... %% data type
		{'len'}	 ... %% data length
		{'data'} ... %% raw data
		];
	byte = [ 1 1 96 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 173
%%~ Rangefinder reporting
function S = parse_RANGEFINDER(S,p)
	name = [ ...
		{'distance'} ... %% distance in meters
		{'voltage'}	 ... %% raw voltage if available, zero otherwise
		];
	byte = [ 4 4 ];
	type = [ {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 174
%%~ Airspeed auto-calibration
function S = parse_AIRSPEED_AUTOCAL(S,p)
	name = [ ...
		{'vx'}				 ... %% GPS velocity north m/s
		{'vy'}				 ... %% GPS velocity east m/s
		{'vz'}				 ... %% GPS velocity down m/s
		{'diff_pressure'}	 ... %% Differential pressure pascals
		{'EAS2TAS'}			 ... %% Estimated to true airspeed ratio
		{'ratio'}			 ... %% Airspeed ratio
		{'state_x'}			 ... %% EKF state x
		{'state_y'}			 ... %% EKF state y
		{'state_z'}			 ... %% EKF state z
		{'Pax'}				 ... %% EKF Pax
		{'Pby'}				 ... %% EKF Pby
		{'Pcz'}				 ... %% EKF Pcz
		];
	byte = [ 4 4 4 4 4 4 4 4 4 4 4 4 ];
	type = [ {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} {'single'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 175
%%~ A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
%%~ from MAV -> GCS
function S = parse_RALLY_POINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 0)
		{'count'}			 ... %% total number of points (for sanity checking)
		{'lat'}				 ... %% Latitude of point in degrees * 1E7
		{'lng'}				 ... %% Longitude of point in degrees * 1E7
		{'alt'}				 ... %% Transit / loiter altitude in meters relative to home
		{'break_alt'}		 ... %% Break altitude in meters relative to home
		{'land_dir'}		 ... %% Heading to aim for when landing. In centi-degrees.
		{'flags'}			 ... %% See RALLY_FLAGS enum for definition of the bitmask.
		];
	byte = [ 1 1 1 1 4 4 2 2 2 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int32'} {'int32'} {'int16'} {'int16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return


%%  case: 176
%%~ Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
%%~ MAV should not respond if the request is invalid.
function S = parse_RALLY_FETCH_POINT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 0)
		];
	byte = [ 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

