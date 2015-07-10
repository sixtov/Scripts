%%  case: 130
function S = parse_DATA_TRANSMISSION_HANDSHAKE_v1_0(p)
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

	len = p(2);
	if (sum(byte) == len)
		S = buildStruct(byte,name,type,p);
	else
		S = [];
		disp('bytes in packet did not match structure size')
	end
return

