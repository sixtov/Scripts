    //                                                 {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
    public static readonly byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {  9, 31, 12,  0, 14,  4,  3,  1,  0,  0,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0,  5,  2, 10,  8, 30,  6, 22, 26, 16, 14, 28, 32, 28, 28, 22, 22, 21,  6,  6, 37,  4,  4,  2,  2,  4,  2,  2,  3, 13, 12, 22,  0,  0,  0, 27, 25,  0,  0,  0,  0,  0, 24, 26, 45, 41, 42,  6,  4,  0, 11, 18,  0,  0, 37, 20, 35, 33,  3,  0,  0,  0, 22, 27, 25, 53, 51, 53, 51,  0, 28, 56, 42, 33,  0,  0,  0,  0,  0,  0,  0, 26, 32, 32, 20, 32, 62, 44, 64, 84,  9,  4, 16,  0, 36, 44, 52, 22,  6, 14, 12,  8,  2,  2,  4, 35,  6, 10, 35, 35, 22, 13,  3, 14, 18, 13,  8, 22, 14, 24, 15, 13,  0,  0,  0,  0,  0,  0, 18, 39,  0,  0, 11, 52,  1, 92,  0,  0,  0,  0,  0, 18,  0,  0,  0,  0,  0,  0,  0,  0,  0, 18, 26, 16,  0,  0,  0,  0,  0,  0,  0,  4, 10, 12,  6,  0,  0,  0,  0,  0,  0,  7, 18, 30,  0,  0, 22,  0,  0,  0,  0, 21,  0,  0,  0,  0, 48, 39,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  6,  5, 21,  9,  9,  2,  9,  0};
	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_heartbeat_t
	{
		public byte type; /// Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
		public byte autopilot; /// Autopilot type / class. defined in MAV_AUTOPILOT ENUM
		public byte base_mode; /// System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h
		public uint custom_mode; /// A bitfield for use for autopilot-specific flags.
		public byte system_status; /// System status flag, see MAV_STATE ENUM
		public byte mavlink_version; /// MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=31)]
	public struct mavlink_sys_status_t
	{
		public uint onboard_control_sensors_present; /// Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		public uint onboard_control_sensors_enabled; /// Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		public uint onboard_control_sensors_health; /// Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
		public ushort load; /// Maximum usage in percent of the mainloop time, (0%%: 0, 100%%: 1000) should be always below 1000
		public ushort voltage_battery; /// Battery voltage, in millivolts (1 = 1 millivolt)
		public short current_battery; /// Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		public byte battery_remaining; /// Remaining battery energy: (0%%: 0, 100%%: 100), -1: autopilot estimate the remaining battery
		public ushort drop_rate_comm; /// Communication drops in percent, (0%%: 0, 100%%: 10'000), (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
		public ushort errors_comm; /// Communication errors (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV)
		public ushort errors_count1; /// Autopilot-specific errors
		public ushort errors_count2; /// Autopilot-specific errors
		public ushort errors_count3; /// Autopilot-specific errors
		public ushort errors_count4; /// Autopilot-specific errors
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_system_time_t
	{
		public ulong time_unix_usec; /// Timestamp of the master clock in microseconds since UNIX epoch.
		public uint time_boot_ms; /// Timestamp of the component clock since boot time in milliseconds.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_ping_t
	{
		public ulong time_usec; /// Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009)
		public uint seq; /// PING sequence
		public byte target_system; /// 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
		public byte target_component; /// 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_change_operator_control_t
	{
		public byte target_system; /// System the GCS requests control for
		public byte control_request; /// 0: request control of this MAV, 1: Release control of this MAV
		public byte version; /// 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=25)]
		public byte[] passkey; /// Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_change_operator_control_ack_t
	{
		public byte gcs_system_id; /// ID of the GCS this message 
		public byte control_request; /// 0: request control of this MAV, 1: Release control of this MAV
		public byte ack; /// 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=1)]
	public struct mavlink_auth_key_t
	{
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=32)]
		public byte[] key; /// key
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_set_mode_t
	{
		public byte target_system; /// The system setting the mode
		public byte base_mode; /// The new base mode
		public uint custom_mode; /// The new autopilot-specific mode. This field can be ignored by an autopilot.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=5)]
	public struct mavlink_param_request_read_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public byte[] param_id; /// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		public short param_index; /// Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_param_request_list_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=10)]
	public struct mavlink_param_value_t
	{
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public byte[] param_id; /// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		public float param_value; /// Onboard parameter value
		public byte param_type; /// Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
		public ushort param_count; /// Total number of onboard parameters
		public ushort param_index; /// Index of this onboard parameter
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_param_set_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public byte[] param_id; /// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		public float param_value; /// Onboard parameter value
		public byte param_type; /// Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=30)]
	public struct mavlink_gps_raw_int_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public byte fix_type; /// 0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS, 5: RTK. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		public int lat; /// Latitude (WGS84), in degrees * 1E7
		public int lon; /// Longitude (WGS84), in degrees * 1E7
		public int alt; /// Altitude (AMSL, NOT WGS84), in meters * 1000 (positive for up). Note that virtually all GPS modules provide the AMSL altitude in addition to the WGS84 altitude.
		public ushort eph; /// GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		public ushort epv; /// GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		public ushort vel; /// GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
		public ushort cog; /// Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		public byte satellites_visible; /// Number of satellites visible. If unknown, set to 255
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_gps_status_t
	{
		public byte satellites_visible; /// Number of satellites visible
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=20)]
		public byte[] satellite_prn; /// Global satellite ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=20)]
		public byte[] satellite_used; /// 0: Satellite not used, 1: used for localization
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=20)]
		public byte[] satellite_elevation; /// Elevation (0: right on top of receiver, 90: on the horizon) of satellite
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=20)]
		public byte[] satellite_azimuth; /// Direction of satellite, 0: 0 deg, 255: 360 deg.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=20)]
		public byte[] satellite_snr; /// Signal to noise ratio of satellite
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_scaled_imu_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public short xacc; /// X acceleration (mg)
		public short yacc; /// Y acceleration (mg)
		public short zacc; /// Z acceleration (mg)
		public short xgyro; /// Angular speed around X axis (millirad /sec)
		public short ygyro; /// Angular speed around Y axis (millirad /sec)
		public short zgyro; /// Angular speed around Z axis (millirad /sec)
		public short xmag; /// X Magnetic field (milli tesla)
		public short ymag; /// Y Magnetic field (milli tesla)
		public short zmag; /// Z Magnetic field (milli tesla)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=26)]
	public struct mavlink_raw_imu_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public short xacc; /// X acceleration (raw)
		public short yacc; /// Y acceleration (raw)
		public short zacc; /// Z acceleration (raw)
		public short xgyro; /// Angular speed around X axis (raw)
		public short ygyro; /// Angular speed around Y axis (raw)
		public short zgyro; /// Angular speed around Z axis (raw)
		public short xmag; /// X Magnetic field (raw)
		public short ymag; /// Y Magnetic field (raw)
		public short zmag; /// Z Magnetic field (raw)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=16)]
	public struct mavlink_raw_pressure_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public short press_abs; /// Absolute pressure (raw)
		public short press_diff1; /// Differential pressure 1 (raw)
		public short press_diff2; /// Differential pressure 2 (raw)
		public short temperature; /// Raw Temperature measurement (raw)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_scaled_pressure_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float press_abs; /// Absolute pressure (hectopascal)
		public float press_diff; /// Differential pressure 1 (hectopascal)
		public short temperature; /// Temperature measurement (0.01 degrees celsius)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=28)]
	public struct mavlink_attitude_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float roll; /// Roll angle (rad, -pi..+pi)
		public float pitch; /// Pitch angle (rad, -pi..+pi)
		public float yaw; /// Yaw angle (rad, -pi..+pi)
		public float rollspeed; /// Roll angular speed (rad/s)
		public float pitchspeed; /// Pitch angular speed (rad/s)
		public float yawspeed; /// Yaw angular speed (rad/s)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=32)]
	public struct mavlink_attitude_quaternion_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float q1; /// Quaternion component 1, w (1 in null-rotation)
		public float q2; /// Quaternion component 2, x (0 in null-rotation)
		public float q3; /// Quaternion component 3, y (0 in null-rotation)
		public float q4; /// Quaternion component 4, z (0 in null-rotation)
		public float rollspeed; /// Roll angular speed (rad/s)
		public float pitchspeed; /// Pitch angular speed (rad/s)
		public float yawspeed; /// Yaw angular speed (rad/s)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=28)]
	public struct mavlink_local_position_ned_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float x; /// X Position
		public float y; /// Y Position
		public float z; /// Z Position
		public float vx; /// X Speed
		public float vy; /// Y Speed
		public float vz; /// Z Speed
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=28)]
	public struct mavlink_global_position_int_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public int lat; /// Latitude, expressed as * 1E7
		public int lon; /// Longitude, expressed as * 1E7
		public int alt; /// Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
		public int relative_alt; /// Altitude above ground in meters, expressed as * 1000 (millimeters)
		public short vx; /// Ground X Speed (Latitude), expressed as m/s * 100
		public short vy; /// Ground Y Speed (Longitude), expressed as m/s * 100
		public short vz; /// Ground Z Speed (Altitude), expressed as m/s * 100
		public ushort hdg; /// Compass heading in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_rc_channels_scaled_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public byte port; /// Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		public short chan1_scaled; /// RC channel 1 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan2_scaled; /// RC channel 2 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan3_scaled; /// RC channel 3 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan4_scaled; /// RC channel 4 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan5_scaled; /// RC channel 5 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan6_scaled; /// RC channel 6 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan7_scaled; /// RC channel 7 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public short chan8_scaled; /// RC channel 8 value scaled, (-100%%) -10000, (0%%) 0, (100%%) 10000, (invalid) INT16_MAX.
		public byte rssi; /// Receive signal strength indicator, 0: 0%%, 100: 100%%, 255: invalid/unknown.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_rc_channels_raw_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public byte port; /// Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows for more than 8 servos.
		public ushort chan1_raw; /// RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan2_raw; /// RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan3_raw; /// RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan4_raw; /// RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan5_raw; /// RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan6_raw; /// RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan7_raw; /// RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan8_raw; /// RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public byte rssi; /// Receive signal strength indicator, 0: 0%%, 100: 100%%, 255: invalid/unknown.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=21)]
	public struct mavlink_servo_output_raw_t
	{
		public uint time_usec; /// Timestamp (microseconds since system boot)
		public byte port; /// Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows to encode more than 8 servos.
		public ushort servo1_raw; /// Servo output 1 value, in microseconds
		public ushort servo2_raw; /// Servo output 2 value, in microseconds
		public ushort servo3_raw; /// Servo output 3 value, in microseconds
		public ushort servo4_raw; /// Servo output 4 value, in microseconds
		public ushort servo5_raw; /// Servo output 5 value, in microseconds
		public ushort servo6_raw; /// Servo output 6 value, in microseconds
		public ushort servo7_raw; /// Servo output 7 value, in microseconds
		public ushort servo8_raw; /// Servo output 8 value, in microseconds
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_mission_request_partial_list_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public short start_index; /// Start index, 0 by default
		public short end_index; /// End index, -1 by default (-1: send list to end). Else a valid index of the list
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_mission_write_partial_list_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public short start_index; /// Start index, 0 by default and smaller / equal to the largest index of the current onboard list.
		public short end_index; /// End index, equal or greater than start index.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=37)]
	public struct mavlink_mission_item_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort seq; /// Sequence
		public byte frame; /// The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
		public ushort command; /// The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
		public byte current; /// false:0, true:1
		public byte autocontinue; /// autocontinue to next wp
		public float param1; /// PARAM1, see MAV_CMD enum
		public float param2; /// PARAM2, see MAV_CMD enum
		public float param3; /// PARAM3, see MAV_CMD enum
		public float param4; /// PARAM4, see MAV_CMD enum
		public float x; /// PARAM5 / local: x position, global: latitude
		public float y; /// PARAM6 / y position: global: longitude
		public float z; /// PARAM7 / z position: global: altitude (relative or absolute, depending on frame.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_mission_request_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort seq; /// Sequence
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_mission_set_current_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort seq; /// Sequence
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_mission_current_t
	{
		public ushort seq; /// Sequence
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_mission_request_list_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_mission_count_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort count; /// Number of mission items in the sequence
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_mission_clear_all_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_mission_item_reached_t
	{
		public ushort seq; /// Sequence
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_mission_ack_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte type; /// See MAV_MISSION_RESULT enum
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_set_gps_global_origin_t
	{
		public byte target_system; /// System ID
		public int latitude; /// Latitude (WGS84), in degrees * 1E7
		public int longitude; /// Longitude (WGS84, in degrees * 1E7
		public int altitude; /// Altitude (AMSL), in meters * 1000 (positive for up)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_gps_global_origin_t
	{
		public int latitude; /// Latitude (WGS84), in degrees * 1E7
		public int longitude; /// Longitude (WGS84), in degrees * 1E7
		public int altitude; /// Altitude (AMSL), in meters * 1000 (positive for up)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_param_map_rc_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public byte[] param_id; /// Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
		public short param_index; /// Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.
		public byte parameter_rc_channel_index; /// Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.
		public float param_value0; /// Initial parameter value
		public float scale; /// Scale, maps the RC range [-1, 1] to a parameter value
		public float param_value_min; /// Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)
		public float param_value_max; /// Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=27)]
	public struct mavlink_safety_set_allowed_area_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte frame; /// Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		public float p1x; /// x position 1 / Latitude 1
		public float p1y; /// y position 1 / Longitude 1
		public float p1z; /// z position 1 / Altitude 1
		public float p2x; /// x position 2 / Latitude 2
		public float p2y; /// y position 2 / Longitude 2
		public float p2z; /// z position 2 / Altitude 2
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=25)]
	public struct mavlink_safety_allowed_area_t
	{
		public byte frame; /// Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
		public float p1x; /// x position 1 / Latitude 1
		public float p1y; /// y position 1 / Longitude 1
		public float p1z; /// z position 1 / Altitude 1
		public float p2x; /// x position 2 / Latitude 2
		public float p2y; /// y position 2 / Longitude 2
		public float p2z; /// z position 2 / Altitude 2
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=24)]
	public struct mavlink_attitude_quaternion_cov_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] q; /// Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation)
		public float rollspeed; /// Roll angular speed (rad/s)
		public float pitchspeed; /// Pitch angular speed (rad/s)
		public float yawspeed; /// Yaw angular speed (rad/s)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=9)]
		public float[] covariance; /// Attitude covariance
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=26)]
	public struct mavlink_nav_controller_output_t
	{
		public float nav_roll; /// Current desired roll in degrees
		public float nav_pitch; /// Current desired pitch in degrees
		public short nav_bearing; /// Current desired heading in degrees
		public short target_bearing; /// Bearing to current MISSION/target in degrees
		public ushort wp_dist; /// Distance to active MISSION in meters
		public float alt_error; /// Current altitude error in meters
		public float aspd_error; /// Current airspeed error in meters/second
		public float xtrack_error; /// Current crosstrack error on x-y plane in meters
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=45)]
	public struct mavlink_global_position_int_cov_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public ulong time_utc; /// Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		public byte estimator_type; /// Class id of the estimator this estimate originated from.
		public int lat; /// Latitude, expressed as degrees * 1E7
		public int lon; /// Longitude, expressed as degrees * 1E7
		public int alt; /// Altitude in meters, expressed as * 1000 (millimeters), above MSL
		public int relative_alt; /// Altitude above ground in meters, expressed as * 1000 (millimeters)
		public float vx; /// Ground X Speed (Latitude), expressed as m/s
		public float vy; /// Ground Y Speed (Longitude), expressed as m/s
		public float vz; /// Ground Z Speed (Altitude), expressed as m/s
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=36)]
		public float[] covariance; /// Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=41)]
	public struct mavlink_local_position_ned_cov_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public ulong time_utc; /// Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. Commonly filled by the precision time source of a GPS receiver.
		public byte estimator_type; /// Class id of the estimator this estimate originated from.
		public float x; /// X Position
		public float y; /// Y Position
		public float z; /// Z Position
		public float vx; /// X Speed
		public float vy; /// Y Speed
		public float vz; /// Z Speed
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=36)]
		public float[] covariance; /// Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=42)]
	public struct mavlink_rc_channels_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public byte chancount; /// Total number of RC channels being received. This can be larger than 18, indicating that more channels are available but not given in this message. This value should be 0 when no RC channels are available.
		public ushort chan1_raw; /// RC channel 1 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan2_raw; /// RC channel 2 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan3_raw; /// RC channel 3 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan4_raw; /// RC channel 4 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan5_raw; /// RC channel 5 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan6_raw; /// RC channel 6 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan7_raw; /// RC channel 7 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan8_raw; /// RC channel 8 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan9_raw; /// RC channel 9 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan10_raw; /// RC channel 10 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan11_raw; /// RC channel 11 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan12_raw; /// RC channel 12 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan13_raw; /// RC channel 13 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan14_raw; /// RC channel 14 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan15_raw; /// RC channel 15 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan16_raw; /// RC channel 16 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan17_raw; /// RC channel 17 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public ushort chan18_raw; /// RC channel 18 value, in microseconds. A value of UINT16_MAX implies the channel is unused.
		public byte rssi; /// Receive signal strength indicator, 0: 0%%, 100: 100%%, 255: invalid/unknown.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_request_data_stream_t
	{
		public byte target_system; /// The target requested to send the message stream.
		public byte target_component; /// The target requested to send the message stream.
		public byte req_stream_id; /// The ID of the requested data stream
		public ushort req_message_rate; /// The requested interval between two messages of this type
		public byte start_stop; /// 1 to start sending, 0 to stop sending.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_data_stream_t
	{
		public byte stream_id; /// The ID of the requested data stream
		public ushort message_rate; /// The requested interval between two messages of this type
		public byte on_off; /// 1 stream is enabled, 0 stream is stopped.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=11)]
	public struct mavlink_manual_control_t
	{
		public byte target; /// The system to be controlled.
		public short x; /// X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
		public short y; /// Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
		public short z; /// Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle.
		public short r; /// R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
		public ushort buttons; /// A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_rc_channels_override_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort chan1_raw; /// RC channel 1 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan2_raw; /// RC channel 2 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan3_raw; /// RC channel 3 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan4_raw; /// RC channel 4 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan5_raw; /// RC channel 5 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan6_raw; /// RC channel 6 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan7_raw; /// RC channel 7 value, in microseconds. A value of UINT16_MAX means to ignore this field.
		public ushort chan8_raw; /// RC channel 8 value, in microseconds. A value of UINT16_MAX means to ignore this field.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=37)]
	public struct mavlink_mission_item_int_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort seq; /// Waypoint ID (sequence number). Starts at zero. Increases monotonically for each waypoint, no gaps in the sequence (0,1,2,3,4).
		public byte frame; /// The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
		public ushort command; /// The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
		public byte current; /// false:0, true:1
		public byte autocontinue; /// autocontinue to next wp
		public float param1; /// PARAM1, see MAV_CMD enum
		public float param2; /// PARAM2, see MAV_CMD enum
		public float param3; /// PARAM3, see MAV_CMD enum
		public float param4; /// PARAM4, see MAV_CMD enum
		public int x; /// PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
		public int y; /// PARAM6 / y position: local: x position in meters * 1e4, global: longitude in degrees *10^7
		public float z; /// PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=20)]
	public struct mavlink_vfr_hud_t
	{
		public float airspeed; /// Current airspeed in m/s
		public float groundspeed; /// Current ground speed in m/s
		public short heading; /// Current heading in degrees, in compass units (0..360, 0=north)
		public ushort throttle; /// Current throttle setting in integer percent, 0 to 100
		public float alt; /// Current altitude (MSL), in meters
		public float climb; /// Current climb rate in meters/second
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=35)]
	public struct mavlink_command_int_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte frame; /// The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h
		public ushort command; /// The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs
		public byte current; /// false:0, true:1
		public byte autocontinue; /// autocontinue to next wp
		public float param1; /// PARAM1, see MAV_CMD enum
		public float param2; /// PARAM2, see MAV_CMD enum
		public float param3; /// PARAM3, see MAV_CMD enum
		public float param4; /// PARAM4, see MAV_CMD enum
		public int x; /// PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
		public int y; /// PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7
		public float z; /// PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=33)]
	public struct mavlink_command_long_t
	{
		public byte target_system; /// System which should execute the command
		public byte target_component; /// Component which should execute the command, 0 for all components
		public ushort command; /// Command ID, as defined by MAV_CMD enum.
		public byte confirmation; /// 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
		public float param1; /// Parameter 1, as defined by MAV_CMD enum.
		public float param2; /// Parameter 2, as defined by MAV_CMD enum.
		public float param3; /// Parameter 3, as defined by MAV_CMD enum.
		public float param4; /// Parameter 4, as defined by MAV_CMD enum.
		public float param5; /// Parameter 5, as defined by MAV_CMD enum.
		public float param6; /// Parameter 6, as defined by MAV_CMD enum.
		public float param7; /// Parameter 7, as defined by MAV_CMD enum.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_command_ack_t
	{
		public ushort command; /// Command ID, as defined by MAV_CMD enum.
		public byte result; /// See MAV_RESULT enum
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_manual_setpoint_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public float roll; /// Desired roll rate in radians per second
		public float pitch; /// Desired pitch rate in radians per second
		public float yaw; /// Desired yaw rate in radians per second
		public float thrust; /// Collective thrust, normalized to 0 .. 1
		public byte mode_switch; /// Flight mode switch position, 0.. 255
		public byte manual_override_switch; /// Override mode switch position, 0.. 255
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=27)]
	public struct mavlink_set_attitude_target_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte type_mask; /// Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] q; /// Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		public float body_roll_rate; /// Body roll rate in radians per second
		public float body_pitch_rate; /// Body roll rate in radians per second
		public float body_yaw_rate; /// Body roll rate in radians per second
		public float thrust; /// Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=25)]
	public struct mavlink_attitude_target_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public byte type_mask; /// Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 7: reserved, bit 8: attitude
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] q; /// Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		public float body_roll_rate; /// Body roll rate in radians per second
		public float body_pitch_rate; /// Body roll rate in radians per second
		public float body_yaw_rate; /// Body roll rate in radians per second
		public float thrust; /// Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=53)]
	public struct mavlink_set_position_target_local_ned_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte coordinate_frame; /// Valid options are: MAV_FRAME_LOCAL_NED = 1, MAV_FRAME_LOCAL_OFFSET_NED = 7, MAV_FRAME_BODY_NED = 8, MAV_FRAME_BODY_OFFSET_NED = 9
		public ushort type_mask; /// Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		public float x; /// X Position in NED frame in meters
		public float y; /// Y Position in NED frame in meters
		public float z; /// Z Position in NED frame in meters (note, altitude is negative in NED)
		public float vx; /// X velocity in NED frame in meter / s
		public float vy; /// Y velocity in NED frame in meter / s
		public float vz; /// Z velocity in NED frame in meter / s
		public float afx; /// X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afy; /// Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afz; /// Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float yaw; /// yaw setpoint in rad
		public float yaw_rate; /// yaw rate setpoint in rad/s
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=51)]
	public struct mavlink_position_target_local_ned_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public byte coordinate_frame; /// Valid options are: MAV_FRAME_LOCAL_NED = 1, MAV_FRAME_LOCAL_OFFSET_NED = 7, MAV_FRAME_BODY_NED = 8, MAV_FRAME_BODY_OFFSET_NED = 9
		public ushort type_mask; /// Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		public float x; /// X Position in NED frame in meters
		public float y; /// Y Position in NED frame in meters
		public float z; /// Z Position in NED frame in meters (note, altitude is negative in NED)
		public float vx; /// X velocity in NED frame in meter / s
		public float vy; /// Y velocity in NED frame in meter / s
		public float vz; /// Z velocity in NED frame in meter / s
		public float afx; /// X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afy; /// Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afz; /// Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float yaw; /// yaw setpoint in rad
		public float yaw_rate; /// yaw rate setpoint in rad/s
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=53)]
	public struct mavlink_set_position_target_global_int_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte coordinate_frame; /// Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
		public ushort type_mask; /// Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		public int lat_int; /// X Position in WGS84 frame in 1e7 * meters
		public int lon_int; /// Y Position in WGS84 frame in 1e7 * meters
		public float alt; /// Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT
		public float vx; /// X velocity in NED frame in meter / s
		public float vy; /// Y velocity in NED frame in meter / s
		public float vz; /// Z velocity in NED frame in meter / s
		public float afx; /// X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afy; /// Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afz; /// Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float yaw; /// yaw setpoint in rad
		public float yaw_rate; /// yaw rate setpoint in rad/s
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=51)]
	public struct mavlink_position_target_global_int_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency.
		public byte coordinate_frame; /// Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11
		public ushort type_mask; /// Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate
		public int lat_int; /// X Position in WGS84 frame in 1e7 * meters
		public int lon_int; /// Y Position in WGS84 frame in 1e7 * meters
		public float alt; /// Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT
		public float vx; /// X velocity in NED frame in meter / s
		public float vy; /// Y velocity in NED frame in meter / s
		public float vz; /// Z velocity in NED frame in meter / s
		public float afx; /// X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afy; /// Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float afz; /// Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N
		public float yaw; /// yaw setpoint in rad
		public float yaw_rate; /// yaw rate setpoint in rad/s
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=28)]
	public struct mavlink_local_position_ned_system_global_offset_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float x; /// X Position
		public float y; /// Y Position
		public float z; /// Z Position
		public float roll; /// Roll
		public float pitch; /// Pitch
		public float yaw; /// Yaw
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=56)]
	public struct mavlink_hil_state_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public float roll; /// Roll angle (rad)
		public float pitch; /// Pitch angle (rad)
		public float yaw; /// Yaw angle (rad)
		public float rollspeed; /// Body frame roll / phi angular speed (rad/s)
		public float pitchspeed; /// Body frame pitch / theta angular speed (rad/s)
		public float yawspeed; /// Body frame yaw / psi angular speed (rad/s)
		public int lat; /// Latitude, expressed as * 1E7
		public int lon; /// Longitude, expressed as * 1E7
		public int alt; /// Altitude in meters, expressed as * 1000 (millimeters)
		public short vx; /// Ground X Speed (Latitude), expressed as m/s * 100
		public short vy; /// Ground Y Speed (Longitude), expressed as m/s * 100
		public short vz; /// Ground Z Speed (Altitude), expressed as m/s * 100
		public short xacc; /// X acceleration (mg)
		public short yacc; /// Y acceleration (mg)
		public short zacc; /// Z acceleration (mg)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=42)]
	public struct mavlink_hil_controls_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public float roll_ailerons; /// Control output -1 .. 1
		public float pitch_elevator; /// Control output -1 .. 1
		public float yaw_rudder; /// Control output -1 .. 1
		public float throttle; /// Throttle 0 .. 1
		public float aux1; /// Aux 1, -1 .. 1
		public float aux2; /// Aux 2, -1 .. 1
		public float aux3; /// Aux 3, -1 .. 1
		public float aux4; /// Aux 4, -1 .. 1
		public byte mode; /// System mode (MAV_MODE)
		public byte nav_mode; /// Navigation mode (MAV_NAV_MODE)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=33)]
	public struct mavlink_hil_rc_inputs_raw_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public ushort chan1_raw; /// RC channel 1 value, in microseconds
		public ushort chan2_raw; /// RC channel 2 value, in microseconds
		public ushort chan3_raw; /// RC channel 3 value, in microseconds
		public ushort chan4_raw; /// RC channel 4 value, in microseconds
		public ushort chan5_raw; /// RC channel 5 value, in microseconds
		public ushort chan6_raw; /// RC channel 6 value, in microseconds
		public ushort chan7_raw; /// RC channel 7 value, in microseconds
		public ushort chan8_raw; /// RC channel 8 value, in microseconds
		public ushort chan9_raw; /// RC channel 9 value, in microseconds
		public ushort chan10_raw; /// RC channel 10 value, in microseconds
		public ushort chan11_raw; /// RC channel 11 value, in microseconds
		public ushort chan12_raw; /// RC channel 12 value, in microseconds
		public byte rssi; /// Receive signal strength indicator, 0: 0%%, 255: 100%%
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=26)]
	public struct mavlink_optical_flow_t
	{
		public ulong time_usec; /// Timestamp (UNIX)
		public byte sensor_id; /// Sensor ID
		public short flow_x; /// Flow in pixels * 10 in x-sensor direction (dezi-pixels)
		public short flow_y; /// Flow in pixels * 10 in y-sensor direction (dezi-pixels)
		public float flow_comp_m_x; /// Flow in meters in x-sensor direction, angular-speed compensated
		public float flow_comp_m_y; /// Flow in meters in y-sensor direction, angular-speed compensated
		public byte quality; /// Optical flow quality / confidence. 0: bad, 255: maximum quality
		public float ground_distance; /// Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=32)]
	public struct mavlink_global_vision_position_estimate_t
	{
		public ulong usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float x; /// Global X position
		public float y; /// Global Y position
		public float z; /// Global Z position
		public float roll; /// Roll angle in rad
		public float pitch; /// Pitch angle in rad
		public float yaw; /// Yaw angle in rad
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=32)]
	public struct mavlink_vision_position_estimate_t
	{
		public ulong usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float x; /// Global X position
		public float y; /// Global Y position
		public float z; /// Global Z position
		public float roll; /// Roll angle in rad
		public float pitch; /// Pitch angle in rad
		public float yaw; /// Yaw angle in rad
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=20)]
	public struct mavlink_vision_speed_estimate_t
	{
		public ulong usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float x; /// Global X speed
		public float y; /// Global Y speed
		public float z; /// Global Z speed
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=32)]
	public struct mavlink_vicon_position_estimate_t
	{
		public ulong usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float x; /// Global X position
		public float y; /// Global Y position
		public float z; /// Global Z position
		public float roll; /// Roll angle in rad
		public float pitch; /// Pitch angle in rad
		public float yaw; /// Yaw angle in rad
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=62)]
	public struct mavlink_highres_imu_t
	{
		public ulong time_usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float xacc; /// X acceleration (m/s^2)
		public float yacc; /// Y acceleration (m/s^2)
		public float zacc; /// Z acceleration (m/s^2)
		public float xgyro; /// Angular speed around X axis (rad / sec)
		public float ygyro; /// Angular speed around Y axis (rad / sec)
		public float zgyro; /// Angular speed around Z axis (rad / sec)
		public float xmag; /// X Magnetic field (Gauss)
		public float ymag; /// Y Magnetic field (Gauss)
		public float zmag; /// Z Magnetic field (Gauss)
		public float abs_pressure; /// Absolute pressure in millibar
		public float diff_pressure; /// Differential pressure in millibar
		public float pressure_alt; /// Altitude calculated from pressure
		public float temperature; /// Temperature in degrees celsius
		public ushort fields_updated; /// Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=44)]
	public struct mavlink_optical_flow_rad_t
	{
		public ulong time_usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public byte sensor_id; /// Sensor ID
		public uint integration_time_us; /// Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.
		public float integrated_x; /// Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)
		public float integrated_y; /// Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)
		public float integrated_xgyro; /// RH rotation around X axis (rad)
		public float integrated_ygyro; /// RH rotation around Y axis (rad)
		public float integrated_zgyro; /// RH rotation around Z axis (rad)
		public short temperature; /// Temperature * 100 in centi-degrees Celsius
		public byte quality; /// Optical flow quality / confidence. 0: no valid flow, 255: maximum quality
		public uint time_delta_distance_us; /// Time in microseconds since the distance was sampled.
		public float distance; /// Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=64)]
	public struct mavlink_hil_sensor_t
	{
		public ulong time_usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public float xacc; /// X acceleration (m/s^2)
		public float yacc; /// Y acceleration (m/s^2)
		public float zacc; /// Z acceleration (m/s^2)
		public float xgyro; /// Angular speed around X axis in body frame (rad / sec)
		public float ygyro; /// Angular speed around Y axis in body frame (rad / sec)
		public float zgyro; /// Angular speed around Z axis in body frame (rad / sec)
		public float xmag; /// X Magnetic field (Gauss)
		public float ymag; /// Y Magnetic field (Gauss)
		public float zmag; /// Z Magnetic field (Gauss)
		public float abs_pressure; /// Absolute pressure in millibar
		public float diff_pressure; /// Differential pressure (airspeed) in millibar
		public float pressure_alt; /// Altitude calculated from pressure
		public float temperature; /// Temperature in degrees celsius
		public uint fields_updated; /// Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=84)]
	public struct mavlink_sim_state_t
	{
		public float q1; /// True attitude quaternion component 1, w (1 in null-rotation)
		public float q2; /// True attitude quaternion component 2, x (0 in null-rotation)
		public float q3; /// True attitude quaternion component 3, y (0 in null-rotation)
		public float q4; /// True attitude quaternion component 4, z (0 in null-rotation)
		public float roll; /// Attitude roll expressed as Euler angles, not recommended except for human-readable outputs
		public float pitch; /// Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs
		public float yaw; /// Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs
		public float xacc; /// X acceleration m/s/s
		public float yacc; /// Y acceleration m/s/s
		public float zacc; /// Z acceleration m/s/s
		public float xgyro; /// Angular speed around X axis rad/s
		public float ygyro; /// Angular speed around Y axis rad/s
		public float zgyro; /// Angular speed around Z axis rad/s
		public float lat; /// Latitude in degrees
		public float lon; /// Longitude in degrees
		public float alt; /// Altitude in meters
		public float std_dev_horz; /// Horizontal position standard deviation
		public float std_dev_vert; /// Vertical position standard deviation
		public float vn; /// True velocity in m/s in NORTH direction in earth-fixed NED frame
		public float ve; /// True velocity in m/s in EAST direction in earth-fixed NED frame
		public float vd; /// True velocity in m/s in DOWN direction in earth-fixed NED frame
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_radio_status_t
	{
		public byte rssi; /// Local signal strength
		public byte remrssi; /// Remote signal strength
		public byte txbuf; /// Remaining free buffer space in percent.
		public byte noise; /// Background noise level
		public byte remnoise; /// Remote background noise level
		public ushort rxerrors; /// Receive errors
		public ushort fixed; /// Count of error corrected packets
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_file_transfer_protocol_t
	{
		public byte target_network; /// Network ID (0 for broadcast)
		public byte target_system; /// System ID (0 for broadcast)
		public byte target_component; /// Component ID (0 for broadcast)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=251)]
		public byte[] payload; /// Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=16)]
	public struct mavlink_timesync_t
	{
		public long tc1; /// Time sync timestamp 1
		public long ts1; /// Time sync timestamp 2
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=36)]
	public struct mavlink_hil_gps_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public byte fix_type; /// 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		public int lat; /// Latitude (WGS84), in degrees * 1E7
		public int lon; /// Longitude (WGS84), in degrees * 1E7
		public int alt; /// Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
		public ushort eph; /// GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: 65535
		public ushort epv; /// GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: 65535
		public ushort vel; /// GPS ground speed (m/s * 100). If unknown, set to: 65535
		public short vn; /// GPS velocity in cm/s in NORTH direction in earth-fixed NED frame
		public short ve; /// GPS velocity in cm/s in EAST direction in earth-fixed NED frame
		public short vd; /// GPS velocity in cm/s in DOWN direction in earth-fixed NED frame
		public ushort cog; /// Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: 65535
		public byte satellites_visible; /// Number of satellites visible. If unknown, set to 255
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=44)]
	public struct mavlink_hil_optical_flow_t
	{
		public ulong time_usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public byte sensor_id; /// Sensor ID
		public uint integration_time_us; /// Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.
		public float integrated_x; /// Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)
		public float integrated_y; /// Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)
		public float integrated_xgyro; /// RH rotation around X axis (rad)
		public float integrated_ygyro; /// RH rotation around Y axis (rad)
		public float integrated_zgyro; /// RH rotation around Z axis (rad)
		public short temperature; /// Temperature * 100 in centi-degrees Celsius
		public byte quality; /// Optical flow quality / confidence. 0: no valid flow, 255: maximum quality
		public uint time_delta_distance_us; /// Time in microseconds since the distance was sampled.
		public float distance; /// Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=52)]
	public struct mavlink_hil_state_quaternion_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] attitude_quaternion; /// Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation)
		public float rollspeed; /// Body frame roll / phi angular speed (rad/s)
		public float pitchspeed; /// Body frame pitch / theta angular speed (rad/s)
		public float yawspeed; /// Body frame yaw / psi angular speed (rad/s)
		public int lat; /// Latitude, expressed as * 1E7
		public int lon; /// Longitude, expressed as * 1E7
		public int alt; /// Altitude in meters, expressed as * 1000 (millimeters)
		public short vx; /// Ground X Speed (Latitude), expressed as m/s * 100
		public short vy; /// Ground Y Speed (Longitude), expressed as m/s * 100
		public short vz; /// Ground Z Speed (Altitude), expressed as m/s * 100
		public ushort ind_airspeed; /// Indicated airspeed, expressed as m/s * 100
		public ushort true_airspeed; /// True airspeed, expressed as m/s * 100
		public short xacc; /// X acceleration (mg)
		public short yacc; /// Y acceleration (mg)
		public short zacc; /// Z acceleration (mg)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_scaled_imu2_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public short xacc; /// X acceleration (mg)
		public short yacc; /// Y acceleration (mg)
		public short zacc; /// Z acceleration (mg)
		public short xgyro; /// Angular speed around X axis (millirad /sec)
		public short ygyro; /// Angular speed around Y axis (millirad /sec)
		public short zgyro; /// Angular speed around Z axis (millirad /sec)
		public short xmag; /// X Magnetic field (milli tesla)
		public short ymag; /// Y Magnetic field (milli tesla)
		public short zmag; /// Z Magnetic field (milli tesla)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_log_request_list_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort start; /// First log id (0 for first available)
		public ushort end; /// Last log id (0xffff for last available)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_log_entry_t
	{
		public ushort id; /// Log id
		public ushort num_logs; /// Total number of logs
		public ushort last_log_num; /// High log number
		public uint time_utc; /// UTC timestamp of log in seconds since 1970, or 0 if not available
		public uint size; /// Size of the log (may be approximate) in bytes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_log_request_data_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public ushort id; /// Log id (from LOG_ENTRY reply)
		public uint ofs; /// Offset into the log
		public uint count; /// Number of bytes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_log_data_t
	{
		public ushort id; /// Log id (from LOG_ENTRY reply)
		public uint ofs; /// Offset into the log
		public byte count; /// Number of bytes (zero for end of log)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=90)]
		public byte[] data; /// log data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_log_erase_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_log_request_end_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_gps_inject_data_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte len; /// data length
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=110)]
		public byte[] data; /// raw data (110 is enough for 12 satellites of RTCMv2)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=35)]
	public struct mavlink_gps2_raw_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public byte fix_type; /// 0-1: no fix, 2: 2D fix, 3: 3D fix, 4: DGPS fix, 5: RTK Fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		public int lat; /// Latitude (WGS84), in degrees * 1E7
		public int lon; /// Longitude (WGS84), in degrees * 1E7
		public int alt; /// Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
		public ushort eph; /// GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		public ushort epv; /// GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
		public ushort vel; /// GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
		public ushort cog; /// Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
		public byte satellites_visible; /// Number of satellites visible. If unknown, set to 255
		public byte dgps_numch; /// Number of DGPS satellites
		public uint dgps_age; /// Age of DGPS info
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_power_status_t
	{
		public ushort Vcc; /// 5V rail voltage in millivolts
		public ushort Vservo; /// servo rail voltage in millivolts
		public ushort flags; /// power supply status flags (see MAV_POWER_STATUS enum)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=10)]
	public struct mavlink_serial_control_t
	{
		public byte device; /// See SERIAL_CONTROL_DEV enum
		public byte flags; /// See SERIAL_CONTROL_FLAG enum
		public ushort timeout; /// Timeout for reply data in milliseconds
		public uint baudrate; /// Baudrate of transfer. Zero means no change.
		public byte count; /// how many bytes in this transfer
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=70)]
		public byte[] data; /// serial data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=35)]
	public struct mavlink_gps_rtk_t
	{
		public uint time_last_baseline_ms; /// Time since boot of last baseline message received in ms.
		public byte rtk_receiver_id; /// Identification of connected RTK receiver.
		public ushort wn; /// GPS Week Number of last baseline
		public uint tow; /// GPS Time of Week of last baseline
		public byte rtk_health; /// GPS-specific health report for RTK data.
		public byte rtk_rate; /// Rate of baseline messages being received by GPS, in HZ
		public byte nsats; /// Current number of sats used for RTK calculation.
		public byte baseline_coords_type; /// Coordinate system of baseline. 0 == ECEF, 1 == NED
		public int baseline_a_mm; /// Current baseline in ECEF x or NED north component in mm.
		public int baseline_b_mm; /// Current baseline in ECEF y or NED east component in mm.
		public int baseline_c_mm; /// Current baseline in ECEF z or NED down component in mm.
		public uint accuracy; /// Current estimate of baseline accuracy.
		public int iar_num_hypotheses; /// Current number of integer ambiguity hypotheses.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=35)]
	public struct mavlink_gps2_rtk_t
	{
		public uint time_last_baseline_ms; /// Time since boot of last baseline message received in ms.
		public byte rtk_receiver_id; /// Identification of connected RTK receiver.
		public ushort wn; /// GPS Week Number of last baseline
		public uint tow; /// GPS Time of Week of last baseline
		public byte rtk_health; /// GPS-specific health report for RTK data.
		public byte rtk_rate; /// Rate of baseline messages being received by GPS, in HZ
		public byte nsats; /// Current number of sats used for RTK calculation.
		public byte baseline_coords_type; /// Coordinate system of baseline. 0 == ECEF, 1 == NED
		public int baseline_a_mm; /// Current baseline in ECEF x or NED north component in mm.
		public int baseline_b_mm; /// Current baseline in ECEF y or NED east component in mm.
		public int baseline_c_mm; /// Current baseline in ECEF z or NED down component in mm.
		public uint accuracy; /// Current estimate of baseline accuracy.
		public int iar_num_hypotheses; /// Current number of integer ambiguity hypotheses.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_scaled_imu3_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public short xacc; /// X acceleration (mg)
		public short yacc; /// Y acceleration (mg)
		public short zacc; /// Z acceleration (mg)
		public short xgyro; /// Angular speed around X axis (millirad /sec)
		public short ygyro; /// Angular speed around Y axis (millirad /sec)
		public short zgyro; /// Angular speed around Z axis (millirad /sec)
		public short xmag; /// X Magnetic field (milli tesla)
		public short ymag; /// Y Magnetic field (milli tesla)
		public short zmag; /// Z Magnetic field (milli tesla)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_data_transmission_handshake_t
	{
		public byte type; /// type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)
		public uint size; /// total data size in bytes (set on ACK only)
		public ushort width; /// Width of a matrix or image
		public ushort height; /// Height of a matrix or image
		public ushort packets; /// number of packets beeing sent (set on ACK only)
		public byte payload; /// payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)
		public byte jpg_quality; /// JPEG quality out of [1,100]
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_encapsulated_data_t
	{
		public ushort seqnr; /// sequence number (starting with 0 on every transmission)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=253)]
		public byte[] data; /// image data bytes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_distance_sensor_t
	{
		public uint time_boot_ms; /// Time since system boot
		public ushort min_distance; /// Minimum distance the sensor can measure in centimeters
		public ushort max_distance; /// Maximum distance the sensor can measure in centimeters
		public ushort current_distance; /// Current distance reading
		public byte type; /// Type from MAV_DISTANCE_SENSOR enum.
		public byte id; /// Onboard ID of the sensor
		public byte orientation; /// Direction the sensor faces from FIXME enum.
		public byte covariance; /// Measurement covariance in centimeters, 0 for unknown / invalid readings
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_terrain_request_t
	{
		public int lat; /// Latitude of SW corner of first grid (degrees *10^7)
		public int lon; /// Longitude of SW corner of first grid (in degrees *10^7)
		public ushort grid_spacing; /// Grid spacing in meters
		public ulong mask; /// Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_terrain_data_t
	{
		public int lat; /// Latitude of SW corner of first grid (degrees *10^7)
		public int lon; /// Longitude of SW corner of first grid (in degrees *10^7)
		public ushort grid_spacing; /// Grid spacing in meters
		public byte gridbit; /// bit within the terrain request mask
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public short[] data; /// Terrain data in meters AMSL
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_terrain_check_t
	{
		public int lat; /// Latitude (degrees *10^7)
		public int lon; /// Longitude (degrees *10^7)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_terrain_report_t
	{
		public int lat; /// Latitude (degrees *10^7)
		public int lon; /// Longitude (degrees *10^7)
		public ushort spacing; /// grid spacing (zero if terrain at this location unavailable)
		public float terrain_height; /// Terrain height in meters AMSL
		public float current_height; /// Current vehicle height above lat/lon terrain height (meters)
		public ushort pending; /// Number of 4x4 terrain blocks waiting to be received or read from disk
		public ushort loaded; /// Number of 4x4 terrain blocks in memory
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_scaled_pressure2_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public float press_abs; /// Absolute pressure (hectopascal)
		public float press_diff; /// Differential pressure 1 (hectopascal)
		public short temperature; /// Temperature measurement (0.01 degrees celsius)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=24)]
	public struct mavlink_att_pos_mocap_t
	{
		public ulong time_usec; /// Timestamp (micros since boot or Unix epoch)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] q; /// Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
		public float x; /// X position in meters (NED)
		public float y; /// Y position in meters (NED)
		public float z; /// Z position in meters (NED)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_set_actuator_control_target_t
	{
		public ulong time_usec; /// Timestamp (micros since boot or Unix epoch)
		public byte group_mlx; /// Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=8)]
		public float[] controls; /// Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_actuator_control_target_t
	{
		public ulong time_usec; /// Timestamp (micros since boot or Unix epoch)
		public byte group_mlx; /// Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=8)]
		public float[] controls; /// Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_battery_status_t
	{
		public byte id; /// Battery ID
		public byte battery_function; /// Function of the battery
		public byte type; /// Type (chemistry) of the battery
		public short temperature; /// Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public ushort[] voltages; /// Battery voltage of cells, in millivolts (1 = 1 millivolt)
		public short current_battery; /// Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		public int current_consumed; /// Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
		public int energy_consumed; /// Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
		public byte battery_remaining; /// Remaining battery energy: (0%%: 0, 100%%: 100), -1: autopilot does not estimate the remaining battery
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=39)]
	public struct mavlink_autopilot_version_t
	{
		public ulong capabilities; /// bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum)
		public uint flight_sw_version; /// Firmware version number
		public uint middleware_sw_version; /// Middleware version number
		public uint os_sw_version; /// Operating system version number
		public uint board_version; /// HW / board version (last 8 bytes should be silicon ID, if any)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=8)]
		public byte[] flight_custom_version; /// Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=8)]
		public byte[] middleware_custom_version; /// Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=8)]
		public byte[] os_custom_version; /// Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
		public ushort vendor_id; /// ID of the board vendor
		public ushort product_id; /// ID of the product
		public ulong uid; /// UID if provided by hardware
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_v2_extension_t
	{
		public byte target_network; /// Network ID (0 for broadcast)
		public byte target_system; /// System ID (0 for broadcast)
		public byte target_component; /// Component ID (0 for broadcast)
		public ushort message_type; /// A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=249)]
		public byte[] payload; /// Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=5)]
	public struct mavlink_memory_vect_t
	{
		public ushort address; /// Starting address of the debug variables
		public byte ver; /// Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
		public byte type; /// Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=32)]
		public byte[] value; /// Memory contents at specified address
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=21)]
	public struct mavlink_debug_vect_t
	{
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public byte[] name; /// Name
		public ulong time_usec; /// Timestamp
		public float x; /// x
		public float y; /// y
		public float z; /// z
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_named_value_float_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public byte[] name; /// Name of the debug variable
		public float value; /// Floating point value
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_named_value_int_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public byte[] name; /// Name of the debug variable
		public int value; /// Signed integer value
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=2)]
	public struct mavlink_statustext_t
	{
		public byte severity; /// Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=50)]
		public byte[] text; /// Status text message, without null termination character
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_debug_t
	{
		public uint time_boot_ms; /// Timestamp (milliseconds since system boot)
		public byte ind; /// index of debug variable
		public float value; /// DEBUG value
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=11)]
	public struct mavlink_set_cam_shutter_t
	{
		public byte cam_no; /// Camera id
		public byte cam_mode; /// Camera mode: 0 = auto, 1 = manual
		public byte trigger_pin; /// Trigger pin, 0-3 for PtGrey FireFly
		public ushort interval; /// Shutter interval, in microseconds
		public ushort exposure; /// Exposure time, in microseconds
		public float gain; /// Camera gain
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=52)]
	public struct mavlink_image_triggered_t
	{
		public ulong timestamp; /// Timestamp
		public uint seq; /// IMU seq
		public float roll; /// Roll angle in rad
		public float pitch; /// Pitch angle in rad
		public float yaw; /// Yaw angle in rad
		public float local_z; /// Local frame Z coordinate (height over ground)
		public float lat; /// GPS X coordinate
		public float lon; /// GPS Y coordinate
		public float alt; /// Global frame altitude
		public float ground_x; /// Ground truth X
		public float ground_y; /// Ground truth Y
		public float ground_z; /// Ground truth Z
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=1)]
	public struct mavlink_image_trigger_control_t
	{
		public byte enable; /// 0 to disable, 1 to enable
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=92)]
	public struct mavlink_image_available_t
	{
		public ulong cam_id; /// Camera id
		public byte cam_no; /// Camera # (starts with 0)
		public ulong timestamp; /// Timestamp
		public ulong valid_until; /// Until which timestamp this buffer will stay valid
		public uint img_seq; /// The image sequence number
		public uint img_buf_index; /// Position of the image in the buffer, starts with 0
		public ushort width; /// Image width
		public ushort height; /// Image height
		public ushort depth; /// Image depth
		public byte channels; /// Image channels
		public uint key; /// Shared memory area key
		public uint exposure; /// Exposure time, in microseconds
		public float gain; /// Camera gain
		public float roll; /// Roll angle in rad
		public float pitch; /// Pitch angle in rad
		public float yaw; /// Yaw angle in rad
		public float local_z; /// Local frame Z coordinate (height over ground)
		public float lat; /// GPS X coordinate
		public float lon; /// GPS Y coordinate
		public float alt; /// Global frame altitude
		public float ground_x; /// Ground truth X
		public float ground_y; /// Ground truth Y
		public float ground_z; /// Ground truth Z
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_set_position_control_offset_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public float x; /// x position offset
		public float y; /// y position offset
		public float z; /// z position offset
		public float yaw; /// yaw orientation offset in radians, 0 = NORTH
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_position_control_setpoint_t
	{
		public ushort id; /// ID of waypoint, 0 for plain position
		public float x; /// x position
		public float y; /// y position
		public float z; /// z position
		public float yaw; /// yaw orientation in radians, 0 = NORTH
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=26)]
	public struct mavlink_marker_t
	{
		public ushort id; /// ID
		public float x; /// x position
		public float y; /// y position
		public float z; /// z position
		public float roll; /// roll orientation
		public float pitch; /// pitch orientation
		public float yaw; /// yaw orientation
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=16)]
	public struct mavlink_raw_aux_t
	{
		public ushort adc1; /// ADC1 (J405 ADC3, LPC2148 AD0.6)
		public ushort adc2; /// ADC2 (J405 ADC5, LPC2148 AD0.2)
		public ushort adc3; /// ADC3 (J405 ADC6, LPC2148 AD0.1)
		public ushort adc4; /// ADC4 (J405 ADC7, LPC2148 AD1.3)
		public ushort vbat; /// Battery voltage
		public short temp; /// Temperature (degrees celcius)
		public int baro; /// Barometric pressure (hecto Pascal)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_watchdog_heartbeat_t
	{
		public ushort watchdog_id; /// Watchdog ID
		public ushort process_count; /// Number of processes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=10)]
	public struct mavlink_watchdog_process_info_t
	{
		public ushort watchdog_id; /// Watchdog ID
		public ushort process_id; /// Process ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=100)]
		public byte[] name; /// Process name
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=147)]
		public byte[] arguments; /// Process arguments
		public int timeout; /// Timeout (seconds)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_watchdog_process_status_t
	{
		public ushort watchdog_id; /// Watchdog ID
		public ushort process_id; /// Process ID
		public byte state; /// Is running / finished / suspended / crashed
		public byte muted; /// Is muted
		public int pid; /// PID
		public ushort crashes; /// Number of crashes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_watchdog_command_t
	{
		public byte target_system_id; /// Target system ID
		public ushort watchdog_id; /// Watchdog ID
		public ushort process_id; /// Process ID
		public byte command_id; /// Command ID
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=7)]
	public struct mavlink_pattern_detected_t
	{
		public byte type; /// 0: Pattern, 1: Letter
		public float confidence; /// Confidence of detection
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=100)]
		public byte[] file; /// Pattern file name
		public byte detected; /// Accepted as true detection, 0 no, 1 yes
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_point_of_interest_t
	{
		public byte type; /// 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
		public byte color; /// 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
		public byte coordinate_system; /// 0: global, 1:local
		public ushort timeout; /// 0: no timeout, >1: timeout in seconds
		public float x; /// X Position
		public float y; /// Y Position
		public float z; /// Z Position
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=26)]
		public byte[] name; /// POI name
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=30)]
	public struct mavlink_point_of_interest_connection_t
	{
		public byte type; /// 0: Notice, 1: Warning, 2: Critical, 3: Emergency, 4: Debug
		public byte color; /// 0: blue, 1: yellow, 2: red, 3: orange, 4: green, 5: magenta
		public byte coordinate_system; /// 0: global, 1:local
		public ushort timeout; /// 0: no timeout, >1: timeout in seconds
		public float xp1; /// X1 Position
		public float yp1; /// Y1 Position
		public float zp1; /// Z1 Position
		public float xp2; /// X2 Position
		public float yp2; /// Y2 Position
		public float zp2; /// Z2 Position
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=26)]
		public byte[] name; /// POI connection name
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_brief_feature_t
	{
		public float x; /// x position in m
		public float y; /// y position in m
		public float z; /// z position in m
		public byte orientation_assignment; /// Orientation assignment 0: false, 1:true
		public ushort size; /// Size in pixels
		public ushort orientation; /// Orientation
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=32)]
		public byte[] descriptor; /// Descriptor
		public float response; /// Harris operator response at this location
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=21)]
	public struct mavlink_attitude_control_t
	{
		public byte target; /// The system to be controlled
		public float roll; /// roll
		public float pitch; /// pitch
		public float yaw; /// yaw
		public float thrust; /// thrust
		public byte roll_manual; /// roll control enabled auto:0, manual:1
		public byte pitch_manual; /// pitch auto:0, manual:1
		public byte yaw_manual; /// yaw auto:0, manual:1
		public byte thrust_manual; /// thrust auto:0, manual:1
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=48)]
	public struct mavlink_detection_stats_t
	{
		public uint detections; /// Number of detections
		public uint cluster_iters; /// Number of cluster iterations
		public float best_score; /// Best score
		public int best_lat; /// Latitude of the best detection * 1E7
		public int best_lon; /// Longitude of the best detection * 1E7
		public int best_alt; /// Altitude of the best detection * 1E3
		public uint best_detection_id; /// Best detection ID
		public uint best_cluster_id; /// Best cluster ID
		public uint best_cluster_iter_id; /// Best cluster ID
		public uint images_done; /// Number of images already processed
		public uint images_todo; /// Number of images still to process
		public float fps; /// Average images per seconds processed
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=39)]
	public struct mavlink_onboard_health_t
	{
		public uint uptime; /// Uptime of system
		public ushort cpu_freq; /// CPU frequency
		public byte cpu_load; /// CPU load in percent
		public byte ram_usage; /// RAM usage in percent
		public float ram_total; /// RAM size in GiB
		public byte swap_usage; /// Swap usage in percent
		public float swap_total; /// Swap size in GiB
		public byte disk_health; /// Disk health (-1: N/A, 0: ERR, 1: RO, 2: RW)
		public byte disk_usage; /// Disk usage in percent
		public float disk_total; /// Disk total in GiB
		public float temp; /// Temperature
		public float voltage; /// Supply voltage V
		public float network_load_in; /// Network load inbound KiB/s
		public float network_load_out; /// Network load outbound in KiB/s 
	};

	public static readonly Type[] MAVLINK_MESSAGE_INFO = new Type[] {
			typeof( mavlink_heartbeat_t),			// message 0
			typeof( mavlink_sys_status_t),			// message 1
			typeof( mavlink_system_time_t),			// message 2
			null,			 //message 3
			typeof( mavlink_ping_t),			// message 4
			typeof( mavlink_change_operator_control_t),			// message 5
			typeof( mavlink_change_operator_control_ack_t),			// message 6
			typeof( mavlink_auth_key_t),			// message 7
			null,			 //message 8
			null,			 //message 9
			null,			 //message 10
			typeof( mavlink_set_mode_t),			// message 11
			null,			 //message 12
			null,			 //message 13
			null,			 //message 14
			null,			 //message 15
			null,			 //message 16
			null,			 //message 17
			null,			 //message 18
			null,			 //message 19
			typeof( mavlink_param_request_read_t),			// message 20
			typeof( mavlink_param_request_list_t),			// message 21
			typeof( mavlink_param_value_t),			// message 22
			typeof( mavlink_param_set_t),			// message 23
			typeof( mavlink_gps_raw_int_t),			// message 24
			typeof( mavlink_gps_status_t),			// message 25
			typeof( mavlink_scaled_imu_t),			// message 26
			typeof( mavlink_raw_imu_t),			// message 27
			typeof( mavlink_raw_pressure_t),			// message 28
			typeof( mavlink_scaled_pressure_t),			// message 29
			typeof( mavlink_attitude_t),			// message 30
			typeof( mavlink_attitude_quaternion_t),			// message 31
			typeof( mavlink_local_position_ned_t),			// message 32
			typeof( mavlink_global_position_int_t),			// message 33
			typeof( mavlink_rc_channels_scaled_t),			// message 34
			typeof( mavlink_rc_channels_raw_t),			// message 35
			typeof( mavlink_servo_output_raw_t),			// message 36
			typeof( mavlink_mission_request_partial_list_t),			// message 37
			typeof( mavlink_mission_write_partial_list_t),			// message 38
			typeof( mavlink_mission_item_t),			// message 39
			typeof( mavlink_mission_request_t),			// message 40
			typeof( mavlink_mission_set_current_t),			// message 41
			typeof( mavlink_mission_current_t),			// message 42
			typeof( mavlink_mission_request_list_t),			// message 43
			typeof( mavlink_mission_count_t),			// message 44
			typeof( mavlink_mission_clear_all_t),			// message 45
			typeof( mavlink_mission_item_reached_t),			// message 46
			typeof( mavlink_mission_ack_t),			// message 47
			typeof( mavlink_set_gps_global_origin_t),			// message 48
			typeof( mavlink_gps_global_origin_t),			// message 49
			typeof( mavlink_param_map_rc_t),			// message 50
			null,			 //message 51
			null,			 //message 52
			null,			 //message 53
			typeof( mavlink_safety_set_allowed_area_t),			// message 54
			typeof( mavlink_safety_allowed_area_t),			// message 55
			null,			 //message 56
			null,			 //message 57
			null,			 //message 58
			null,			 //message 59
			null,			 //message 60
			typeof( mavlink_attitude_quaternion_cov_t),			// message 61
			typeof( mavlink_nav_controller_output_t),			// message 62
			typeof( mavlink_global_position_int_cov_t),			// message 63
			typeof( mavlink_local_position_ned_cov_t),			// message 64
			typeof( mavlink_rc_channels_t),			// message 65
			typeof( mavlink_request_data_stream_t),			// message 66
			typeof( mavlink_data_stream_t),			// message 67
			null,			 //message 68
			typeof( mavlink_manual_control_t),			// message 69
			typeof( mavlink_rc_channels_override_t),			// message 70
			null,			 //message 71
			null,			 //message 72
			typeof( mavlink_mission_item_int_t),			// message 73
			typeof( mavlink_vfr_hud_t),			// message 74
			typeof( mavlink_command_int_t),			// message 75
			typeof( mavlink_command_long_t),			// message 76
			typeof( mavlink_command_ack_t),			// message 77
			null,			 //message 78
			null,			 //message 79
			null,			 //message 80
			typeof( mavlink_manual_setpoint_t),			// message 81
			typeof( mavlink_set_attitude_target_t),			// message 82
			typeof( mavlink_attitude_target_t),			// message 83
			typeof( mavlink_set_position_target_local_ned_t),			// message 84
			typeof( mavlink_position_target_local_ned_t),			// message 85
			typeof( mavlink_set_position_target_global_int_t),			// message 86
			typeof( mavlink_position_target_global_int_t),			// message 87
			null,			 //message 88
			typeof( mavlink_local_position_ned_system_global_offset_t),			// message 89
			typeof( mavlink_hil_state_t),			// message 90
			typeof( mavlink_hil_controls_t),			// message 91
			typeof( mavlink_hil_rc_inputs_raw_t),			// message 92
			null,			 //message 93
			null,			 //message 94
			null,			 //message 95
			null,			 //message 96
			null,			 //message 97
			null,			 //message 98
			null,			 //message 99
			typeof( mavlink_optical_flow_t),			// message 100
			typeof( mavlink_global_vision_position_estimate_t),			// message 101
			typeof( mavlink_vision_position_estimate_t),			// message 102
			typeof( mavlink_vision_speed_estimate_t),			// message 103
			typeof( mavlink_vicon_position_estimate_t),			// message 104
			typeof( mavlink_highres_imu_t),			// message 105
			typeof( mavlink_optical_flow_rad_t),			// message 106
			typeof( mavlink_hil_sensor_t),			// message 107
			typeof( mavlink_sim_state_t),			// message 108
			typeof( mavlink_radio_status_t),			// message 109
			typeof( mavlink_file_transfer_protocol_t),			// message 110
			typeof( mavlink_timesync_t),			// message 111
			null,			 //message 112
			typeof( mavlink_hil_gps_t),			// message 113
			typeof( mavlink_hil_optical_flow_t),			// message 114
			typeof( mavlink_hil_state_quaternion_t),			// message 115
			typeof( mavlink_scaled_imu2_t),			// message 116
			typeof( mavlink_log_request_list_t),			// message 117
			typeof( mavlink_log_entry_t),			// message 118
			typeof( mavlink_log_request_data_t),			// message 119
			typeof( mavlink_log_data_t),			// message 120
			typeof( mavlink_log_erase_t),			// message 121
			typeof( mavlink_log_request_end_t),			// message 122
			typeof( mavlink_gps_inject_data_t),			// message 123
			typeof( mavlink_gps2_raw_t),			// message 124
			typeof( mavlink_power_status_t),			// message 125
			typeof( mavlink_serial_control_t),			// message 126
			typeof( mavlink_gps_rtk_t),			// message 127
			typeof( mavlink_gps2_rtk_t),			// message 128
			typeof( mavlink_scaled_imu3_t),			// message 129
			typeof( mavlink_data_transmission_handshake_t),			// message 130
			typeof( mavlink_encapsulated_data_t),			// message 131
			typeof( mavlink_distance_sensor_t),			// message 132
			typeof( mavlink_terrain_request_t),			// message 133
			typeof( mavlink_terrain_data_t),			// message 134
			typeof( mavlink_terrain_check_t),			// message 135
			typeof( mavlink_terrain_report_t),			// message 136
			typeof( mavlink_scaled_pressure2_t),			// message 137
			typeof( mavlink_att_pos_mocap_t),			// message 138
			typeof( mavlink_set_actuator_control_target_t),			// message 139
			typeof( mavlink_actuator_control_target_t),			// message 140
			null,			 //message 141
			null,			 //message 142
			null,			 //message 143
			null,			 //message 144
			null,			 //message 145
			null,			 //message 146
			typeof( mavlink_battery_status_t),			// message 147
			typeof( mavlink_autopilot_version_t),			// message 148
			null,			 //message 149
			null,			 //message 150
			typeof( mavlink_set_cam_shutter_t),			// message 151
			typeof( mavlink_image_triggered_t),			// message 152
			typeof( mavlink_image_trigger_control_t),			// message 153
			typeof( mavlink_image_available_t),			// message 154
			null,			 //message 155
			null,			 //message 156
			null,			 //message 157
			null,			 //message 158
			null,			 //message 159
			typeof( mavlink_set_position_control_offset_t),			// message 160
			null,			 //message 161
			null,			 //message 162
			null,			 //message 163
			null,			 //message 164
			null,			 //message 165
			null,			 //message 166
			null,			 //message 167
			null,			 //message 168
			null,			 //message 169
			typeof( mavlink_position_control_setpoint_t),			// message 170
			typeof( mavlink_marker_t),			// message 171
			typeof( mavlink_raw_aux_t),			// message 172
			null,			 //message 173
			null,			 //message 174
			null,			 //message 175
			null,			 //message 176
			null,			 //message 177
			null,			 //message 178
			null,			 //message 179
			typeof( mavlink_watchdog_heartbeat_t),			// message 180
			typeof( mavlink_watchdog_process_info_t),			// message 181
			typeof( mavlink_watchdog_process_status_t),			// message 182
			typeof( mavlink_watchdog_command_t),			// message 183
			null,			 //message 184
			null,			 //message 185
			null,			 //message 186
			null,			 //message 187
			null,			 //message 188
			null,			 //message 189
			typeof( mavlink_pattern_detected_t),			// message 190
			typeof( mavlink_point_of_interest_t),			// message 191
			typeof( mavlink_point_of_interest_connection_t),			// message 192
			null,			 //message 193
			null,			 //message 194
			typeof( mavlink_brief_feature_t),			// message 195
			null,			 //message 196
			null,			 //message 197
			null,			 //message 198
			null,			 //message 199
			typeof( mavlink_attitude_control_t),			// message 200
			null,			 //message 201
			null,			 //message 202
			null,			 //message 203
			null,			 //message 204
			typeof( mavlink_detection_stats_t),			// message 205
			typeof( mavlink_onboard_health_t),			// message 206
			null,			 //message 207
			null,			 //message 208
			null,			 //message 209
			null,			 //message 210
			null,			 //message 211
			null,			 //message 212
			null,			 //message 213
			null,			 //message 214
			null,			 //message 215
			null,			 //message 216
			null,			 //message 217
			null,			 //message 218
			null,			 //message 219
			null,			 //message 220
			null,			 //message 221
			null,			 //message 222
			null,			 //message 223
			null,			 //message 224
			null,			 //message 225
			null,			 //message 226
			null,			 //message 227
			null,			 //message 228
			null,			 //message 229
			null,			 //message 230
			null,			 //message 231
			null,			 //message 232
			null,			 //message 233
			null,			 //message 234
			null,			 //message 235
			null,			 //message 236
			null,			 //message 237
			null,			 //message 238
			null,			 //message 239
			null,			 //message 240
			null,			 //message 241
			null,			 //message 242
			null,			 //message 243
			null,			 //message 244
			null,			 //message 245
			null,			 //message 246
			null,			 //message 247
			typeof( mavlink_v2_extension_t),			// message 248
			typeof( mavlink_memory_vect_t),			// message 249
			typeof( mavlink_debug_vect_t),			// message 250
			typeof( mavlink_named_value_float_t),			// message 251
			typeof( mavlink_named_value_int_t),			// message 252
			typeof( mavlink_statustext_t),			// message 253
			typeof( mavlink_debug_t),			// message 254
			null,			 //message 255
	};
