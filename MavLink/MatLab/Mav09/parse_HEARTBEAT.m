%%  case: 0
%%~ The heartbeat message shows that a system is present and responding. The type of 
%%~ the MAV and Autopilot hardware allow the receiving system to treat further messages 
%%~ from this system appropriate (e.g. by laying out the user interface based on 
%%~ the autopilot).
function S = parse_HEARTBEAT(S,p)
	name = [ ...
		{'type'}			 ... %% Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
		{'autopilot'}		 ... %% Type of the Autopilot: 0: Generic, 1: PIXHAWK, 2: SLUGS, 3: Ardupilot (up to 15 types), defined in MAV_AUTOPILOT_TYPE ENUM
		{'mavlink_version'}	 ... %% MAVLink version
		{'vehicleID'}		 ... %% Vehicle ID: 1: R1, 2: R2, 3: R3 (up to xx types), defined in "mydefines.h"
		{'numWpts'}			 ... %% Number of Waypoints in Flight Plan
		];
	byte = [ 1 1 1 1 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

