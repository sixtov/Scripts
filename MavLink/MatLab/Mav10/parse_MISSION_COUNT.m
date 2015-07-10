%%  case: 44
%%~ This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate 
%%~ a write transaction. The GCS can then request the individual mission item 
%%~ based on the knowledge of the total number of MISSIONs.
function S = parse_MISSION_COUNT(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'count'}			 ... %% Number of mission items in the sequence
		];
	byte = [ 1 1 2 ];
	type = [ {'uint8'} {'uint8'} {'uint16'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

