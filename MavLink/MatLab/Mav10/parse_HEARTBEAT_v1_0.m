%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function S = parse_HEARTBEAT_v1_0(p)
	name = [ ...
		{'type'}			 ... %% Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
		{'autopilot'}		 ... %% Autopilot type / class. defined in MAV_AUTOPILOT ENUM
		{'base_mode'}		 ... %% System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h
		{'custom_mode'}		 ... %% A bitfield for use for autopilot-specific flags.
		{'system_status'}	 ... %% System status flag, see MAV_STATE ENUM
		{'mavlink_version'}	 ... %% MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
		];
	byte = [ 1 1 1 4 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint32'} {'uint8'} {'uint8'} ];

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

