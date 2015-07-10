%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function p = encode_HEARTBEAT(S)
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

	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode autopilot data field
	val = typecast(S.autopilot,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode base_mode data field
	val = typecast(S.base_mode,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode custom_mode data field
	val = typecast(S.custom_mode,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode system_status data field
	val = typecast(S.system_status,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode mavlink_version data field
	val = typecast(S.mavlink_version,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
