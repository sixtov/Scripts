%%  case: 175
%%~ A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
%%~ from MAV -> GCS
function S = parse_RALLY_POINT_v1_0(S,p)
	name = [ ...
		{'target_system'}	 ... %% System ID
		{'target_component'} ... %% Component ID
		{'idx'}				 ... %% point index (first point is 0)
		{'count'}			 ... %% total number of points (for sanity checking)
		{'lat'}				 ... %% Latitude of point in degrees * 1E7
		{'lng'}				 ... %% Longitude of point in degrees * 1E7
		{'alt'}				 ... %% Transit / loiter altitude in meters relative to home
		{'break_alt'}		 ... %% Break altitude in meters relative to home
		{'land_dir'}		 ... %% Heading to aim for when landing. In centi-degrees.
		{'flags'}			 ... %% See RALLY_FLAGS enum for definition of the bitmask.
		];
	byte = [ 1 1 1 1 4 4 2 2 2 1 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} {'int32'} {'int32'} {'int16'} {'int16'} {'uint16'} {'uint8'} ];
	if (sum(byte) == p.len)
		S = buildStruct(S,byte,name,type,p);
	else
		disp('bytes in packet did not match structure size')
	end
return

