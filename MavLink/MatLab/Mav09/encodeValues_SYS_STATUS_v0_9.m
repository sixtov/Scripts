%%%%  case: 34
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
function p = encodeValues_SYS_STATUS_v0_9(mode,nav_mode,status,load,vbat,battery_remaining,packet_drop)
	S.mode = typecast(uint8(mode),'uint8');		% System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
	S.nav_mode = typecast(uint8(nav_mode),'uint8');		% Navigation mode, see MAV_NAV_MODE ENUM
	S.status = typecast(uint8(status),'uint8');		% System status flag, see MAV_STATUS ENUM
	S.load = typecast(uint16(load),'uint16');		% Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
	S.vbat = typecast(uint16(vbat),'uint16');		% Battery voltage, in millivolts (1 = 1 millivolt)
	S.battery_remaining = typecast(uint16(battery_remaining),'uint16');		% Remaining battery energy: (0%: 0, 100%: 1000)
	S.packet_drop = typecast(uint16(packet_drop),'uint16');		% Dropped packets (packets that were corrupted on reception on the MAV)
	p = encode_SYS_STATUS_v0_9(S);
return
