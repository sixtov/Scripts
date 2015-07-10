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
function S = parse_SYS_STATUS_v0_9(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

