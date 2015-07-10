/*
                                {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255}
#define MAVLINK_MESSAGE_LENGTHS {  3,  4,  8, 14,  8, 28,  3, 32,  0,  2,  3,  2,  2,  0,  0,  0,  0,  0,  0,  0, 19,  2, 23, 21,  0, 37, 26,101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36,  4,  4,  2,  2,  4,  2,  2,  3, 14, 12, 18, 16,  8, 27, 25, 18, 18, 24, 24,  0,  0,  0, 26, 16, 36,  5,  6, 56, 26, 21, 18,  0,  0, 18, 20, 20,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 18,  0,  0,  0,  0,  0,  0,  0,  0,  0, 40, 72,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 30, 14, 14, 51,  5}
*/
#define MAVLINK_MESSAGE_LENGTHS {  5,  4,  8, 14,  8, 28,  3, 32,  0,  2,  3,  2,  2,  0,  0,  0,  0,  0,  0,  0, 19,  2, 23, 21,  0, 37, 26,101, 26, 16, 32, 32, 37, 32, 11, 17, 17, 16, 18, 36,  4,  4,  2,  2,  4,  2,  2,  3, 14, 12, 18, 16,  8, 27, 25, 18, 18, 24, 24,  0,  0,  0, 26, 16, 36,  5,  6, 56, 26, 21, 18,  0,  0, 18, 20, 20,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 18,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 40, 72, 12, 33, 11,  8, 12,  0,  0, 48, 48,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 36,  0,  0,  0,  0,  0,  0,  0,  0,  0, 42,  8,  4, 12, 15, 13,  6, 15, 14,  0, 12,  3,  8,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 30, 14, 14, 51,  5}
#define MAVLINK_MESSAGE_INFO {MAVLINK_MESSAGE_INFO_HEARTBEAT,MAVLINK_MESSAGE_INFO_BOOT,MAVLINK_MESSAGE_INFO_SYSTEM_TIME,MAVLINK_MESSAGE_INFO_PING,MAVLINK_MESSAGE_INFO_SYSTEM_TIME_UTC,MAVLINK_MESSAGE_INFO_CHANGE_OPERATOR_CONTROL,MAVLINK_MESSAGE_INFO_CHANGE_OPERATOR_CONTROL_ACK,MAVLINK_MESSAGE_INFO_AUTH_KEY,{NULL},MAVLINK_MESSAGE_INFO_ACTION_ACK,MAVLINK_MESSAGE_INFO_ACTION,MAVLINK_MESSAGE_INFO_SET_MODE,MAVLINK_MESSAGE_INFO_SET_NAV_MODE,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_PARAM_REQUEST_READ,MAVLINK_MESSAGE_INFO_PARAM_REQUEST_LIST,MAVLINK_MESSAGE_INFO_PARAM_VALUE,MAVLINK_MESSAGE_INFO_PARAM_SET,{NULL},MAVLINK_MESSAGE_INFO_GPS_RAW_INT,MAVLINK_MESSAGE_INFO_SCALED_IMU,MAVLINK_MESSAGE_INFO_GPS_STATUS,MAVLINK_MESSAGE_INFO_RAW_IMU,MAVLINK_MESSAGE_INFO_RAW_PRESSURE,MAVLINK_MESSAGE_INFO_ATTITUDE,MAVLINK_MESSAGE_INFO_LOCAL_POSITION,MAVLINK_MESSAGE_INFO_GPS_RAW,MAVLINK_MESSAGE_INFO_GLOBAL_POSITION,MAVLINK_MESSAGE_INFO_SYS_STATUS,MAVLINK_MESSAGE_INFO_RC_CHANNELS_RAW,MAVLINK_MESSAGE_INFO_RC_CHANNELS_SCALED,MAVLINK_MESSAGE_INFO_SERVO_OUTPUT_RAW,MAVLINK_MESSAGE_INFO_SCALED_PRESSURE,MAVLINK_MESSAGE_INFO_WAYPOINT,MAVLINK_MESSAGE_INFO_WAYPOINT_REQUEST,MAVLINK_MESSAGE_INFO_WAYPOINT_SET_CURRENT,MAVLINK_MESSAGE_INFO_WAYPOINT_CURRENT,MAVLINK_MESSAGE_INFO_WAYPOINT_REQUEST_LIST,MAVLINK_MESSAGE_INFO_WAYPOINT_COUNT,MAVLINK_MESSAGE_INFO_WAYPOINT_CLEAR_ALL,MAVLINK_MESSAGE_INFO_WAYPOINT_REACHED,MAVLINK_MESSAGE_INFO_WAYPOINT_ACK,MAVLINK_MESSAGE_INFO_GPS_SET_GLOBAL_ORIGIN,MAVLINK_MESSAGE_INFO_GPS_LOCAL_ORIGIN_SET,MAVLINK_MESSAGE_INFO_LOCAL_POSITION_SETPOINT_SET,MAVLINK_MESSAGE_INFO_LOCAL_POSITION_SETPOINT,MAVLINK_MESSAGE_INFO_CONTROL_STATUS,MAVLINK_MESSAGE_INFO_SAFETY_SET_ALLOWED_AREA,MAVLINK_MESSAGE_INFO_SAFETY_ALLOWED_AREA,MAVLINK_MESSAGE_INFO_SET_ROLL_PITCH_YAW_THRUST,MAVLINK_MESSAGE_INFO_SET_ROLL_PITCH_YAW_SPEED_THRUST,MAVLINK_MESSAGE_INFO_ROLL_PITCH_YAW_THRUST_SETPOINT,MAVLINK_MESSAGE_INFO_ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT,{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_NAV_CONTROLLER_OUTPUT,MAVLINK_MESSAGE_INFO_POSITION_TARGET,MAVLINK_MESSAGE_INFO_STATE_CORRECTION,MAVLINK_MESSAGE_INFO_SET_ALTITUDE,MAVLINK_MESSAGE_INFO_REQUEST_DATA_STREAM,MAVLINK_MESSAGE_INFO_HIL_STATE,MAVLINK_MESSAGE_INFO_HIL_CONTROLS,MAVLINK_MESSAGE_INFO_MANUAL_CONTROL,MAVLINK_MESSAGE_INFO_RC_CHANNELS_OVERRIDE,{NULL},{NULL},MAVLINK_MESSAGE_INFO_GLOBAL_POSITION_INT,MAVLINK_MESSAGE_INFO_VFR_HUD,MAVLINK_MESSAGE_INFO_COMMAND,MAVLINK_MESSAGE_INFO_COMMAND_ACK,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_OPTICAL_FLOW,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_ANALOG_RAW,MAVLINK_MESSAGE_INFO_ANALOG_EU,MAVLINK_MESSAGE_INFO_CDNR_CONTROLLER,MAVLINK_MESSAGE_INFO_TRAFFIC_DATA,MAVLINK_MESSAGE_INFO_STATE_DATA,MAVLINK_MESSAGE_INFO_TRAFFIC_SIM_TIMING,MAVLINK_MESSAGE_INFO_STATE_DATA_AUG,{NULL},{NULL},MAVLINK_MESSAGE_INFO_BHM_SOC_EOD_RUL,MAVLINK_MESSAGE_INFO_BHM_CURRENT_VOLTAGE,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_OBJECT_DETECTION_EVENT,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_SENSOR_OFFSETS,MAVLINK_MESSAGE_INFO_SET_MAG_OFFSETS,MAVLINK_MESSAGE_INFO_MEMINFO,MAVLINK_MESSAGE_INFO_AP_ADC,MAVLINK_MESSAGE_INFO_DIGICAM_CONFIGURE,MAVLINK_MESSAGE_INFO_DIGICAM_CONTROL,MAVLINK_MESSAGE_INFO_MOUNT_CONFIGURE,MAVLINK_MESSAGE_INFO_MOUNT_CONTROL,MAVLINK_MESSAGE_INFO_MOUNT_STATUS,{NULL},MAVLINK_MESSAGE_INFO_FENCE_POINT,MAVLINK_MESSAGE_INFO_FENCE_FETCH_POINT,MAVLINK_MESSAGE_INFO_FENCE_STATUS,{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},{NULL},MAVLINK_MESSAGE_INFO_DEBUG_VECT,MAVLINK_MESSAGE_INFO_NAMED_VALUE_FLOAT,MAVLINK_MESSAGE_INFO_NAMED_VALUE_INT,MAVLINK_MESSAGE_INFO_STATUSTEXT,MAVLINK_MESSAGE_INFO_DEBUG}