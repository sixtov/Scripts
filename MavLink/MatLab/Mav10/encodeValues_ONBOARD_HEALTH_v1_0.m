%%%%  case: 206
function p = encodeValues_ONBOARD_HEALTH_v1_0(uptime,cpu_freq,cpu_load,ram_usage,ram_total,swap_usage,swap_total,disk_health,disk_usage,disk_total,temp,voltage,network_load_in,network_load_out)
	S.uptime = typecast(uint32(uptime),'uint32');		% Uptime of system
	S.cpu_freq = typecast(uint16(cpu_freq),'uint16');		% CPU frequency
	S.cpu_load = typecast(uint8(cpu_load),'uint8');		% CPU load in percent
	S.ram_usage = typecast(uint8(ram_usage),'uint8');		% RAM usage in percent
	S.ram_total = typecast(single(ram_total),'single');		% RAM size in GiB
	S.swap_usage = typecast(uint8(swap_usage),'uint8');		% Swap usage in percent
	S.swap_total = typecast(single(swap_total),'single');		% Swap size in GiB
	S.disk_health = typecast(int8(disk_health),'int8');		% Disk health (-1: N/A, 0: ERR, 1: RO, 2: RW)
	S.disk_usage = typecast(uint8(disk_usage),'uint8');		% Disk usage in percent
	S.disk_total = typecast(single(disk_total),'single');		% Disk total in GiB
	S.temp = typecast(single(temp),'single');		% Temperature
	S.voltage = typecast(single(voltage),'single');		% Supply voltage V
	S.network_load_in = typecast(single(network_load_in),'single');		% Network load inbound KiB/s
	S.network_load_out = typecast(single(network_load_out),'single');		% Network load outbound in KiB/s 
	p = encode_ONBOARD_HEALTH_v1_0(S);
return
