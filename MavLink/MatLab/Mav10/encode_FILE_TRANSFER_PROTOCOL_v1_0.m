%%  case: 110
%%~ File transfer message
function p = encode_FILE_TRANSFER_PROTOCOL_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(254);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(110);
	name = [ ...
		{'target_network'}	 ... %% Network ID (0 for broadcast)
		{'target_system'}	 ... %% System ID (0 for broadcast)
		{'target_component'} ... %% Component ID (0 for broadcast)
		{'payload'}			 ... %% Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
		];
	byte = [ 1 1 1 251 ];
	type = [ {'uint8'} {'uint8'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode target_network data field
	val = typecast(S.target_network,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_system data field
	val = typecast(S.target_system,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode target_component data field
	val = typecast(S.target_component,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode payload data field
	val = typecast(S.payload,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
