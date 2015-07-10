function p = encodeMavLink_v1_0_Packet(S)
	switch(S.h_messid)
		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			p = encode_HEARTBEAT_v1_0(S);

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
			p = encode_SYS_STATUS_v1_0(S);

		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			p = encode_SYSTEM_TIME_v1_0(S);

		case 4
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			p = encode_PING_v1_0(S);

		case 5
			%% Request to control this MAV
			p = encode_CHANGE_OPERATOR_CONTROL_v1_0(S);

		case 6
			%% Accept / deny control of this MAV
			p = encode_CHANGE_OPERATOR_CONTROL_ACK_v1_0(S);

		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			p = encode_AUTH_KEY_v1_0(S);

		case 11
			%% Set the system mode, as defined by enum MAV_MODE. There is no target component id 
			%% as the mode is by definition for the overall aircraft, not only for one component.
			p = encode_SET_MODE_v1_0(S);

		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			p = encode_PARAM_REQUEST_READ_v1_0(S);

		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			p = encode_PARAM_REQUEST_LIST_v1_0(S);

		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			p = encode_PARAM_VALUE_v1_0(S);

		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			p = encode_PARAM_SET_v1_0(S);

		case 24
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                 NOT the global position estimate of the system, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			p = encode_GPS_RAW_INT_v1_0(S);

		case 25
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			p = encode_GPS_STATUS_v1_0(S);

		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			p = encode_SCALED_IMU_v1_0(S);

		case 27
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			p = encode_RAW_IMU_v1_0(S);

		case 28
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			p = encode_RAW_PRESSURE_v1_0(S);

		case 29
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			p = encode_SCALED_PRESSURE_v1_0(S);

		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			p = encode_ATTITUDE_v1_0(S);

		case 31
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
			%% expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
			%% be expressed as (1 0 0 0).
			p = encode_ATTITUDE_QUATERNION_v1_0(S);

		case 32
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
			%% convention)
			p = encode_LOCAL_POSITION_NED_v1_0(S);

		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up). It                is designed as scaled integer 
			%% message since the resolution of float is not sufficient.
			p = encode_GLOBAL_POSITION_INT_v1_0(S);

		case 34
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000. Channels that are inactive should be set to UINT16_MAX.
			p = encode_RC_CHANNELS_SCALED_v1_0(S);

		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			p = encode_RC_CHANNELS_RAW_v1_0(S);

		case 36
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			p = encode_SERVO_OUTPUT_RAW_v1_0(S);

		case 37
			%% Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. 
			%% If start and end index are the same, just 
			%% send one waypoint.
			p = encode_MISSION_REQUEST_PARTIAL_LIST_v1_0(S);

		case 38
			%% This message is sent to the MAV to write a partial list. If start index == end index, 
			%% only one item will be transmitted / updated. If the start index is NOT 0 and 
			%% above the current list size, this request should be REJECTED!
			p = encode_MISSION_WRITE_PARTIAL_LIST_v1_0(S);

		case 39
			%% Message encoding a mission item. This message is emitted to announce            
			%%      the presence of a mission item and to set a mission item on the system. The 
			%% mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
			%% Local frame is Z-down, right handed (NED), global frame is Z-up, right 
			%% handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
			p = encode_MISSION_ITEM_v1_0(S);

		case 40
			%% Request the information of the mission item with the sequence number seq. The response 
			%% of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
			p = encode_MISSION_REQUEST_v1_0(S);

		case 41
			%% Set the mission item with sequence number seq as current item. This means that the 
			%% MAV will continue to this mission item on the shortest path (not following the 
			%% mission items in-between).
			p = encode_MISSION_SET_CURRENT_v1_0(S);

		case 42
			%% Message that announces the sequence number of the current active mission item. The 
			%% MAV will fly towards this mission item.
			p = encode_MISSION_CURRENT_v1_0(S);

		case 43
			%% Request the overall list of mission items from the system/component.
			p = encode_MISSION_REQUEST_LIST_v1_0(S);

		case 44
			%% This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
			%% a write transaction. The GCS can then request the individual mission item 
			%% based on the knowledge of the total number of MISSIONs.
			p = encode_MISSION_COUNT_v1_0(S);

		case 45
			%% Delete all mission items at once.
			p = encode_MISSION_CLEAR_ALL_v1_0(S);

		case 46
			%% A certain mission item has been reached. The system will either hold this position 
			%% (or circle on the orbit) or (if the autocontinue on the WP was set) continue 
			%% to the next MISSION.
			p = encode_MISSION_ITEM_REACHED_v1_0(S);

		case 47
			%% Ack message during MISSION handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			p = encode_MISSION_ACK_v1_0(S);

		case 48
			%% As local waypoints exist, the global MISSION reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should move 
			%% from in- to outdoor.
			p = encode_SET_GPS_GLOBAL_ORIGIN_v1_0(S);

		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			p = encode_GPS_GLOBAL_ORIGIN_v1_0(S);

		case 50
			%% Bind a RC channel to a parameter. The parameter should change accoding to the RC 
			%% channel value.
			p = encode_PARAM_MAP_RC_v1_0(S);

		case 54
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/MISSIONs to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			p = encode_SAFETY_SET_ALLOWED_AREA_v1_0(S);

		case 55
			%% Read out the safety zone the MAV currently assumes.
			p = encode_SAFETY_ALLOWED_AREA_v1_0(S);

		case 61
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), 
			%% expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would 
			%% be expressed as (1 0 0 0).
			p = encode_ATTITUDE_QUATERNION_COV_v1_0(S);

		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters.
			p = encode_NAV_CONTROLLER_OUTPUT_v1_0(S);

		case 63
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since 
			%% the resolution of float is not sufficient. NOTE: This message is intended for 
			%% onboard networks / companion computers and higher-bandwidth links and optimized 
			%% for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for 
			%% a minimal subset.
			p = encode_GLOBAL_POSITION_INT_COV_v1_0(S);

		case 64
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down 
			%% convention)
			p = encode_LOCAL_POSITION_NED_COV_v1_0(S);

		case 65
			%% The PPM values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			p = encode_RC_CHANNELS_v1_0(S);

		case 66
			p = encode_REQUEST_DATA_STREAM_v1_0(S);

		case 67
			p = encode_DATA_STREAM_v1_0(S);

		case 69
			%% This message provides an API for manually controlling the vehicle using standard 
			%% joystick axes nomenclature, along with a joystick-like input device. Unused axes 
			%% can be disabled an buttons are also transmit as boolean values of their 
			p = encode_MANUAL_CONTROL_v1_0(S);

		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of UINT16_MAX means no change to that channel. A value of 
			%% 0 means control of that channel should be released back to the RC radio. The standard 
			%% PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			p = encode_RC_CHANNELS_OVERRIDE_v1_0(S);

		case 73
			%% Message encoding a mission item. This message is emitted to announce            
			%%      the presence of a mission item and to set a mission item on the system. The 
			%% mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. 
			%% Local frame is Z-down, right handed (NED), global frame is Z-up, right 
			%% handed (ENU). See alsohttp://qgroundcontrol.org/mavlink/waypoint_protocol.
			p = encode_MISSION_ITEM_INT_v1_0(S);

		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			p = encode_VFR_HUD_v1_0(S);

		case 75
			%% Message encoding a command with parameters as scaled integers. Scaling depends on 
			%% the actual command value.
			p = encode_COMMAND_INT_v1_0(S);

		case 76
			%% Send a command with up to seven parameters to the MAV
			p = encode_COMMAND_LONG_v1_0(S);

		case 77
			%% Report status of a command. Includes feedback wether the command was executed.
			p = encode_COMMAND_ACK_v1_0(S);

		case 81
			%% Setpoint in roll, pitch, yaw and thrust from the operator
			p = encode_MANUAL_SETPOINT_v1_0(S);

		case 82
			%% Set the vehicle attitude and body angular rates.
			p = encode_SET_ATTITUDE_TARGET_v1_0(S);

		case 83
			%% Set the vehicle attitude and body angular rates.
			p = encode_ATTITUDE_TARGET_v1_0(S);

		case 84
			%% Set vehicle position, velocity and acceleration setpoint in local frame.
			p = encode_SET_POSITION_TARGET_LOCAL_NED_v1_0(S);

		case 85
			%% Set vehicle position, velocity and acceleration setpoint in local frame.
			p = encode_POSITION_TARGET_LOCAL_NED_v1_0(S);

		case 86
			%% Set vehicle position, velocity and acceleration setpoint in the WGS84 coordinate 
			%% system.
			p = encode_SET_POSITION_TARGET_GLOBAL_INT_v1_0(S);

		case 87
			%% Set vehicle position, velocity and acceleration setpoint in the WGS84 coordinate 
			%% system.
			p = encode_POSITION_TARGET_GLOBAL_INT_v1_0(S);

		case 89
			%% The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and 
			%% the global coordinate frame in NED coordinates. Coordinate frame is right-handed, 
			%% Z-axis down (aeronautical frame, NED / north-east-down convention)
			p = encode_LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_v1_0(S);

		case 90
			%% DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to 
			%% Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to 
			%% autopilot. This packet is useful for high throughput applications such as hardware 
			%% in the loop simulations.
			p = encode_HIL_STATE_v1_0(S);

		case 91
			%% Sent from autopilot to simulation. Hardware in the loop control outputs
			p = encode_HIL_CONTROLS_v1_0(S);

		case 92
			%% Sent from simulation to autopilot. The RAW values of the RC channels received. The 
			%% standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 
			%% 100%. Individual receivers/transmitters might violate this specification.
			p = encode_HIL_RC_INPUTS_RAW_v1_0(S);

		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			p = encode_OPTICAL_FLOW_v1_0(S);

		case 101
			p = encode_GLOBAL_VISION_POSITION_ESTIMATE_v1_0(S);

		case 102
			p = encode_VISION_POSITION_ESTIMATE_v1_0(S);

		case 103
			p = encode_VISION_SPEED_ESTIMATE_v1_0(S);

		case 104
			p = encode_VICON_POSITION_ESTIMATE_v1_0(S);

		case 105
			%% The IMU readings in SI units in NED body frame
			p = encode_HIGHRES_IMU_v1_0(S);

		case 106
			%% Optical flow from an angular rate flow sensor (e.g. PX4FLOW or mouse sensor)
			p = encode_OPTICAL_FLOW_RAD_v1_0(S);

		case 107
			%% The IMU readings in SI units in NED body frame
			p = encode_HIL_SENSOR_v1_0(S);

		case 108
			%% Status of simulation environment, if used
			p = encode_SIM_STATE_v1_0(S);

		case 109
			%% Status generated by radio and injected into MAVLink stream.
			p = encode_RADIO_STATUS_v1_0(S);

		case 110
			%% File transfer message
			p = encode_FILE_TRANSFER_PROTOCOL_v1_0(S);

		case 111
			%% Time synchronization message.
			p = encode_TIMESYNC_v1_0(S);

		case 113
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%%                  NOT the global position estimate of the sytem, but rather a RAW 
			%% sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate 
			%% frame is right-handed, Z-axis up (GPS frame).
			p = encode_HIL_GPS_v1_0(S);

		case 114
			%% Simulated optical flow from a flow sensor (e.g. PX4FLOW or optical mouse sensor)
			p = encode_HIL_OPTICAL_FLOW_v1_0(S);

		case 115
			%% Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. 
			%% This packet is useful for high throughput applications such as hardware in the 
			%% loop simulations.
			p = encode_HIL_STATE_QUATERNION_v1_0(S);

		case 116
			%% The RAW IMU readings for secondary 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			p = encode_SCALED_IMU2_v1_0(S);

		case 117
			%% Request a list of available logs. On some systems calling this may stop on-board 
			%% logging until LOG_REQUEST_END is called.
			p = encode_LOG_REQUEST_LIST_v1_0(S);

		case 118
			%% Reply to LOG_REQUEST_LIST
			p = encode_LOG_ENTRY_v1_0(S);

		case 119
			%% Request a chunk of a log
			p = encode_LOG_REQUEST_DATA_v1_0(S);

		case 120
			%% Reply to LOG_REQUEST_DATA
			p = encode_LOG_DATA_v1_0(S);

		case 121
			%% Erase all logs
			p = encode_LOG_ERASE_v1_0(S);

		case 122
			%% Stop log transfer and resume normal logging
			p = encode_LOG_REQUEST_END_v1_0(S);

		case 123
			%% data for injecting into the onboard GPS (used for DGPS)
			p = encode_GPS_INJECT_DATA_v1_0(S);

		case 124
			%% Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
			p = encode_GPS2_RAW_v1_0(S);

		case 125
			%% Power supply status
			p = encode_POWER_STATUS_v1_0(S);

		case 126
			%% Control a serial port. This can be used for raw access to an onboard serial peripheral 
			%% such as a GPS or telemetry radio. It is designed to make it possible to update 
			%% the devices firmware via MAVLink messages or change the devices settings. 
			%% A message with zero bytes can be used to change just the baudrate.
			p = encode_SERIAL_CONTROL_v1_0(S);

		case 127
			%% RTK GPS data. Gives information on the relative baseline calculation the GPS is 
			%% reporting
			p = encode_GPS_RTK_v1_0(S);

		case 128
			%% RTK GPS data. Gives information on the relative baseline calculation the GPS is 
			%% reporting
			p = encode_GPS2_RTK_v1_0(S);

		case 129
			%% The RAW IMU readings for 3rd 9DOF sensor setup. This message should contain the 
			%% scaled values to the described units
			p = encode_SCALED_IMU3_v1_0(S);

		case 130
			p = encode_DATA_TRANSMISSION_HANDSHAKE_v1_0(S);

		case 131
			p = encode_ENCAPSULATED_DATA_v1_0(S);

		case 132
			p = encode_DISTANCE_SENSOR_v1_0(S);

		case 133
			%% Request for terrain data and terrain status
			p = encode_TERRAIN_REQUEST_v1_0(S);

		case 134
			%% Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon 
			%% from a TERRAIN_REQUEST
			p = encode_TERRAIN_DATA_v1_0(S);

		case 135
			%% Request that the vehicle report terrain height at the given location. Used by GCS 
			%% to check if vehicle has all terrain data needed for a mission.
			p = encode_TERRAIN_CHECK_v1_0(S);

		case 136
			%% Response from a TERRAIN_CHECK request
			p = encode_TERRAIN_REPORT_v1_0(S);

		case 137
			%% Barometer readings for 2nd barometer
			p = encode_SCALED_PRESSURE2_v1_0(S);

		case 138
			%% Motion capture attitude and position
			p = encode_ATT_POS_MOCAP_v1_0(S);

		case 139
			%% Set the vehicle attitude and body angular rates.
			p = encode_SET_ACTUATOR_CONTROL_TARGET_v1_0(S);

		case 140
			%% Set the vehicle attitude and body angular rates.
			p = encode_ACTUATOR_CONTROL_TARGET_v1_0(S);

		case 147
			%% Battery information
			p = encode_BATTERY_STATUS_v1_0(S);

		case 148
			%% Version and capability of autopilot software
			p = encode_AUTOPILOT_VERSION_v1_0(S);

		case 248
			%% Message implementing parts of the V2 payload specs in V1 frames for transitional 
			%% support.
			p = encode_V2_EXTENSION_v1_0(S);

		case 249
			%% Send raw controller memory. The use of this message is discouraged for normal packets, 
			%% but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_MEMORY_VECT_v1_0(S);

		case 250
			p = encode_DEBUG_VECT_v1_0(S);

		case 251
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_FLOAT_v1_0(S);

		case 252
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_INT_v1_0(S);

		case 253
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			p = encode_STATUSTEXT_v1_0(S);

		case 254
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			p = encode_DEBUG_v1_0(S);

		case 151
			p = encode_SET_CAM_SHUTTER_v1_0(S);

		case 152
			p = encode_IMAGE_TRIGGERED_v1_0(S);

		case 153
			p = encode_IMAGE_TRIGGER_CONTROL_v1_0(S);

		case 154
			p = encode_IMAGE_AVAILABLE_v1_0(S);

		case 160
			%% Message sent to the MAV to set a new offset from the currently controlled position
			p = encode_SET_POSITION_CONTROL_OFFSET_v1_0(S);

		case 170
			p = encode_POSITION_CONTROL_SETPOINT_v1_0(S);

		case 171
			p = encode_MARKER_v1_0(S);

		case 172
			p = encode_RAW_AUX_v1_0(S);

		case 180
			p = encode_WATCHDOG_HEARTBEAT_v1_0(S);

		case 181
			p = encode_WATCHDOG_PROCESS_INFO_v1_0(S);

		case 182
			p = encode_WATCHDOG_PROCESS_STATUS_v1_0(S);

		case 183
			p = encode_WATCHDOG_COMMAND_v1_0(S);

		case 190
			p = encode_PATTERN_DETECTED_v1_0(S);

		case 191
			%% Notifies the operator about a point of interest (POI). This can be anything detected 
			%% by the                 system. This generic message is intented to help interfacing 
			%% to generic visualizations and to display                 the POI on a map. 
			%%             
			p = encode_POINT_OF_INTEREST_v1_0(S);

		case 192
			%% Notifies the operator about the connection of two point of interests (POI). This 
			%% can be anything detected by the                 system. This generic message is 
			%% intented to help interfacing to generic visualizations and to display          
			%%        the POI on a map.             
			p = encode_POINT_OF_INTEREST_CONNECTION_v1_0(S);

		case 195
			p = encode_BRIEF_FEATURE_v1_0(S);

		case 200
			p = encode_ATTITUDE_CONTROL_v1_0(S);

		case 205
			p = encode_DETECTION_STATS_v1_0(S);

		case 206
			p = encode_ONBOARD_HEALTH_v1_0(S);

		otherwise
			disp(sprintf('Unknown Message: id[%d]',S.h_messid))
	end
return

