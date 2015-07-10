%%%%  case: 1
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
function p = encodeValues_SYS_STATUS_v1_0(onboard_control_sensors_present,onboard_control_sensors_enabled,onboard_control_sensors_health,load,voltage_battery,current_battery,battery_remaining,drop_rate_comm,errors_comm,errors_count1,errors_count2,errors_count3,errors_count4)
	S.onboard_control_sensors_present = typecast(uint32(onboard_control_sensors_present),'uint32');		% Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
	S.onboard_control_sensors_enabled = typecast(uint32(onboard_control_sensors_enabled),'uint32');		% Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
	S.onboard_control_sensors_health = typecast(uint32(onboard_control_sensors_health),'uint32');		% Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
	S.load = typecast(uint16(load),'uint16');		% Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
	S.voltage_battery = typecast(uint16(voltage_battery),'uint16');		% Battery voltage, in millivolts (1 = 1 millivolt)
	S.current_battery = typecast(int16(current_battery),'int16');		% Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
	S.battery_remaining = typecast(int8(battery_remaining),'int8');		% Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot estimate the remaining battery
	S.drop_rate_comm = typecast(uint16(drop_rate_comm),'uint16');		% Communication drops in percent, (0%: 0, 100%: 10'000), (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
	S.errors_comm = typecast(uint16(errors_comm),'uint16');		% Communication errors (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
	S.errors_count1 = typecast(uint16(errors_count1),'uint16');		% Autopilot-specific errors
	S.errors_count2 = typecast(uint16(errors_count2),'uint16');		% Autopilot-specific errors
	S.errors_count3 = typecast(uint16(errors_count3),'uint16');		% Autopilot-specific errors
	S.errors_count4 = typecast(uint16(errors_count4),'uint16');		% Autopilot-specific errors
	p = encode_SYS_STATUS_v1_0(S);
return
