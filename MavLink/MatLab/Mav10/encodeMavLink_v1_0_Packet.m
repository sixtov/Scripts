function p = encodeMavLink_v1_0_Packet(ID,S)
	switch(ID)
		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			p = encode_HEARTBEAT_v1_0(S.HEARTBEAT);

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
			p = encode_SYS_STATUS_v1_0(S.SYS_STATUS);

		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			p = encode_SYSTEM_TIME_v1_0(S.SYSTEM_TIME);

		case 4
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			p = encode_PING_v1_0(S.PING);

		case 5
			%% Request to control this MAV
			p = encode_CHANGE_OPERATOR_CONTROL_v1_0(S.CHANGE_OPERATOR_CONTROL);

		case 6
			%% Accept / deny control of this MAV
			p = encode_CHANGE_OPERATOR_CONTROL_ACK_v1_0(S.CHANGE_OPERATOR_CONTROL_ACK);

		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			p = encode_AUTH_KEY_v1_0(S.AUTH_KEY);

		case 11
			%% Set the system mode, as defined by enum MAV_MODE. There is no target component id 
			%% as the mode is by definition for the overall aircraft, not only for one component.
			p = encode_SET_MODE_v1_0(S.SET_MODE);

		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			p = encode_PARAM_REQUEST_READ_v1_0(S.PARAM_REQUEST_READ);

		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			p = encode_PARAM_REQUEST_LIST_v1_0(S.PARAM_REQUEST_LIST);

		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			p = encode_PARAM_VALUE_v1_0(S.PARAM_VALUE);

		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			p = encode_PARAM_SET_v1_0(S.PARAM_SET);

		case 24
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                 NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			p = encode_GPS_RAW_INT_v1_0(S.GPS_RAW_INT);

		case 25
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			p = encode_GPS_STATUS_v1_0(S.GPS_STATUS);

		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			p = encode_SCALED_IMU_v1_0(S.SCALED_IMU);

		case 27
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			p = encode_RAW_IMU_v1_0(S.RAW_IMU);

		case 28
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			p = encode_RAW_PRESSURE_v1_0(S.RAW_PRESSURE);

		case 29
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			p = encode_SCALED_PRESSURE_v1_0(S.SCALED_PRESSURE);

		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			p = encode_ATTITUDE_v1_0(S.ATTITUDE);

		case 31
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
			%% expressed as quaternion.
			p = encode_ATTITUDE_QUATERNION_v1_0(S.ATTITUDE_QUATERNION);

		case 32
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
			%% convention)
			p = encode_LOCAL_POSITION_NED_v1_0(S.LOCAL_POSITION_NED);

		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
			%% message since the resolution of float is not sufficient.
			p = encode_GLOBAL_POSITION_INT_v1_0(S.GLOBAL_POSITION_INT);

		case 34
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000. Channels that are inactive should be set to UINT16_MAX.
			p = encode_RC_CHANNELS_SCALED_v1_0(S.RC_CHANNELS_SCALED);

		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			p = encode_RC_CHANNELS_RAW_v1_0(S.RC_CHANNELS_RAW);

		case 36
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			p = encode_SERVO_OUTPUT_RAW_v1_0(S.SERVO_OUTPUT_RAW);

		case 37
			%% Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
			%% If start and end index are the same, just 
			%% send one waypoint.
			p = encode_MISSION_REQUEST_PARTIAL_LIST_v1_0(S.MISSION_REQUEST_PARTIAL_LIST);

		case 38
			%% This message is sent to the MAV to write a partial list. If start index == end index, 
			%% only one item will be transmitted / updated. If the start index is NOT 0 and 
			%% above the current list size, this request should be REJECTED!
			p = encode_MISSION_WRITE_PARTIAL_LIST_v1_0(S.MISSION_WRITE_PARTIAL_LIST);

		case 39
			%% Message encoding a mission item. This message is emitted to announce            
			%%      the presence of a mission item and to set a mission item on the system. The 
			%% mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
			%% Local frame is Z-down, right handed (NED), global frame is Z-up, right 
			%% handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
			p = encode_MISSION_ITEM_v1_0(S.MISSION_ITEM);

		case 40
			%% Request the information of the mission item with the sequence number seq. The response 
			%% of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
			p = encode_MISSION_REQUEST_v1_0(S.MISSION_REQUEST);

		case 41
			%% Set the mission item with sequence number seq as current item. This means that the 
			%% MAV will continue to this mission item on the shortest path (not following the 
			%% mission items in-between).
			p = encode_MISSION_SET_CURRENT_v1_0(S.MISSION_SET_CURRENT);

		case 42
			%% Message that announces the sequence number of the current active mission item. The 
			%% MAV will fly towards this mission item.
			p = encode_MISSION_CURRENT_v1_0(S.MISSION_CURRENT);

		case 43
			%% Request the overall list of mission items from the system/component.
			p = encode_MISSION_REQUEST_LIST_v1_0(S.MISSION_REQUEST_LIST);

		case 44
			%% This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
			%% a write transaction. The GCS can then request the individual mission item 
			%% based on the knowledge of the total number of MISSIONs.
			p = encode_MISSION_COUNT_v1_0(S.MISSION_COUNT);

		case 45
			%% Delete all mission items at once.
			p = encode_MISSION_CLEAR_ALL_v1_0(S.MISSION_CLEAR_ALL);

		case 46
			%% A certain mission item has been reached. The system will either hold this position 
			%% (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
			%% to the next MISSION.
			p = encode_MISSION_ITEM_REACHED_v1_0(S.MISSION_ITEM_REACHED);

		case 47
			%% Ack message during MISSION handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			p = encode_MISSION_ACK_v1_0(S.MISSION_ACK);

		case 48
			%% As local waypoints exist, the global MISSION reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should move 
			%% from in- to outdoor.
			p = encode_SET_GPS_GLOBAL_ORIGIN_v1_0(S.SET_GPS_GLOBAL_ORIGIN);

		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			p = encode_GPS_GLOBAL_ORIGIN_v1_0(S.GPS_GLOBAL_ORIGIN);

		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/MISSION planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			p = encode_SET_LOCAL_POSITION_SETPOINT_v1_0(S.SET_LOCAL_POSITION_SETPOINT);

		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			p = encode_LOCAL_POSITION_SETPOINT_v1_0(S.LOCAL_POSITION_SETPOINT);

		case 52
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			p = encode_GLOBAL_POSITION_SETPOINT_INT_v1_0(S.GLOBAL_POSITION_SETPOINT_INT);

		case 53
			%% Set the current global position setpoint.
			p = encode_SET_GLOBAL_POSITION_SETPOINT_INT_v1_0(S.SET_GLOBAL_POSITION_SETPOINT_INT);

		case 54
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/MISSIONs to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			p = encode_SAFETY_SET_ALLOWED_AREA_v1_0(S.SAFETY_SET_ALLOWED_AREA);

		case 55
			%% Read out the safety zone the MAV currently assumes.
			p = encode_SAFETY_ALLOWED_AREA_v1_0(S.SAFETY_ALLOWED_AREA);

		case 56
			%% Set roll, pitch and yaw.
			p = encode_SET_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_ROLL_PITCH_YAW_THRUST);

		case 57
			%% Set roll, pitch and yaw.
			p = encode_SET_ROLL_PITCH_YAW_SPEED_THRUST_v1_0(S.SET_ROLL_PITCH_YAW_SPEED_THRUST);

		case 58
			%% Setpoint in roll, pitch, yaw currently active on the system.
			p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_THRUST_SETPOINT);

		case 59
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			p = encode_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT);

		case 60
			%% Setpoint in the four motor speeds
			p = encode_SET_QUAD_MOTORS_SETPOINT_v1_0(S.SET_QUAD_MOTORS_SETPOINT);

		case 61
			%% Setpoint for up to four quadrotors in a group / wing
			p = encode_SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST);

		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters.
			p = encode_NAV_CONTROLLER_OUTPUT_v1_0(S.NAV_CONTROLLER_OUTPUT);

		case 63
			%% Setpoint for up to four quadrotors in a group / wing
			p = encode_SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_v1_0(S.SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST);

		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			p = encode_STATE_CORRECTION_v1_0(S.STATE_CORRECTION);

		case 66
			p = encode_REQUEST_DATA_STREAM_v1_0(S.REQUEST_DATA_STREAM);

		case 67
			p = encode_DATA_STREAM_v1_0(S.DATA_STREAM);

		case 69
			%% This message provides an API for manually controlling the vehicle using standard 
			%% joystick axes nomenclature, along with a joystick-like input device. Unused axes 
			%% can be disabled an buttons are also transmit as boolean values of their 
			p = encode_MANUAL_CONTROL_v1_0(S.MANUAL_CONTROL);

		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
			%% 0 means control of that channel should be released back to the RC radio. The standard 
			%% PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			p = encode_RC_CHANNELS_OVERRIDE_v1_0(S.RC_CHANNELS_OVERRIDE);

		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			p = encode_VFR_HUD_v1_0(S.VFR_HUD);

		case 76
			%% Send a command with up to seven parameters to the MAV
			p = encode_COMMAND_LONG_v1_0(S.COMMAND_LONG);

		case 77
			%% Report status of a command. Includes feedback wether the command was executed.
			p = encode_COMMAND_ACK_v1_0(S.COMMAND_ACK);

		case 80
			%% Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
			p = encode_ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_v1_0(S.ROLL_PITCH_YAW_RATES_THRUST_SETPOINT);

		case 81
			%% Setpoint in roll, pitch, yaw and thrust from the operator
			p = encode_MANUAL_SETPOINT_v1_0(S.MANUAL_SETPOINT);

		case 89
			%% The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
			%% the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
			%% Z-axis down (aeronautical frame, NED / north-east-down convention)
			p = encode_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S.LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET);

		case 90
			%% DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
			%% Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
			%% autopilot. This packet is useful for high throughput applications such as hardware 
			%% in the loop simulations.
			p = encode_HIL_STATE_v1_0(S.HIL_STATE);

		case 91
			%% Sent from autopilot to simulation. Hardware in the loop control outputs
			p = encode_HIL_CONTROLS_v1_0(S.HIL_CONTROLS);

		case 92
			%% Sent from simulation to autopilot. The RAW values of the RC channels received. The 
			%% standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			p = encode_HIL_RC_INPUTS_RAW_v1_0(S.HIL_RC_INPUTS_RAW);

		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			p = encode_OPTICAL_FLOW_v1_0(S.OPTICAL_FLOW);

		case 101
			p = encode_GLOBAL_VISION_POSITION_ESTIMATE_v1_0(S.GLOBAL_VISION_POSITION_ESTIMATE);

		case 102
			p = encode_VISION_POSITION_ESTIMATE_v1_0(S.VISION_POSITION_ESTIMATE);

		case 103
			p = encode_VISION_SPEED_ESTIMATE_v1_0(S.VISION_SPEED_ESTIMATE);

		case 104
			p = encode_VICON_POSITION_ESTIMATE_v1_0(S.VICON_POSITION_ESTIMATE);

		case 105
			%% The IMU readings in SI units in NED body frame
			p = encode_HIGHRES_IMU_v1_0(S.HIGHRES_IMU);

		case 106
			%% Optical flow from an omnidirectional flow sensor (e.g. PX4FLOW with wide angle lens)
			p = encode_OMNIDIRECTIONAL_FLOW_v1_0(S.OMNIDIRECTIONAL_FLOW);

		case 107
			%% The IMU readings in SI units in NED body frame
			p = encode_HIL_SENSOR_v1_0(S.HIL_SENSOR);

		case 108
			%% Status of simulation environment, if used
			p = encode_SIM_STATE_v1_0(S.SIM_STATE);

		case 109
			%% Status generated by radio
			p = encode_RADIO_STATUS_v1_0(S.RADIO_STATUS);

		case 110
			%% Begin file transfer
			p = encode_FILE_TRANSFER_START_v1_0(S.FILE_TRANSFER_START);

		case 111
			%% Get directory listing
			p = encode_FILE_TRANSFER_DIR_LIST_v1_0(S.FILE_TRANSFER_DIR_LIST);

		case 112
			%% File transfer result
			p = encode_FILE_TRANSFER_RES_v1_0(S.FILE_TRANSFER_RES);

		case 113
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                  NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			p = encode_HIL_GPS_v1_0(S.HIL_GPS);

		case 114
			%% Simulated optical flow from a flow sensor (e.g. optical mouse sensor)
			p = encode_HIL_OPTICAL_FLOW_v1_0(S.HIL_OPTICAL_FLOW);

		case 115
			%% Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
			%% This packet is useful for high throughput applications such as hardware in the 
			%% loop simulations.
			p = encode_HIL_STATE_QUATERNION_v1_0(S.HIL_STATE_QUATERNION);

		case 116
			%% The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			p = encode_SCALED_IMU2_v1_0(S.SCALED_IMU2);

		case 117
			%% Request a list of available logs. On some systems calling this may stop on-board 
			%% logging until LOG_REQUEST_END is called.
			p = encode_LOG_REQUEST_LIST_v1_0(S.LOG_REQUEST_LIST);

		case 118
			%% Reply to LOG_REQUEST_LIST
			p = encode_LOG_ENTRY_v1_0(S.LOG_ENTRY);

		case 119
			%% Request a chunk of a log
			p = encode_LOG_REQUEST_DATA_v1_0(S.LOG_REQUEST_DATA);

		case 120
			%% Reply to LOG_REQUEST_DATA
			p = encode_LOG_DATA_v1_0(S.LOG_DATA);

		case 121
			%% Erase all logs
			p = encode_LOG_ERASE_v1_0(S.LOG_ERASE);

		case 122
			%% Stop log transfer and resume normal logging
			p = encode_LOG_REQUEST_END_v1_0(S.LOG_REQUEST_END);

		case 147
			%% Transmitte battery informations for a accu pack.
			p = encode_BATTERY_STATUS_v1_0(S.BATTERY_STATUS);

		case 148
			%% Set the 8 DOF setpoint for a controller.
			p = encode_SETPOINT_8DOF_v1_0(S.SETPOINT_8DOF);

		case 149
			%% Set the 6 DOF setpoint for a attitude and position controller.
			p = encode_SETPOINT_6DOF_v1_0(S.SETPOINT_6DOF);

		case 249
			%% Send raw controller memory. The use of this message is discouraged for normal packets, 
			%% but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_MEMORY_VECT_v1_0(S.MEMORY_VECT);

		case 250
			p = encode_DEBUG_VECT_v1_0(S.DEBUG_VECT);

		case 251
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_FLOAT_v1_0(S.NAMED_VALUE_FLOAT);

		case 252
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_INT_v1_0(S.NAMED_VALUE_INT);

		case 253
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			p = encode_STATUSTEXT_v1_0(S.STATUSTEXT);

		case 254
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			p = encode_DEBUG_v1_0(S.DEBUG);

		case 150
			%% Offsets and calibrations values for hardware         sensors. This makes it easier 
			%% to debug the calibration process.
			p = encode_SENSOR_OFFSETS_v1_0(S.SENSOR_OFFSETS);

		case 151
			%% set the magnetometer offsets
			p = encode_SET_MAG_OFFSETS_v1_0(S.SET_MAG_OFFSETS);

		case 152
			%% state of APM memory
			p = encode_MEMINFO_v1_0(S.MEMINFO);

		case 153
			%% raw ADC output
			p = encode_AP_ADC_v1_0(S.AP_ADC);

		case 154
			%% Configure on-board Camera Control System.
			p = encode_DIGICAM_CONFIGURE_v1_0(S.DIGICAM_CONFIGURE);

		case 155
			%% Control on-board Camera Control System to take shots.
			p = encode_DIGICAM_CONTROL_v1_0(S.DIGICAM_CONTROL);

		case 156
			%% Message to configure a camera mount, directional antenna, etc.
			p = encode_MOUNT_CONFIGURE_v1_0(S.MOUNT_CONFIGURE);

		case 157
			%% Message to control a camera mount, directional antenna, etc.
			p = encode_MOUNT_CONTROL_v1_0(S.MOUNT_CONTROL);

		case 158
			%% Message with some status from APM to GCS about camera or antenna mount
			p = encode_MOUNT_STATUS_v1_0(S.MOUNT_STATUS);

		case 160
			%% A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
			%% a point from MAV -> GCS
			p = encode_FENCE_POINT_v1_0(S.FENCE_POINT);

		case 161
			%% Request a current fence point from MAV
			p = encode_FENCE_FETCH_POINT_v1_0(S.FENCE_FETCH_POINT);

		case 162
			%% Status of geo-fencing. Sent in extended      status stream when fencing enabled
			p = encode_FENCE_STATUS_v1_0(S.FENCE_STATUS);

		case 163
			%% Status of DCM attitude estimator
			p = encode_AHRS_v1_0(S.AHRS);

		case 164
			%% Status of simulation environment, if used
			p = encode_SIMSTATE_v1_0(S.SIMSTATE);

		case 165
			%% Status of key hardware
			p = encode_HWSTATUS_v1_0(S.HWSTATUS);

		case 166
			%% Status generated by radio
			p = encode_RADIO_v1_0(S.RADIO);

		case 167
			%% Status of AP_Limits. Sent in extended      status stream when AP_Limits is enabled
			p = encode_LIMITS_STATUS_v1_0(S.LIMITS_STATUS);

		case 168
			%% Wind estimation
			p = encode_WIND_v1_0(S.WIND);

		case 169
			%% Data packet, size 16
			p = encode_DATA16_v1_0(S.DATA16);

		case 170
			%% Data packet, size 32
			p = encode_DATA32_v1_0(S.DATA32);

		case 171
			%% Data packet, size 64
			p = encode_DATA64_v1_0(S.DATA64);

		case 172
			%% Data packet, size 96
			p = encode_DATA96_v1_0(S.DATA96);

		case 173
			%% Rangefinder reporting
			p = encode_RANGEFINDER_v1_0(S.RANGEFINDER);

		case 174
			%% Airspeed auto-calibration
			p = encode_AIRSPEED_AUTOCAL_v1_0(S.AIRSPEED_AUTOCAL);

		case 175
			%% A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
			%% from MAV -> GCS
			p = encode_RALLY_POINT_v1_0(S.RALLY_POINT);

		case 176
			%% Request a current rally point from MAV. MAV should respond with a RALLY_POINT message. 
			%% MAV should not respond if the request is invalid.
			p = encode_RALLY_FETCH_POINT_v1_0(S.RALLY_FETCH_POINT);

		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
	end
return

