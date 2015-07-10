function S = parseMavLink_v1_0_Packet(S,p)
	switch(p.messid)
		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			S.HEARTBEAT = parse_HEARTBEAT_v1_0(S.HEARTBEAT,p);

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
			S.SYS_STATUS = parse_SYS_STATUS_v1_0(S.SYS_STATUS,p);

		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			S.SYSTEM_TIME = parse_SYSTEM_TIME_v1_0(S.SYSTEM_TIME,p);

		case 4
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			S.PING = parse_PING_v1_0(S.PING,p);

		case 5
			%% Request to control this MAV
			S.CHANGE_OPERATOR_CONTROL = parse_CHANGE_OPERATOR_CONTROL_v1_0(S.CHANGE_OPERATOR_CONTROL,p);

		case 6
			%% Accept / deny control of this MAV
			S.CHANGE_OPERATOR_CONTROL_ACK = parse_CHANGE_OPERATOR_CONTROL_ACK_v1_0(S.CHANGE_OPERATOR_CONTROL_ACK,p);

		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			S.AUTH_KEY = parse_AUTH_KEY_v1_0(S.AUTH_KEY,p);

		case 11
			%% Set the system mode, as defined by enum MAV_MODE. There is no target component id 
			%% as the mode is by definition for the overall aircraft, not only for one component.
			S.SET_MODE = parse_SET_MODE_v1_0(S.SET_MODE,p);

		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			S.PARAM_REQUEST_READ = parse_PARAM_REQUEST_READ_v1_0(S.PARAM_REQUEST_READ,p);

		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			S.PARAM_REQUEST_LIST = parse_PARAM_REQUEST_LIST_v1_0(S.PARAM_REQUEST_LIST,p);

		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			S.PARAM_VALUE = parse_PARAM_VALUE_v1_0(S.PARAM_VALUE,p);

		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			S.PARAM_SET = parse_PARAM_SET_v1_0(S.PARAM_SET,p);

		case 24
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                 NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			S.GPS_RAW_INT = parse_GPS_RAW_INT_v1_0(S.GPS_RAW_INT,p);

		case 25
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			S.GPS_STATUS = parse_GPS_STATUS_v1_0(S.GPS_STATUS,p);

		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU = parse_SCALED_IMU_v1_0(S.SCALED_IMU,p);

		case 27
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			S.RAW_IMU = parse_RAW_IMU_v1_0(S.RAW_IMU,p);

		case 28
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			S.RAW_PRESSURE = parse_RAW_PRESSURE_v1_0(S.RAW_PRESSURE,p);

		case 29
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			S.SCALED_PRESSURE = parse_SCALED_PRESSURE_v1_0(S.SCALED_PRESSURE,p);

		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			S.ATTITUDE = parse_ATTITUDE_v1_0(S.ATTITUDE,p);

		case 31
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
			%% expressed as quaternion.
			S.ATTITUDE_QUATERNION = parse_ATTITUDE_QUATERNION_v1_0(S.ATTITUDE_QUATERNION,p);

		case 32
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
			%% convention)
			S.LOCAL_POSITION_NED = parse_LOCAL_POSITION_NED_v1_0(S.LOCAL_POSITION_NED,p);

		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
			%% message since the resolution of float is not sufficient.
			S.GLOBAL_POSITION_INT = parse_GLOBAL_POSITION_INT_v1_0(S.GLOBAL_POSITION_INT,p);

		case 34
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000. Channels that are inactive should be set to UINT16_MAX.
			S.RC_CHANNELS_SCALED = parse_RC_CHANNELS_SCALED_v1_0(S.RC_CHANNELS_SCALED,p);

		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			S.RC_CHANNELS_RAW = parse_RC_CHANNELS_RAW_v1_0(S.RC_CHANNELS_RAW,p);

		case 36
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			S.SERVO_OUTPUT_RAW = parse_SERVO_OUTPUT_RAW_v1_0(S.SERVO_OUTPUT_RAW,p);

		case 37
			%% Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
			%% If start and end index are the same, just 
			%% send one waypoint.
			S.MISSION_REQUEST_PARTIAL_LIST = parse_MISSION_REQUEST_PARTIAL_LIST_v1_0(S.MISSION_REQUEST_PARTIAL_LIST,p);

		case 38
			%% This message is sent to the MAV to write a partial list. If start index == end index, 
			%% only one item will be transmitted / updated. If the start index is NOT 0 and 
			%% above the current list size, this request should be REJECTED!
			S.MISSION_WRITE_PARTIAL_LIST = parse_MISSION_WRITE_PARTIAL_LIST_v1_0(S.MISSION_WRITE_PARTIAL_LIST,p);

		case 39
			%% Message encoding a mission item. This message is emitted to announce            
			%%      the presence of a mission item and to set a mission item on the system. The 
			%% mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
			%% Local frame is Z-down, right handed (NED), global frame is Z-up, right 
			%% handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
			S.MISSION_ITEM = parse_MISSION_ITEM_v1_0(S.MISSION_ITEM,p);

		case 40
			%% Request the information of the mission item with the sequence number seq. The response 
			%% of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
			S.MISSION_REQUEST = parse_MISSION_REQUEST_v1_0(S.MISSION_REQUEST,p);

		case 41
			%% Set the mission item with sequence number seq as current item. This means that the 
			%% MAV will continue to this mission item on the shortest path (not following the 
			%% mission items in-between).
			S.MISSION_SET_CURRENT = parse_MISSION_SET_CURRENT_v1_0(S.MISSION_SET_CURRENT,p);

		case 42
			%% Message that announces the sequence number of the current active mission item. The 
			%% MAV will fly towards this mission item.
			S.MISSION_CURRENT = parse_MISSION_CURRENT_v1_0(S.MISSION_CURRENT,p);

		case 43
			%% Request the overall list of mission items from the system/component.
			S.MISSION_REQUEST_LIST = parse_MISSION_REQUEST_LIST_v1_0(S.MISSION_REQUEST_LIST,p);

		case 44
			%% This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
			%% a write transaction. The GCS can then request the individual mission item 
			%% based on the knowledge of the total number of MISSIONs.
			S.MISSION_COUNT = parse_MISSION_COUNT_v1_0(S.MISSION_COUNT,p);

		case 45
			%% Delete all mission items at once.
			S.MISSION_CLEAR_ALL = parse_MISSION_CLEAR_ALL_v1_0(S.MISSION_CLEAR_ALL,p);

		case 46
			%% A certain mission item has been reached. The system will either hold this position 
			%% (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
			%% to the next MISSION.
			S.MISSION_ITEM_REACHED = parse_MISSION_ITEM_REACHED_v1_0(S.MISSION_ITEM_REACHED,p);

		case 47
			%% Ack message during MISSION handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			S.MISSION_ACK = parse_MISSION_ACK_v1_0(S.MISSION_ACK,p);

		case 48
			%% As local waypoints exist, the global MISSION reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should move 
			%% from in- to outdoor.
			S.SET_GPS_GLOBAL_ORIGIN = parse_SET_GPS_GLOBAL_ORIGIN_v1_0(S.SET_GPS_GLOBAL_ORIGIN,p);

		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			S.GPS_GLOBAL_ORIGIN = parse_GPS_GLOBAL_ORIGIN_v1_0(S.GPS_GLOBAL_ORIGIN,p);

		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			S.SET_LOCAL_POSITION_SETPOINT = parse_SET_LOCAL_POSITION_SETPOINT_v1_0(S.SET_LOCAL_POSITION_SETPOINT,p);

		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.LOCAL_POSITION_SETPOINT = parse_LOCAL_POSITION_SETPOINT_v1_0(S.LOCAL_POSITION_SETPOINT,p);

		case 52
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			S.GLOBAL_POSITION_SETPOINT_INT = parse_GLOBAL_POSITION_SETPOINT_INT_v1_0(S.GLOBAL_POSITION_SETPOINT_INT,p);

		case 53
			%% Set the current global position setpoint.
			S.SET_GLOBAL_POSITION_SETPOINT_INT = parse_SET_GLOBAL_POSITION_SETPOINT_INT_v1_0(S.SET_GLOBAL_POSITION_SETPOINT_INT,p);

		case 54
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/MISSIONs to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			S.SAFETY_SET_ALLOWED_AREA = parse_SAFETY_SET_ALLOWED_AREA_v1_0(S.SAFETY_SET_ALLOWED_AREA,p);

		case 55
			%% Read out the safety zone the MAV currently assumes.
			S.SAFETY_ALLOWED_AREA = parse_SAFETY_ALLOWED_AREA_v1_0(S.SAFETY_ALLOWED_AREA,p);

		case 56
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_THRUST = parse_SET_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_ROLL_PITCH_YAW_THRUST,p);

		case 57
			%% Set roll, pitch and yaw.
			S.SET_ROLL_PITCH_YAW_SPEED_THRUST = parse_SET_ROLL_PITCH_YAW_SPEED_THRUST_v1_0(S.SET_ROLL_PITCH_YAW_SPEED_THRUST,p);

		case 58
			%% Setpoint in roll, pitch, yaw currently active on the system.
			S.ROLL_PITCH_YAW_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_THRUST_SETPOINT,p);

		case 59
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT,p);

		case 60
			%% Setpoint in the four motor speeds
			S.SET_QUAD_MOTORS_SETPOINT = parse_SET_QUAD_MOTORS_SETPOINT_v1_0(S.SET_QUAD_MOTORS_SETPOINT,p);

		case 61
			%% Setpoint for up to four quadrotors in a group / wing
			S.SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST = parse_SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST,p);

		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters.
			S.NAV_CONTROLLER_OUTPUT = parse_NAV_CONTROLLER_OUTPUT_v1_0(S.NAV_CONTROLLER_OUTPUT,p);

		case 63
			%% Setpoint for up to four quadrotors in a group / wing
			S.SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST = parse_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST,p);

		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			S.STATE_CORRECTION = parse_STATE_CORRECTION_v1_0(S.STATE_CORRECTION,p);

		case 66
			S.REQUEST_DATA_STREAM = parse_REQUEST_DATA_STREAM_v1_0(S.REQUEST_DATA_STREAM,p);

		case 67
			S.DATA_STREAM = parse_DATA_STREAM_v1_0(S.DATA_STREAM,p);

		case 69
			%% This message provides an API for manually controlling the vehicle using standard 
			%% joystick axes nomenclature, along with a joystick-like input device. Unused axes 
			%% can be disabled an buttons are also transmit as boolean values of their 
			S.MANUAL_CONTROL = parse_MANUAL_CONTROL_v1_0(S.MANUAL_CONTROL,p);

		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
			%% 0 means control of that channel should be released back to the RC radio. The standard 
			%% PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			S.RC_CHANNELS_OVERRIDE = parse_RC_CHANNELS_OVERRIDE_v1_0(S.RC_CHANNELS_OVERRIDE,p);

		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			S.VFR_HUD = parse_VFR_HUD_v1_0(S.VFR_HUD,p);

		case 76
			%% Send a command with up to seven parameters to the MAV
			S.COMMAND_LONG = parse_COMMAND_LONG_v1_0(S.COMMAND_LONG,p);

		case 77
			%% Report status of a command. Includes feedback wether the command was executed.
			S.COMMAND_ACK = parse_COMMAND_ACK_v1_0(S.COMMAND_ACK,p);

		case 80
			%% Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
			S.ROLL_PITCH_YAW_RATES_THRUST_SETPOINT = parse_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_RATES_THRUST_SETPOINT,p);

		case 81
			%% Setpoint in roll, pitch, yaw and thrust from the operator
			S.MANUAL_SETPOINT = parse_MANUAL_SETPOINT_v1_0(S.MANUAL_SETPOINT,p);

		case 89
			%% The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
			%% the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
			%% Z-axis down (aeronautical frame, NED / north-east-down convention)
			S.LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET = parse_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S.LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET,p);

		case 90
			%% DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
			%% Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
			%% autopilot. This packet is useful for high throughput applications such as hardware 
			%% in the loop simulations.
			S.HIL_STATE = parse_HIL_STATE_v1_0(S.HIL_STATE,p);

		case 91
			%% Sent from autopilot to simulation. Hardware in the loop control outputs
			S.HIL_CONTROLS = parse_HIL_CONTROLS_v1_0(S.HIL_CONTROLS,p);

		case 92
			%% Sent from simulation to autopilot. The RAW values of the RC channels received. The 
			%% standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			S.HIL_RC_INPUTS_RAW = parse_HIL_RC_INPUTS_RAW_v1_0(S.HIL_RC_INPUTS_RAW,p);

		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			S.OPTICAL_FLOW = parse_OPTICAL_FLOW_v1_0(S.OPTICAL_FLOW,p);

		case 101
			S.GLOBAL_VISION_POSITION_ESTIMATE = parse_GLOBAL_VISION_POSITION_ESTIMATE_v1_0(S.GLOBAL_VISION_POSITION_ESTIMATE,p);

		case 102
			S.VISION_POSITION_ESTIMATE = parse_VISION_POSITION_ESTIMATE_v1_0(S.VISION_POSITION_ESTIMATE,p);

		case 103
			S.VISION_SPEED_ESTIMATE = parse_VISION_SPEED_ESTIMATE_v1_0(S.VISION_SPEED_ESTIMATE,p);

		case 104
			S.VICON_POSITION_ESTIMATE = parse_VICON_POSITION_ESTIMATE_v1_0(S.VICON_POSITION_ESTIMATE,p);

		case 105
			%% The IMU readings in SI units in NED body frame
			S.HIGHRES_IMU = parse_HIGHRES_IMU_v1_0(S.HIGHRES_IMU,p);

		case 106
			%% Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
			S.OMNIDIRECTIONAL_FLOW = parse_OMNIDIRECTIONAL_FLOW_v1_0(S.OMNIDIRECTIONAL_FLOW,p);

		case 107
			%% The IMU readings in SI units in NED body frame
			S.HIL_SENSOR = parse_HIL_SENSOR_v1_0(S.HIL_SENSOR,p);

		case 108
			%% Status of simulation environment, if used
			S.SIM_STATE = parse_SIM_STATE_v1_0(S.SIM_STATE,p);

		case 109
			%% Status generated by radio
			S.RADIO_STATUS = parse_RADIO_STATUS_v1_0(S.RADIO_STATUS,p);

		case 110
			%% Begin file transfer
			S.FILE_TRANSFER_START = parse_FILE_TRANSFER_START_v1_0(S.FILE_TRANSFER_START,p);

		case 111
			%% Get directory listing
			S.FILE_TRANSFER_DIR_LIST = parse_FILE_TRANSFER_DIR_LIST_v1_0(S.FILE_TRANSFER_DIR_LIST,p);

		case 112
			%% File transfer result
			S.FILE_TRANSFER_RES = parse_FILE_TRANSFER_RES_v1_0(S.FILE_TRANSFER_RES,p);

		case 113
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                  NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			S.HIL_GPS = parse_HIL_GPS_v1_0(S.HIL_GPS,p);

		case 114
			%% Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
			S.HIL_OPTICAL_FLOW = parse_HIL_OPTICAL_FLOW_v1_0(S.HIL_OPTICAL_FLOW,p);

		case 115
			%% Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
			%% This packet is useful for high throughput applications such as hardware in the 
			%% loop simulations.
			S.HIL_STATE_QUATERNION = parse_HIL_STATE_QUATERNION_v1_0(S.HIL_STATE_QUATERNION,p);

		case 116
			%% The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			S.SCALED_IMU2 = parse_SCALED_IMU2_v1_0(S.SCALED_IMU2,p);

		case 117
			%% Request a list of available logs. On some systems calling this may stop on-board 
			%% logging until LOG_REQUEST_END is called.
			S.LOG_REQUEST_LIST = parse_LOG_REQUEST_LIST_v1_0(S.LOG_REQUEST_LIST,p);

		case 118
			%% Reply to LOG_REQUEST_LIST
			S.LOG_ENTRY = parse_LOG_ENTRY_v1_0(S.LOG_ENTRY,p);

		case 119
			%% Request a chunk of a log
			S.LOG_REQUEST_DATA = parse_LOG_REQUEST_DATA_v1_0(S.LOG_REQUEST_DATA,p);

		case 120
			%% Reply to LOG_REQUEST_DATA
			S.LOG_DATA = parse_LOG_DATA_v1_0(S.LOG_DATA,p);

		case 121
			%% Erase all logs
			S.LOG_ERASE = parse_LOG_ERASE_v1_0(S.LOG_ERASE,p);

		case 122
			%% Stop log transfer and resume normal logging
			S.LOG_REQUEST_END = parse_LOG_REQUEST_END_v1_0(S.LOG_REQUEST_END,p);

		case 147
			%% Transmitte battery informations for a accu pack.
			S.BATTERY_STATUS = parse_BATTERY_STATUS_v1_0(S.BATTERY_STATUS,p);

		case 148
			%% Set the 8 DOF setpoint for a controller.
			S.SETPOINT_8DOF = parse_SETPOINT_8DOF_v1_0(S.SETPOINT_8DOF,p);

		case 149
			%% Set the 6 DOF setpoint for a attitude and position controller.
			S.SETPOINT_6DOF = parse_SETPOINT_6DOF_v1_0(S.SETPOINT_6DOF,p);

		case 249
			%% Send raw controller memory. The use of this message is discouraged for normal packets, 
			%% but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.MEMORY_VECT = parse_MEMORY_VECT_v1_0(S.MEMORY_VECT,p);

		case 250
			S.DEBUG_VECT = parse_DEBUG_VECT_v1_0(S.DEBUG_VECT,p);

		case 251
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_FLOAT = parse_NAMED_VALUE_FLOAT_v1_0(S.NAMED_VALUE_FLOAT,p);

		case 252
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			S.NAMED_VALUE_INT = parse_NAMED_VALUE_INT_v1_0(S.NAMED_VALUE_INT,p);

		case 253
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			S.STATUSTEXT = parse_STATUSTEXT_v1_0(S.STATUSTEXT,p);

		case 254
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			S.DEBUG = parse_DEBUG_v1_0(S.DEBUG,p);

		case 150
			%% Offsets and calibrations values for hardware         sensors. This makes it easier 
			%% to debug the calibration process.
			S.SENSOR_OFFSETS = parse_SENSOR_OFFSETS_v1_0(S.SENSOR_OFFSETS,p);

		case 151
			%% set the magnetometer offsets
			S.SET_MAG_OFFSETS = parse_SET_MAG_OFFSETS_v1_0(S.SET_MAG_OFFSETS,p);

		case 152
			%% state of APM memory
			S.MEMINFO = parse_MEMINFO_v1_0(S.MEMINFO,p);

		case 153
			%% raw ADC output
			S.AP_ADC = parse_AP_ADC_v1_0(S.AP_ADC,p);

		case 154
			%% Configure on-board Camera Control System.
			S.DIGICAM_CONFIGURE = parse_DIGICAM_CONFIGURE_v1_0(S.DIGICAM_CONFIGURE,p);

		case 155
			%% Control on-board Camera Control System to take shots.
			S.DIGICAM_CONTROL = parse_DIGICAM_CONTROL_v1_0(S.DIGICAM_CONTROL,p);

		case 156
			%% Message to configure a camera mount, directional antenna, etc.
			S.MOUNT_CONFIGURE = parse_MOUNT_CONFIGURE_v1_0(S.MOUNT_CONFIGURE,p);

		case 157
			%% Message to control a camera mount, directional antenna, etc.
			S.MOUNT_CONTROL = parse_MOUNT_CONTROL_v1_0(S.MOUNT_CONTROL,p);

		case 158
			%% Message with some status from APM to GCS about camera or antenna mount
			S.MOUNT_STATUS = parse_MOUNT_STATUS_v1_0(S.MOUNT_STATUS,p);

		case 160
			%% A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
			%% a point from MAV -> GCS
			S.FENCE_POINT = parse_FENCE_POINT_v1_0(S.FENCE_POINT,p);

		case 161
			%% Request a current fence point from MAV
			S.FENCE_FETCH_POINT = parse_FENCE_FETCH_POINT_v1_0(S.FENCE_FETCH_POINT,p);

		case 162
			%% Status of geo-fencing. Sent in extended      status stream when fencing enabled
			S.FENCE_STATUS = parse_FENCE_STATUS_v1_0(S.FENCE_STATUS,p);

		case 163
			%% Status of DCM attitude estimator
			S.AHRS = parse_AHRS_v1_0(S.AHRS,p);

		case 164
			%% Status of simulation environment, if used
			S.SIMSTATE = parse_SIMSTATE_v1_0(S.SIMSTATE,p);

		case 165
			%% Status of key hardware
			S.HWSTATUS = parse_HWSTATUS_v1_0(S.HWSTATUS,p);

		case 166
			%% Status generated by radio
			S.RADIO = parse_RADIO_v1_0(S.RADIO,p);

		case 167
			%% Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
			S.LIMITS_STATUS = parse_LIMITS_STATUS_v1_0(S.LIMITS_STATUS,p);

		case 168
			%% Wind estimation
			S.WIND = parse_WIND_v1_0(S.WIND,p);

		case 169
			%% Data packet, size 16
			S.DATA16 = parse_DATA16_v1_0(S.DATA16,p);

		case 170
			%% Data packet, size 32
			S.DATA32 = parse_DATA32_v1_0(S.DATA32,p);

		case 171
			%% Data packet, size 64
			S.DATA64 = parse_DATA64_v1_0(S.DATA64,p);

		case 172
			%% Data packet, size 96
			S.DATA96 = parse_DATA96_v1_0(S.DATA96,p);

		case 173
			%% Rangefinder reporting
			S.RANGEFINDER = parse_RANGEFINDER_v1_0(S.RANGEFINDER,p);

		case 174
			%% Airspeed auto-calibration
			S.AIRSPEED_AUTOCAL = parse_AIRSPEED_AUTOCAL_v1_0(S.AIRSPEED_AUTOCAL,p);

		case 175
			%% A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
			%% from MAV -> GCS
			S.RALLY_POINT = parse_RALLY_POINT_v1_0(S.RALLY_POINT,p);

		case 176
			%% Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
			%% MAV should not respond if the request is invalid.
			S.RALLY_FETCH_POINT = parse_RALLY_FETCH_POINT_v1_0(S.RALLY_FETCH_POINT,p);

		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
	end
return

