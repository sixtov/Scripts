    //                                                 {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
    public static readonly byte[] MAVLINK_MESSAGE_LENGTHS = new byte[] {  9, 31, 12,  0, 14,  4,  3,  1,  0,  0,  0,  6,  0,  0,  0,  0,  0,  0,  0,  0,  5,  2, 10,  8, 30,  6, 22, 26, 16, 14, 28, 32, 28, 28, 22, 22, 21,  6,  6, 37,  4,  4,  2,  2,  4,  2,  2,  3, 13, 12, 19, 17, 15, 15, 27, 25, 18, 18, 20, 20,  9, 10, 30, 13, 36,  0,  6,  4,  0, 11, 18,  0,  0,  0, 20,  0, 33,  3,  0,  0, 20, 22,  0,  0,  0,  0,  0,  0,  0, 28, 56, 42, 33,  0,  0,  0,  0,  0,  0,  0, 26, 32, 32, 20, 32, 62, 18, 64, 84,  9, 15, 10,  9, 36, 26, 52, 22,  6, 14, 12,  8,  2,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 24, 33, 25, 42,  8,  4, 12, 15, 13,  6, 15, 14,  0, 12,  3,  8, 28, 44,  3,  9, 22, 12,  3,  3,  3,  3,  8, 48, 19,  3,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  5, 21,  9,  9,  2,  9,  0};
	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_heartbeat_t
	{
		public byte type; /// Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
		public byte autopilot; /// Autopilot type / class. defined in MAV_AUTOPILOT ENUM
		public byte base_mode; /// System mode bitfield, see MAV_MODE_FLAGS ENUM in mavlink/include/mavlink_types.h
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
		public ulong time_usec; /// Unix timestamp in microseconds
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
		public byte fix_type; /// 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		public int lat; /// Latitude (WGS84), in degrees * 1E7
		public int lon; /// Longitude (WGS84), in degrees * 1E7
		public int alt; /// Altitude (WGS84), in meters * 1000 (positive for up)
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
		public float q1; /// Quaternion component 1
		public float q2; /// Quaternion component 2
		public float q3; /// Quaternion component 3
		public float q4; /// Quaternion component 4
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
		public int alt; /// Altitude in meters, expressed as * 1000 (millimeters), above MSL
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
		public float param1; /// PARAM1 / For NAV command MISSIONs: Radius in which the MISSION is accepted as reached, in meters
		public float param2; /// PARAM2 / For NAV command MISSIONs: Time that the MAV should stay inside the PARAM1 radius before advancing, in milliseconds
		public float param3; /// PARAM3 / For LOITER command MISSIONs: Orbit to circle around the MISSION, in meters. If positive the orbit direction should be clockwise, if negative the orbit direction should be counter-clockwise.
		public float param4; /// PARAM4 / For NAV and LOITER command MISSIONs: Yaw orientation in degrees, [0..360] 0 = NORTH
		public float x; /// PARAM5 / local: x position, global: latitude
		public float y; /// PARAM6 / y position: global: longitude
		public float z; /// PARAM7 / z position: global: altitude
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
		public int altitude; /// Altitude (WGS84), in meters * 1000 (positive for up)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_gps_global_origin_t
	{
		public int latitude; /// Latitude (WGS84), in degrees * 1E7
		public int longitude; /// Longitude (WGS84), in degrees * 1E7
		public int altitude; /// Altitude (WGS84), in meters * 1000 (positive for up)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=19)]
	public struct mavlink_set_local_position_setpoint_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte coordinate_frame; /// Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		public float x; /// x position
		public float y; /// y position
		public float z; /// z position
		public float yaw; /// Desired yaw angle
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=17)]
	public struct mavlink_local_position_setpoint_t
	{
		public byte coordinate_frame; /// Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
		public float x; /// x position
		public float y; /// y position
		public float z; /// z position
		public float yaw; /// Desired yaw angle
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_global_position_setpoint_int_t
	{
		public byte coordinate_frame; /// Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		public int latitude; /// Latitude (WGS84), in degrees * 1E7
		public int longitude; /// Longitude (WGS84), in degrees * 1E7
		public int altitude; /// Altitude (WGS84), in meters * 1000 (positive for up)
		public short yaw; /// Desired yaw angle in degrees * 100
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_set_global_position_setpoint_int_t
	{
		public byte coordinate_frame; /// Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
		public int latitude; /// Latitude (WGS84), in degrees * 1E7
		public int longitude; /// Longitude (WGS84), in degrees * 1E7
		public int altitude; /// Altitude (WGS84), in meters * 1000 (positive for up)
		public short yaw; /// Desired yaw angle in degrees * 100
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

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_set_roll_pitch_yaw_thrust_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public float roll; /// Desired roll angle in radians
		public float pitch; /// Desired pitch angle in radians
		public float yaw; /// Desired yaw angle in radians
		public float thrust; /// Collective thrust, normalized to 0 .. 1
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_set_roll_pitch_yaw_speed_thrust_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public float roll_speed; /// Desired roll angular speed in rad/s
		public float pitch_speed; /// Desired pitch angular speed in rad/s
		public float yaw_speed; /// Desired yaw angular speed in rad/s
		public float thrust; /// Collective thrust, normalized to 0 .. 1
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=20)]
	public struct mavlink_roll_pitch_yaw_thrust_setpoint_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public float roll; /// Desired roll angle in radians
		public float pitch; /// Desired pitch angle in radians
		public float yaw; /// Desired yaw angle in radians
		public float thrust; /// Collective thrust, normalized to 0 .. 1
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=20)]
	public struct mavlink_roll_pitch_yaw_speed_thrust_setpoint_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public float roll_speed; /// Desired roll angular speed in rad/s
		public float pitch_speed; /// Desired pitch angular speed in rad/s
		public float yaw_speed; /// Desired yaw angular speed in rad/s
		public float thrust; /// Collective thrust, normalized to 0 .. 1
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_set_quad_motors_setpoint_t
	{
		public byte target_system; /// System ID of the system that should set these motor commands
		public ushort motor_front_nw; /// Front motor in + configuration, front left motor in x configuration
		public ushort motor_right_ne; /// Right motor in + configuration, front right motor in x configuration
		public ushort motor_back_se; /// Back motor in + configuration, back right motor in x configuration
		public ushort motor_left_sw; /// Left motor in + configuration, back left motor in x configuration
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=10)]
	public struct mavlink_set_quad_swarm_roll_pitch_yaw_thrust_t
	{
		public byte group; /// ID of the quadrotor group (0 - 255, up to 256 groups supported)
		public byte mode; /// ID of the flight mode (0 - 255, up to 256 modes supported)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] roll; /// Desired roll angle in radians +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] pitch; /// Desired pitch angle in radians +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] yaw; /// Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public ushort[] thrust; /// Collective thrust, scaled to uint16 (0..UINT16_MAX)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=30)]
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
		public float nav_wptrad; /// Navigation waypoint radius in meters
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_set_quad_swarm_led_roll_pitch_yaw_thrust_t
	{
		public byte group; /// ID of the quadrotor group (0 - 255, up to 256 groups supported)
		public byte mode; /// ID of the flight mode (0 - 255, up to 256 modes supported)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public byte[] led_red; /// RGB red channel (0-255)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public byte[] led_blue; /// RGB green channel (0-255)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public byte[] led_green; /// RGB blue channel (0-255)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] roll; /// Desired roll angle in radians +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] pitch; /// Desired pitch angle in radians +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public short[] yaw; /// Desired yaw angle in radians, scaled to int16 +-PI (+-INT16_MAX)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public ushort[] thrust; /// Collective thrust, scaled to uint16 (0..UINT16_MAX)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=36)]
	public struct mavlink_state_correction_t
	{
		public float xErr; /// x position error
		public float yErr; /// y position error
		public float zErr; /// z position error
		public float rollErr; /// roll error (radians)
		public float pitchErr; /// pitch error (radians)
		public float yawErr; /// yaw error (radians)
		public float vxErr; /// x velocity
		public float vyErr; /// y velocity
		public float vzErr; /// z velocity
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

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=20)]
	public struct mavlink_roll_pitch_yaw_rates_thrust_setpoint_t
	{
		public uint time_boot_ms; /// Timestamp in milliseconds since system boot
		public float roll_rate; /// Desired roll rate in radians per second
		public float pitch_rate; /// Desired pitch rate in radians per second
		public float yaw_rate; /// Desired yaw rate in radians per second
		public float thrust; /// Collective thrust, normalized to 0 .. 1
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

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=18)]
	public struct mavlink_omnidirectional_flow_t
	{
		public ulong time_usec; /// Timestamp (microseconds, synced to UNIX time or since system boot)
		public byte sensor_id; /// Sensor ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public short[] left; /// Flow in deci pixels (1 = 0.1 pixel) on left hemisphere
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=10)]
		public short[] right; /// Flow in deci pixels (1 = 0.1 pixel) on right hemisphere
		public byte quality; /// Optical flow quality / confidence. 0: bad, 255: maximum quality
		public float front_distance_m; /// Front distance in meters. Positive value (including zero): distance known. Negative value: Unknown distance
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
		public float q1; /// True attitude quaternion component 1
		public float q2; /// True attitude quaternion component 2
		public float q3; /// True attitude quaternion component 3
		public float q4; /// True attitude quaternion component 4
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
		public byte rssi; /// local signal strength
		public byte remrssi; /// remote signal strength
		public byte txbuf; /// how full the tx buffer is as a percentage
		public byte noise; /// background noise level
		public byte remnoise; /// remote background noise level
		public ushort rxerrors; /// receive errors
		public ushort fixed; /// count of error corrected packets
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_file_transfer_start_t
	{
		public ulong transfer_uid; /// Unique transfer ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=240)]
		public byte[] dest_path; /// Destination path
		public byte direction; /// Transfer direction: 0: from requester, 1: to requester
		public uint file_size; /// File size in bytes
		public byte flags; /// RESERVED
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=10)]
	public struct mavlink_file_transfer_dir_list_t
	{
		public ulong transfer_uid; /// Unique transfer ID
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=240)]
		public byte[] dir_path; /// Directory path to list
		public byte flags; /// RESERVED
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_file_transfer_res_t
	{
		public ulong transfer_uid; /// Unique transfer ID
		public byte result; /// 0: OK, 1: not permitted, 2: bad path / file name, 3: no space left on device
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=36)]
	public struct mavlink_hil_gps_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		public byte fix_type; /// 0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix.
		public int lat; /// Latitude (WGS84), in degrees * 1E7
		public int lon; /// Longitude (WGS84), in degrees * 1E7
		public int alt; /// Altitude (WGS84), in meters * 1000 (positive for up)
		public ushort eph; /// GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: 65535
		public ushort epv; /// GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: 65535
		public ushort vel; /// GPS ground speed (m/s * 100). If unknown, set to: 65535
		public short vn; /// GPS velocity in cm/s in NORTH direction in earth-fixed NED frame
		public short ve; /// GPS velocity in cm/s in EAST direction in earth-fixed NED frame
		public short vd; /// GPS velocity in cm/s in DOWN direction in earth-fixed NED frame
		public ushort cog; /// Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: 65535
		public byte satellites_visible; /// Number of satellites visible. If unknown, set to 255
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=26)]
	public struct mavlink_hil_optical_flow_t
	{
		public ulong time_usec; /// Timestamp (UNIX)
		public byte sensor_id; /// Sensor ID
		public short flow_x; /// Flow in pixels in x-sensor direction
		public short flow_y; /// Flow in pixels in y-sensor direction
		public float flow_comp_m_x; /// Flow in meters in x-sensor direction, angular-speed compensated
		public float flow_comp_m_y; /// Flow in meters in y-sensor direction, angular-speed compensated
		public byte quality; /// Optical flow quality / confidence. 0: bad, 255: maximum quality
		public float ground_distance; /// Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=52)]
	public struct mavlink_hil_state_quaternion_t
	{
		public ulong time_usec; /// Timestamp (microseconds since UNIX epoch or microseconds since system boot)
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=4)]
		public float[] attitude_quaternion; /// Vehicle attitude expressed as normalized quaternion
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

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=24)]
	public struct mavlink_battery_status_t
	{
		public byte accu_id; /// Accupack ID
		public ushort voltage_cell_1; /// Battery voltage of cell 1, in millivolts (1 = 1 millivolt)
		public ushort voltage_cell_2; /// Battery voltage of cell 2, in millivolts (1 = 1 millivolt), -1: no cell
		public ushort voltage_cell_3; /// Battery voltage of cell 3, in millivolts (1 = 1 millivolt), -1: no cell
		public ushort voltage_cell_4; /// Battery voltage of cell 4, in millivolts (1 = 1 millivolt), -1: no cell
		public ushort voltage_cell_5; /// Battery voltage of cell 5, in millivolts (1 = 1 millivolt), -1: no cell
		public ushort voltage_cell_6; /// Battery voltage of cell 6, in millivolts (1 = 1 millivolt), -1: no cell
		public short current_battery; /// Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
		public int current_consumed; /// Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
		public int energy_consumed; /// Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
		public byte battery_remaining; /// Remaining battery energy: (0%%: 0, 100%%: 100), -1: autopilot does not estimate the remaining battery
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=33)]
	public struct mavlink_setpoint_8dof_t
	{
		public byte target_system; /// System ID
		public float val1; /// Value 1
		public float val2; /// Value 2
		public float val3; /// Value 3
		public float val4; /// Value 4
		public float val5; /// Value 5
		public float val6; /// Value 6
		public float val7; /// Value 7
		public float val8; /// Value 8
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=25)]
	public struct mavlink_setpoint_6dof_t
	{
		public byte target_system; /// System ID
		public float trans_x; /// Translational Component in x
		public float trans_y; /// Translational Component in y
		public float trans_z; /// Translational Component in z
		public float rot_x; /// Rotational Component in x
		public float rot_y; /// Rotational Component in y
		public float rot_z; /// Rotational Component in z
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

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=42)]
	public struct mavlink_sensor_offsets_t
	{
		public short mag_ofs_x; /// magnetometer X offset
		public short mag_ofs_y; /// magnetometer Y offset
		public short mag_ofs_z; /// magnetometer Z offset
		public float mag_declination; /// magnetic declination (radians)
		public int raw_press; /// raw pressure from barometer
		public int raw_temp; /// raw temperature from barometer
		public float gyro_cal_x; /// gyro X calibration
		public float gyro_cal_y; /// gyro Y calibration
		public float gyro_cal_z; /// gyro Z calibration
		public float accel_cal_x; /// accel X calibration
		public float accel_cal_y; /// accel Y calibration
		public float accel_cal_z; /// accel Z calibration
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_set_mag_offsets_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public short mag_ofs_x; /// magnetometer X offset
		public short mag_ofs_y; /// magnetometer Y offset
		public short mag_ofs_z; /// magnetometer Z offset
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=4)]
	public struct mavlink_meminfo_t
	{
		public ushort brkval; /// heap top
		public ushort freemem; /// free memory
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_ap_adc_t
	{
		public ushort adc1; /// ADC output 1
		public ushort adc2; /// ADC output 2
		public ushort adc3; /// ADC output 3
		public ushort adc4; /// ADC output 4
		public ushort adc5; /// ADC output 5
		public ushort adc6; /// ADC output 6
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_digicam_configure_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte mode; /// Mode enumeration from 1 to N //P, TV, AV, M, Etc (0 means ignore)
		public ushort shutter_speed; /// Divisor number //e.g. 1000 means 1/1000 (0 means ignore)
		public byte aperture; /// F stop number x 10 //e.g. 28 means 2.8 (0 means ignore)
		public byte iso; /// ISO enumeration from 1 to N //e.g. 80, 100, 200, Etc (0 means ignore)
		public byte exposure_type; /// Exposure type enumeration from 1 to N (0 means ignore)
		public byte command_id; /// Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		public byte engine_cut_off; /// Main engine cut-off time before camera trigger in seconds/10 (0 means no cut-off)
		public byte extra_param; /// Extra parameters enumeration (0 means ignore)
		public float extra_value; /// Correspondent value to given extra_param
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=13)]
	public struct mavlink_digicam_control_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte session; /// 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
		public byte zoom_pos; /// 1 to N //Zoom's absolute position (0 means ignore)
		public byte zoom_step; /// -100 to 100 //Zooming step value to offset zoom from the current position
		public byte focus_lock; /// 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
		public byte shot; /// 0: ignore, 1: shot or start filming
		public byte command_id; /// Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
		public byte extra_param; /// Extra parameters enumeration (0 means ignore)
		public float extra_value; /// Correspondent value to given extra_param
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=6)]
	public struct mavlink_mount_configure_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte mount_mode; /// mount operating mode (see MAV_MOUNT_MODE enum)
		public byte stab_roll; /// (1 = yes, 0 = no)
		public byte stab_pitch; /// (1 = yes, 0 = no)
		public byte stab_yaw; /// (1 = yes, 0 = no)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=15)]
	public struct mavlink_mount_control_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public int input_a; /// pitch(deg*100) or lat, depending on mount mode
		public int input_b; /// roll(deg*100) or lon depending on mount mode
		public int input_c; /// yaw(deg*100) or alt (in cm) depending on mount mode
		public byte save_position; /// if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=14)]
	public struct mavlink_mount_status_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public int pointing_a; /// pitch(deg*100) or lat, depending on mount mode
		public int pointing_b; /// roll(deg*100) or lon depending on mount mode
		public int pointing_c; /// yaw(deg*100) or alt (in cm) depending on mount mode
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_fence_point_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte idx; /// point index (first point is 1, 0 is for return point)
		public byte count; /// total number of points (for sanity checking)
		public float lat; /// Latitude of point
		public float lng; /// Longitude of point
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_fence_fetch_point_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte idx; /// point index (first point is 1, 0 is for return point)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_fence_status_t
	{
		public byte breach_status; /// 0 if currently inside fence, 1 if outside
		public ushort breach_count; /// number of fence breaches
		public byte breach_type; /// last breach type (see FENCE_BREACH_* enum)
		public uint breach_time; /// time of last breach in milliseconds since boot
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=28)]
	public struct mavlink_ahrs_t
	{
		public float omegaIx; /// X gyro drift estimate rad/s
		public float omegaIy; /// Y gyro drift estimate rad/s
		public float omegaIz; /// Z gyro drift estimate rad/s
		public float accel_weight; /// average accel_weight
		public float renorm_val; /// average renormalisation value
		public float error_rp; /// average error_roll_pitch value
		public float error_yaw; /// average error_yaw value
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=44)]
	public struct mavlink_simstate_t
	{
		public float roll; /// Roll angle (rad)
		public float pitch; /// Pitch angle (rad)
		public float yaw; /// Yaw angle (rad)
		public float xacc; /// X acceleration m/s/s
		public float yacc; /// Y acceleration m/s/s
		public float zacc; /// Z acceleration m/s/s
		public float xgyro; /// Angular speed around X axis rad/s
		public float ygyro; /// Angular speed around Y axis rad/s
		public float zgyro; /// Angular speed around Z axis rad/s
		public int lat; /// Latitude in degrees * 1E7
		public int lng; /// Longitude in degrees * 1E7
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_hwstatus_t
	{
		public ushort Vcc; /// board voltage (mV)
		public byte I2Cerr; /// I2C error count
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=9)]
	public struct mavlink_radio_t
	{
		public byte rssi; /// local signal strength
		public byte remrssi; /// remote signal strength
		public byte txbuf; /// how full the tx buffer is as a percentage
		public byte noise; /// background noise level
		public byte remnoise; /// remote background noise level
		public ushort rxerrors; /// receive errors
		public ushort fixed; /// count of error corrected packets
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=22)]
	public struct mavlink_limits_status_t
	{
		public byte limits_state; /// state of AP_Limits, (see enum LimitState, LIMITS_STATE)
		public uint last_trigger; /// time of last breach in milliseconds since boot
		public uint last_action; /// time of last recovery action in milliseconds since boot
		public uint last_recovery; /// time of last successful recovery in milliseconds since boot
		public uint last_clear; /// time of last all-clear in milliseconds since boot
		public ushort breach_count; /// number of fence breaches
		public byte mods_enabled; /// AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)
		public byte mods_required; /// AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)
		public byte mods_triggered; /// AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=12)]
	public struct mavlink_wind_t
	{
		public float direction; /// wind direction that wind is coming from (degrees)
		public float speed; /// wind speed in ground plane (m/s)
		public float speed_z; /// vertical wind speed (m/s)
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_data16_t
	{
		public byte type; /// data type
		public byte len; /// data length
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=16)]
		public byte[] data; /// raw data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_data32_t
	{
		public byte type; /// data type
		public byte len; /// data length
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=32)]
		public byte[] data; /// raw data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_data64_t
	{
		public byte type; /// data type
		public byte len; /// data length
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=64)]
		public byte[] data; /// raw data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_data96_t
	{
		public byte type; /// data type
		public byte len; /// data length
		[MarshalAs(
			UnmanagedType.ByValArray,
			SizeConst=96)]
		public byte[] data; /// raw data
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=8)]
	public struct mavlink_rangefinder_t
	{
		public float distance; /// distance in meters
		public float voltage; /// raw voltage if available, zero otherwise
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=48)]
	public struct mavlink_airspeed_autocal_t
	{
		public float vx; /// GPS velocity north m/s
		public float vy; /// GPS velocity east m/s
		public float vz; /// GPS velocity down m/s
		public float diff_pressure; /// Differential pressure pascals
		public float EAS2TAS; /// Estimated to true airspeed ratio
		public float ratio; /// Airspeed ratio
		public float state_x; /// EKF state x
		public float state_y; /// EKF state y
		public float state_z; /// EKF state z
		public float Pax; /// EKF Pax
		public float Pby; /// EKF Pby
		public float Pcz; /// EKF Pcz
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=19)]
	public struct mavlink_rally_point_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte idx; /// point index (first point is 0)
		public byte count; /// total number of points (for sanity checking)
		public int lat; /// Latitude of point in degrees * 1E7
		public int lng; /// Longitude of point in degrees * 1E7
		public short alt; /// Transit / loiter altitude in meters relative to home
		public short break_alt; /// Break altitude in meters relative to home
		public ushort land_dir; /// Heading to aim for when landing. In centi-degrees.
		public byte flags; /// See RALLY_FLAGS enum for definition of the bitmask.
	};

	[StructLayout(LayoutKind.Sequential,Pack=1, Size=3)]
	public struct mavlink_rally_fetch_point_t
	{
		public byte target_system; /// System ID
		public byte target_component; /// Component ID
		public byte idx; /// point index (first point is 0)
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
			typeof( mavlink_set_local_position_setpoint_t),			// message 50
			typeof( mavlink_local_position_setpoint_t),			// message 51
			typeof( mavlink_global_position_setpoint_int_t),			// message 52
			typeof( mavlink_set_global_position_setpoint_int_t),			// message 53
			typeof( mavlink_safety_set_allowed_area_t),			// message 54
			typeof( mavlink_safety_allowed_area_t),			// message 55
			typeof( mavlink_set_roll_pitch_yaw_thrust_t),			// message 56
			typeof( mavlink_set_roll_pitch_yaw_speed_thrust_t),			// message 57
			typeof( mavlink_roll_pitch_yaw_thrust_setpoint_t),			// message 58
			typeof( mavlink_roll_pitch_yaw_speed_thrust_setpoint_t),			// message 59
			typeof( mavlink_set_quad_motors_setpoint_t),			// message 60
			typeof( mavlink_set_quad_swarm_roll_pitch_yaw_thrust_t),			// message 61
			typeof( mavlink_nav_controller_output_t),			// message 62
			typeof( mavlink_set_quad_swarm_led_roll_pitch_yaw_thrust_t),			// message 63
			typeof( mavlink_state_correction_t),			// message 64
			null,			 //message 65
			typeof( mavlink_request_data_stream_t),			// message 66
			typeof( mavlink_data_stream_t),			// message 67
			null,			 //message 68
			typeof( mavlink_manual_control_t),			// message 69
			typeof( mavlink_rc_channels_override_t),			// message 70
			null,			 //message 71
			null,			 //message 72
			null,			 //message 73
			typeof( mavlink_vfr_hud_t),			// message 74
			null,			 //message 75
			typeof( mavlink_command_long_t),			// message 76
			typeof( mavlink_command_ack_t),			// message 77
			null,			 //message 78
			null,			 //message 79
			typeof( mavlink_roll_pitch_yaw_rates_thrust_setpoint_t),			// message 80
			typeof( mavlink_manual_setpoint_t),			// message 81
			null,			 //message 82
			null,			 //message 83
			null,			 //message 84
			null,			 //message 85
			null,			 //message 86
			null,			 //message 87
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
			typeof( mavlink_omnidirectional_flow_t),			// message 106
			typeof( mavlink_hil_sensor_t),			// message 107
			typeof( mavlink_sim_state_t),			// message 108
			typeof( mavlink_radio_status_t),			// message 109
			typeof( mavlink_file_transfer_start_t),			// message 110
			typeof( mavlink_file_transfer_dir_list_t),			// message 111
			typeof( mavlink_file_transfer_res_t),			// message 112
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
			null,			 //message 123
			null,			 //message 124
			null,			 //message 125
			null,			 //message 126
			null,			 //message 127
			null,			 //message 128
			null,			 //message 129
			null,			 //message 130
			null,			 //message 131
			null,			 //message 132
			null,			 //message 133
			null,			 //message 134
			null,			 //message 135
			null,			 //message 136
			null,			 //message 137
			null,			 //message 138
			null,			 //message 139
			null,			 //message 140
			null,			 //message 141
			null,			 //message 142
			null,			 //message 143
			null,			 //message 144
			null,			 //message 145
			null,			 //message 146
			typeof( mavlink_battery_status_t),			// message 147
			typeof( mavlink_setpoint_8dof_t),			// message 148
			typeof( mavlink_setpoint_6dof_t),			// message 149
			typeof( mavlink_sensor_offsets_t),			// message 150
			typeof( mavlink_set_mag_offsets_t),			// message 151
			typeof( mavlink_meminfo_t),			// message 152
			typeof( mavlink_ap_adc_t),			// message 153
			typeof( mavlink_digicam_configure_t),			// message 154
			typeof( mavlink_digicam_control_t),			// message 155
			typeof( mavlink_mount_configure_t),			// message 156
			typeof( mavlink_mount_control_t),			// message 157
			typeof( mavlink_mount_status_t),			// message 158
			null,			 //message 159
			typeof( mavlink_fence_point_t),			// message 160
			typeof( mavlink_fence_fetch_point_t),			// message 161
			typeof( mavlink_fence_status_t),			// message 162
			typeof( mavlink_ahrs_t),			// message 163
			typeof( mavlink_simstate_t),			// message 164
			typeof( mavlink_hwstatus_t),			// message 165
			typeof( mavlink_radio_t),			// message 166
			typeof( mavlink_limits_status_t),			// message 167
			typeof( mavlink_wind_t),			// message 168
			typeof( mavlink_data16_t),			// message 169
			typeof( mavlink_data32_t),			// message 170
			typeof( mavlink_data64_t),			// message 171
			typeof( mavlink_data96_t),			// message 172
			typeof( mavlink_rangefinder_t),			// message 173
			typeof( mavlink_airspeed_autocal_t),			// message 174
			typeof( mavlink_rally_point_t),			// message 175
			typeof( mavlink_rally_fetch_point_t),			// message 176
			null,			 //message 177
			null,			 //message 178
			null,			 //message 179
			null,			 //message 180
			null,			 //message 181
			null,			 //message 182
			null,			 //message 183
			null,			 //message 184
			null,			 //message 185
			null,			 //message 186
			null,			 //message 187
			null,			 //message 188
			null,			 //message 189
			null,			 //message 190
			null,			 //message 191
			null,			 //message 192
			null,			 //message 193
			null,			 //message 194
			null,			 //message 195
			null,			 //message 196
			null,			 //message 197
			null,			 //message 198
			null,			 //message 199
			null,			 //message 200
			null,			 //message 201
			null,			 //message 202
			null,			 //message 203
			null,			 //message 204
			null,			 //message 205
			null,			 //message 206
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
			null,			 //message 248
			typeof( mavlink_memory_vect_t),			// message 249
			typeof( mavlink_debug_vect_t),			// message 250
			typeof( mavlink_named_value_float_t),			// message 251
			typeof( mavlink_named_value_int_t),			// message 252
			typeof( mavlink_statustext_t),			// message 253
			typeof( mavlink_debug_t),			// message 254
			null,			 //message 255
	};
