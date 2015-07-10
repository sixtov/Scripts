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

