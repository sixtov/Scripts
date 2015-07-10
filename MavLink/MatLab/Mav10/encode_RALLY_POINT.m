%%  case: 175
%%~ A rally point. Used to set a point when from GCS -> MAV. Also used to return a point 
%%~ from MAV -> GCS
function p = encode_RALLY_POINT(S)
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

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode idx data field
	val = typecast(S.idx,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode count data field
	val = typecast(S.count,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lat data field
	val = typecast(S.lat,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode lng data field
	val = typecast(S.lng,'int32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode alt data field
	val = typecast(S.alt,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode break_alt data field
	val = typecast(S.break_alt,'int16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode land_dir data field
	val = typecast(S.land_dir,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode flags data field
	val = typecast(S.flags,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

return
