%%%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function p = encodeValues_HEARTBEAT_v0_9(type,autopilot,mavlink_version,vehicleID,numWpts)
	S.type = typecast(uint8(type),'uint8');		% Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
	S.autopilot = typecast(uint8(autopilot),'uint8');		% Type of the Autopilot: 0: Generic, 1: PIXHAWK, 2: SLUGS, 3: Ardupilot (up to 15 types), defined in MAV_AUTOPILOT_TYPE ENUM
	S.mavlink_version = typecast(uint8(mavlink_version),'uint8');		% MAVLink version
	S.vehicleID = typecast(uint8(vehicleID),'uint8');		% Vehicle ID: 1: R1, 2: R2, 3: R3 (up to xx types), defined in "mydefines.h"
	S.numWpts = typecast(uint8(numWpts),'uint8');		% Number of Waypoints in Flight Plan
	p = encode_HEARTBEAT_v0_9(S);
return
