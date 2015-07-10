function p = encodeMavLink_0_9_Packet(ID,S)
	switch(ID)
		case 111
			%% analog channels raw (counts from ADC 0-1024)
			p = encode_ANALOG_RAW(S);

		case 112
			%% analog channels EU (Raw counts converted to engineering units, e.g. feet, meters, 
			%% Amps, degrees, etc)
			p = encode_ANALOG_EU(S);

		case 113
			%% Message from Conflict Detection and Resolution monitor to aircraft. This is a command 
			%% to resolve conflicts and includes flags and values for heading,altitude,and 
			%% speed changes as well as a max time duration
			p = encode_CDNR_CONTROLLER(S);

		case 114
			%% Message that provides 6 dof position data about other traffic. This includes: Vehicle 
			%% number, latitud (deg), longitud (deg), altitud(meters), roll (deg), pitch 
			%% (deg), heading(deg)
			p = encode_TRAFFIC_DATA(S);

		case 115
			%% Message that provides information about the state of the aircraft
			p = encode_STATE_DATA(S);

		case 116
			%% Message that provides timing information about the traffic simulation
			p = encode_TRAFFIC_SIM_TIMING(S);

		case 117
			%% Message that provides information about the state of the aircraft
			p = encode_STATE_DATA_AUG(S);

		case 120
			%% Message that provides Battery End-Of-Discharge(EOD), Remaining-Useful-Life(RUL), 
			%% and State-Of-Charge(SOC) information
			p = encode_BHM_SOC_EOD_RUL(S);

		case 121
			%% Message that provides Battery Current, Voltage, RPM, and an alert status
			p = encode_BHM_CURRENT_VOLTAGE(S);

		case 0
			%% The heartbeat message shows that a system is present and responding. The type of 
			%% the MAV and Autopilot hardware allow the receiving system to treat further messages 
			%% from this system appropriate (e.g. by laying out the user interface based on 
			%% the autopilot).
			p = encode_HEARTBEAT(S);

		case 1
			%% The boot message indicates that a system is starting. The onboard software version 
			%% allows to keep track of onboard soft/firmware revisions.
			p = encode_BOOT(S);

		case 2
			%% The system time is the time of the master clock, typically the computer clock of 
			%% the main onboard computer.
			p = encode_SYSTEM_TIME(S);

		case 3
			%% A ping message either requesting or responding to a ping. This allows to measure 
			%% the system latencies, including serial port, radio modem and UDP connections.
			p = encode_PING(S);

		case 4
			%% UTC date and time from GPS module
			p = encode_SYSTEM_TIME_UTC(S);

		case 5
			%% Request to control this MAV
			p = encode_CHANGE_OPERATOR_CONTROL(S);

		case 6
			%% Accept / deny control of this MAV
			p = encode_CHANGE_OPERATOR_CONTROL_ACK(S);

		case 7
			%% Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol 
			%% has been kept simple, so transmitting the key requires an encrypted channel 
			%% for true safety.
			p = encode_AUTH_KEY(S);

		case 9
			%% This message acknowledges an action. IMPORTANT: The acknowledgement can be also 
			%% negative, e.g. the MAV rejects a reset message because it is in-flight. The action 
			%% ids are defined in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			p = encode_ACTION_ACK(S);

		case 10
			%% An action message allows to execute a certain onboard action. These include liftoff, 
			%% land, storing parameters too EEPROM, shutddown, etc. The action ids are defined 
			%% in ENUM MAV_ACTION in mavlink/include/mavlink_types.h
			p = encode_ACTION(S);

		case 11
			%% Set the system mode, as defined by enum MAV_MODE in mavlink/include/mavlink_types.h. 
			%% There is no target component id as the mode is by definition for the overall 
			%% aircraft, not only for one component.
			p = encode_SET_MODE(S);

		case 12
			%% Set the system navigation mode, as defined by enum MAV_NAV_MODE in mavlink/include/mavlink_types.h. 
			%% The navigation mode applies to the whole aircraft and thus all 
			%% components.
			p = encode_SET_NAV_MODE(S);

		case 20
			%% Request to read the onboard parameter with the param_id string id. Onboard parameters 
			%% are stored as key[const char*] -> value[float]. This allows to send a parameter 
			%% to any other component (such as the GCS) without the need of previous knowledge 
			%% of possible parameter names. Thus the same GCS can store different parameters 
			%% for different autopilots. See also http://qgroundcontrol.org/parameter_interface 
			%% for a full documentation of QGroundControl and IMU code.
			p = encode_PARAM_REQUEST_READ(S);

		case 21
			%% Request all parameters of this component. After his request, all parameters are 
			%% emitted.
			p = encode_PARAM_REQUEST_LIST(S);

		case 22
			%% Emit the value of a onboard parameter. The inclusion of param_count and param_index 
			%% in the message allows the recipient to keep track of received parameters and 
			%% allows him to re-request missing parameters after a loss or timeout.
			p = encode_PARAM_VALUE(S);

		case 23
			%% Set a parameter value TEMPORARILY to RAM. It will be reset to default on system 
			%% reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents 
			%% to EEPROM. IMPORTANT: The receiving component should acknowledge the new 
			%% parameter value by sending a param_value message to all communication partners. 
			%% This will also ensure that multiple GCS all have an up-to-date list of all parameters. 
			%% If the sending GCS did not receive a PARAM_VALUE message within its timeout 
			%% time, it should re-send the PARAM_SET message.
			p = encode_PARAM_SET(S);

		case 25
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			p = encode_GPS_RAW_INT(S);

		case 26
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should contain 
			%% the scaled values to the described units
			p = encode_SCALED_IMU(S);

		case 27
			%% The positioning status, as reported by GPS. This message is intended to display 
			%% status information about each satellite visible to the receiver. See message GLOBAL_POSITION 
			%% for the global position estimate. This message can contain information 
			%% for up to 20 satellites.
			p = encode_GPS_STATUS(S);

		case 28
			%% The RAW IMU readings for the usual 9DOF sensor setup. This message should always 
			%% contain the true raw values without any scaling to allow data capture and system 
			%% debugging.
			p = encode_RAW_IMU(S);

		case 29
			%% The RAW pressure readings for the typical setup of one absolute pressure and one 
			%% differential pressure sensor. The sensor values should be the raw, UNSCALED ADC 
			%% values.
			p = encode_RAW_PRESSURE(S);

		case 38
			%% The pressure readings for the typical setup of one absolute and differential pressure 
			%% sensor. The units are as specified in each field.
			p = encode_SCALED_PRESSURE(S);

		case 30
			%% The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
			p = encode_ATTITUDE(S);

		case 31
			%% The filtered local position (e.g. fused computer vision and accelerometers). Coordinate 
			%% frame is right-handed, Z-axis down (aeronautical frame)
			p = encode_LOCAL_POSITION(S);

		case 33
			%% The filtered global position (e.g. fused GPS and accelerometers). Coordinate frame 
			%% is right-handed, Z-axis up (GPS frame)
			p = encode_GLOBAL_POSITION(S);

		case 32
			%% The global position, as returned by the Global Positioning System (GPS). This is 
			%% NOT the global position estimate of the sytem, but rather a RAW sensor value. See 
			%% message GLOBAL_POSITION for the global position estimate. Coordinate frame is 
			%% right-handed, Z-axis up (GPS frame)
			p = encode_GPS_RAW(S);

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
			p = encode_SYS_STATUS(S);

		case 35
			%% The RAW values of the RC channels received. The standard PPM modulation is as follows: 
			%% 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters 
			%% might violate this specification.
			p = encode_RC_CHANNELS_RAW(S);

		case 36
			%% The scaled values of the RC channels received. (-100%) -10000, (0%) 0, (100%) 
			%% 10000
			p = encode_RC_CHANNELS_SCALED(S);

		case 37
			%% The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS 
			%% messages). The standard PPM modulation is as follows: 1000 microseconds: 
			%% 0%, 2000 microseconds: 100%.
			p = encode_SERVO_OUTPUT_RAW(S);

		case 39
			%% Message encoding a waypoint. This message is emitted to announce      the presence 
			%% of a waypoint and to set a waypoint on the system. The waypoint can be either 
			%% in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, 
			%% right handed, global frame is Z-up, right handed
			p = encode_WAYPOINT(S);

		case 40
			%% Request the information of the waypoint with the sequence number seq. The response 
			%% of the system to this message should be a WAYPOINT message.
			p = encode_WAYPOINT_REQUEST(S);

		case 41
			%% Set the waypoint with sequence number seq as current waypoint. This means that the 
			%% MAV will continue to this waypoint on the shortest path (not following the waypoints 
			%% in-between).
			p = encode_WAYPOINT_SET_CURRENT(S);

		case 42
			%% Message that announces the sequence number of the current active waypoint. The MAV 
			%% will fly towards this waypoint.
			p = encode_WAYPOINT_CURRENT(S);

		case 43
			%% Request the overall list of waypoints from the system/component.
			p = encode_WAYPOINT_REQUEST_LIST(S);

		case 44
			%% This message is emitted as response to WAYPOINT_REQUEST_LIST by the MAV. The GCS 
			%% can then request the individual waypoints based on the knowledge of the total number 
			%% of waypoints.
			p = encode_WAYPOINT_COUNT(S);

		case 45
			%% Delete all waypoints at once.
			p = encode_WAYPOINT_CLEAR_ALL(S);

		case 46
			%% A certain waypoint has been reached. The system will either hold this position (or 
			%% circle on the orbit) or (if the autocontinue on the WP was set) continue to the 
			%% next waypoint.
			p = encode_WAYPOINT_REACHED(S);

		case 47
			%% Ack message during waypoint handling. The type field states if this message is a 
			%% positive ack (type=0) or if an error happened (type=non-zero).
			p = encode_WAYPOINT_ACK(S);

		case 48
			%% As local waypoints exist, the global waypoint reference allows to transform between 
			%% the local coordinate frame and the global (GPS) coordinate frame. This can be 
			%% necessary when e.g. in- and outdoor settings are connected and the MAV should 
			%% move from in- to outdoor.
			p = encode_GPS_SET_GLOBAL_ORIGIN(S);

		case 49
			%% Once the MAV sets a new GPS-Local correspondence, this message announces the origin 
			%% (0,0,0) position
			p = encode_GPS_LOCAL_ORIGIN_SET(S);

		case 50
			%% Set the setpoint for a local position controller. This is the position in local 
			%% coordinates the MAV should fly to. This message is sent by the path/waypoint planner 
			%% to the onboard position controller. As some MAVs have a degree of freedom in 
			%% yaw (e.g. all helicopters/quadrotors), the desired yaw angle is part of the message.
			p = encode_LOCAL_POSITION_SETPOINT_SET(S);

		case 51
			%% Transmit the current local setpoint of the controller to other MAVs (collision avoidance) 
			%% and to the GCS.
			p = encode_LOCAL_POSITION_SETPOINT(S);

		case 52
			p = encode_CONTROL_STATUS(S);

		case 53
			%% Set a safety zone (volume), which is defined by two corners of a cube. This message 
			%% can be used to tell the MAV which setpoints/waypoints to accept and which to 
			%% reject. Safety areas are often enforced by national or competition regulations.
			p = encode_SAFETY_SET_ALLOWED_AREA(S);

		case 54
			%% Read out the safety zone the MAV currently assumes.
			p = encode_SAFETY_ALLOWED_AREA(S);

		case 55
			%% Set roll, pitch and yaw.
			p = encode_SET_ROLL_PITCH_YAW_THRUST(S);

		case 56
			%% Set roll, pitch and yaw.
			p = encode_SET_ROLL_PITCH_YAW_SPEED_THRUST(S);

		case 57
			%% Setpoint in roll, pitch, yaw currently active on the system.
			p = encode_ROLL_PITCH_YAW_THRUST_SETPOINT(S);

		case 58
			%% Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
			p = encode_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(S);

		case 62
			%% Outputs of the APM navigation controller. The primary use of this message is to 
			%% check the response and signs of the controller before actual flight and to assist 
			%% with tuning controller parameters 
			p = encode_NAV_CONTROLLER_OUTPUT(S);

		case 63
			%% The goal position of the system. This position is the input to any navigation or 
			%% path planning algorithm and does NOT represent the current controller setpoint.
			p = encode_POSITION_TARGET(S);

		case 64
			%% Corrects the systems state by adding an error correction term to the position and 
			%% velocity, and by rotating the attitude by a correction angle.
			p = encode_STATE_CORRECTION(S);

		case 65
			p = encode_SET_ALTITUDE(S);

		case 66
			p = encode_REQUEST_DATA_STREAM(S);

		case 67
			%% This packet is useful for high throughput                 applications such as hardware 
			%% in the loop simulations.             
			p = encode_HIL_STATE(S);

		case 68
			%% Hardware in the loop control outputs
			p = encode_HIL_CONTROLS(S);

		case 69
			p = encode_MANUAL_CONTROL(S);

		case 70
			%% The RAW values of the RC channels sent to the MAV to override info received from 
			%% the RC radio. A value of -1 means no change to that channel. A value of 0 means 
			%% control of that channel should be released back to the RC radio. The standard PPM 
			%% modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual 
			%% receivers/transmitters might violate this specification.
			p = encode_RC_CHANNELS_OVERRIDE(S);

		case 73
			%% The filtered global position (e.g. fused GPS and accelerometers). The position is 
			%% in GPS-frame (right-handed, Z-up)
			p = encode_GLOBAL_POSITION_INT(S);

		case 74
			%% Metrics typically displayed on a HUD for fixed wing aircraft
			p = encode_VFR_HUD(S);

		case 75
			%% Send a command with up to four parameters to the MAV
			p = encode_COMMAND(S);

		case 76
			%% Report status of a command. Includes feedback wether the command was executed
			p = encode_COMMAND_ACK(S);

		case 100
			%% Optical flow from a flow sensor (e.g. optical mouse sensor)
			p = encode_OPTICAL_FLOW(S);

		case 140
			%% Object has been detected
			p = encode_OBJECT_DETECTION_EVENT(S);

		case 251
			p = encode_DEBUG_VECT(S);

		case 252
			%% Send a key-value pair as float. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_FLOAT(S);

		case 253
			%% Send a key-value pair as integer. The use of this message is discouraged for normal 
			%% packets, but a quite efficient way for testing new messages and getting experimental 
			%% debug output.
			p = encode_NAMED_VALUE_INT(S);

		case 254
			%% Status text message. These messages are printed in yellow in the COMM console of 
			%% QGroundControl. WARNING: They consume quite some bandwidth, so use only for important 
			%% status and error messages. If implemented wisely, these messages are buffered 
			%% on the MCU and sent only at a limited rate (e.g. 10 Hz).
			p = encode_STATUSTEXT(S);

		case 255
			%% Send a debug value. The index is used to discriminate between values. These values 
			%% show up in the plot of QGroundControl as DEBUG N.
			p = encode_DEBUG(S);

		case 150
			%% Offsets and calibrations values for hardware         sensors. This makes it easier 
			%% to debug the calibration process.
			p = encode_SENSOR_OFFSETS(S);

		case 151
			%% set the magnetometer offsets
			p = encode_SET_MAG_OFFSETS(S);

		case 152
			%% state of APM memory
			p = encode_MEMINFO(S);

		case 153
			%% raw ADC output
			p = encode_AP_ADC(S);

		case 154
			%% Configure on-board Camera Control System.
			p = encode_DIGICAM_CONFIGURE(S);

		case 155
			%% Control on-board Camera Control System to take shots.
			p = encode_DIGICAM_CONTROL(S);

		case 156
			%% Message to configure a camera mount, directional antenna, etc.
			p = encode_MOUNT_CONFIGURE(S);

		case 157
			%% Message to control a camera mount, directional antenna, etc.
			p = encode_MOUNT_CONTROL(S);

		case 158
			%% Message with some status from APM to GCS about camera or antenna mount
			p = encode_MOUNT_STATUS(S);

		case 160
			%% A fence point. Used to set a point when from        GCS -> MAV. Also used to return 
			%% a point from MAV -> GCS
			p = encode_FENCE_POINT(S);

		case 161
			%% Request a current fence point from MAV
			p = encode_FENCE_FETCH_POINT(S);

		case 162
			%% Status of geo-fencing. Sent in extended      status stream when fencing enabled
			p = encode_FENCE_STATUS(S);

		otherwise
			disp(sprintf('Unknown Message: id[%d]',p.messid))
	end
return

