%%%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function p = encodeValues_HEARTBEAT_v1_0(type,autopilot,base_mode,custom_mode,system_status,mavlink_version)
	S.type = typecast(uint8(type),'uint8');		% Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
	S.autopilot = typecast(uint8(autopilot),'uint8');		% Autopilot type / class. defined in MAV_AUTOPILOT ENUM
	S.base_mode = typecast(uint8(base_mode),'uint8');		% System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h
	S.custom_mode = typecast(uint32(custom_mode),'uint32');		% A bitfield for use for autopilot-specific flags.
	S.system_status = typecast(uint8(system_status),'uint8');		% System status flag, see MAV_STATE ENUM
	S.mavlink_version = typecast(uint8(mavlink_version),'uint8');		% MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
	p = encode_HEARTBEAT_v1_0(S);
return
