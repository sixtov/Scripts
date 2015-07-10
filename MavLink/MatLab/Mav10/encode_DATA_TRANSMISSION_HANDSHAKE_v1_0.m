%%  case: 130
function p = encode_DATA_TRANSMISSION_HANDSHAKE_v1_0(S)
	global pnum;
	if (isempty(pnum))
		pnum = 1;
	else
		pnum = uint8(mod(pnum+1,256));
	end
	head = uint8(254);
	len = uint8(13);
	sysid = uint8(S.h_sysid);
	id = uint8(S.h_id);
	messid = uint8(130);
	name = [ ...
		{'type'}		 ... %% type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)
		{'size'}		 ... %% total data size in bytes (set on ACK only)
		{'width'}		 ... %% Width of a matrix or image
		{'height'}		 ... %% Height of a matrix or image
		{'packets'}		 ... %% number of packets beeing sent (set on ACK only)
		{'payload'}		 ... %% payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)
		{'jpg_quality'}	 ... %% JPEG quality out of [1,100]
		];
	byte = [ 1 4 2 2 2 1 1 ];
	type = [ {'uint8'} {'uint32'} {'uint16'} {'uint16'} {'uint16'} {'uint8'} {'uint8'} ];

	p = [head len pnum sysid id messid];
	%% Encode type data field
	val = typecast(S.type,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode size data field
	val = typecast(S.size,'uint32');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode width data field
	val = typecast(S.width,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode height data field
	val = typecast(S.height,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode packets data field
	val = typecast(S.packets,'uint16');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode payload data field
	val = typecast(S.payload,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	%% Encode jpg_quality data field
	val = typecast(S.jpg_quality,'uint8');
	val = reshape(val,1,length(val));
	p = [p typecast(val,'uint8')];

	p = [p typecast(checksum_v1_0(p(2:end)'),'uint8')];
return
