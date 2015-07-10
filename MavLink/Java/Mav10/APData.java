/**
 * @author svazquez
 *
 */
public class APData
{
	public static HEARTBEAT_class								HEARTBEAT								= new HEARTBEAT_class();								// (0)
	public static SYS_STATUS_class								SYS_STATUS								= new SYS_STATUS_class();								// (1)
	public static SYSTEM_TIME_class								SYSTEM_TIME								= new SYSTEM_TIME_class();								// (2)
	public static PING_class									PING									= new PING_class();									// (4)
	public static CHANGE_OPERATOR_CONTROL_class					CHANGE_OPERATOR_CONTROL					= new CHANGE_OPERATOR_CONTROL_class();					// (5)
	public static CHANGE_OPERATOR_CONTROL_ACK_class				CHANGE_OPERATOR_CONTROL_ACK				= new CHANGE_OPERATOR_CONTROL_ACK_class();				// (6)
	public static AUTH_KEY_class								AUTH_KEY								= new AUTH_KEY_class();								// (7)
	public static SET_MODE_class								SET_MODE								= new SET_MODE_class();								// (11)
	public static PARAM_REQUEST_READ_class						PARAM_REQUEST_READ						= new PARAM_REQUEST_READ_class();						// (20)
	public static PARAM_REQUEST_LIST_class						PARAM_REQUEST_LIST						= new PARAM_REQUEST_LIST_class();						// (21)
	public static PARAM_VALUE_class								PARAM_VALUE								= new PARAM_VALUE_class();								// (22)
	public static PARAM_SET_class								PARAM_SET								= new PARAM_SET_class();								// (23)
	public static GPS_RAW_INT_class								GPS_RAW_INT								= new GPS_RAW_INT_class();								// (24)
	public static GPS_STATUS_class								GPS_STATUS								= new GPS_STATUS_class();								// (25)
	public static SCALED_IMU_class								SCALED_IMU								= new SCALED_IMU_class();								// (26)
	public static RAW_IMU_class									RAW_IMU									= new RAW_IMU_class();									// (27)
	public static RAW_PRESSURE_class							RAW_PRESSURE							= new RAW_PRESSURE_class();							// (28)
	public static SCALED_PRESSURE_class							SCALED_PRESSURE							= new SCALED_PRESSURE_class();							// (29)
	public static ATTITUDE_class								ATTITUDE								= new ATTITUDE_class();								// (30)
	public static ATTITUDE_QUATERNION_class						ATTITUDE_QUATERNION						= new ATTITUDE_QUATERNION_class();						// (31)
	public static LOCAL_POSITION_NED_class						LOCAL_POSITION_NED						= new LOCAL_POSITION_NED_class();						// (32)
	public static GLOBAL_POSITION_INT_class						GLOBAL_POSITION_INT						= new GLOBAL_POSITION_INT_class();						// (33)
	public static RC_CHANNELS_SCALED_class						RC_CHANNELS_SCALED						= new RC_CHANNELS_SCALED_class();						// (34)
	public static RC_CHANNELS_RAW_class							RC_CHANNELS_RAW							= new RC_CHANNELS_RAW_class();							// (35)
	public static SERVO_OUTPUT_RAW_class						SERVO_OUTPUT_RAW						= new SERVO_OUTPUT_RAW_class();						// (36)
	public static MISSION_REQUEST_PARTIAL_LIST_class			MISSION_REQUEST_PARTIAL_LIST			= new MISSION_REQUEST_PARTIAL_LIST_class();			// (37)
	public static MISSION_WRITE_PARTIAL_LIST_class				MISSION_WRITE_PARTIAL_LIST				= new MISSION_WRITE_PARTIAL_LIST_class();				// (38)
	public static MISSION_ITEM_class							MISSION_ITEM							= new MISSION_ITEM_class();							// (39)
	public static MISSION_REQUEST_class							MISSION_REQUEST							= new MISSION_REQUEST_class();							// (40)
	public static MISSION_SET_CURRENT_class						MISSION_SET_CURRENT						= new MISSION_SET_CURRENT_class();						// (41)
	public static MISSION_CURRENT_class							MISSION_CURRENT							= new MISSION_CURRENT_class();							// (42)
	public static MISSION_REQUEST_LIST_class					MISSION_REQUEST_LIST					= new MISSION_REQUEST_LIST_class();					// (43)
	public static MISSION_COUNT_class							MISSION_COUNT							= new MISSION_COUNT_class();							// (44)
	public static MISSION_CLEAR_ALL_class						MISSION_CLEAR_ALL						= new MISSION_CLEAR_ALL_class();						// (45)
	public static MISSION_ITEM_REACHED_class					MISSION_ITEM_REACHED					= new MISSION_ITEM_REACHED_class();					// (46)
	public static MISSION_ACK_class								MISSION_ACK								= new MISSION_ACK_class();								// (47)
	public static SET_GPS_GLOBAL_ORIGIN_class					SET_GPS_GLOBAL_ORIGIN					= new SET_GPS_GLOBAL_ORIGIN_class();					// (48)
	public static GPS_GLOBAL_ORIGIN_class						GPS_GLOBAL_ORIGIN						= new GPS_GLOBAL_ORIGIN_class();						// (49)
	public static SET_LOCAL_POSITION_SETPOINT_class				SET_LOCAL_POSITION_SETPOINT				= new SET_LOCAL_POSITION_SETPOINT_class();				// (50)
	public static LOCAL_POSITION_SETPOINT_class					LOCAL_POSITION_SETPOINT					= new LOCAL_POSITION_SETPOINT_class();					// (51)
	public static GLOBAL_POSITION_SETPOINT_INT_class			GLOBAL_POSITION_SETPOINT_INT			= new GLOBAL_POSITION_SETPOINT_INT_class();			// (52)
	public static SET_GLOBAL_POSITION_SETPOINT_INT_class		SET_GLOBAL_POSITION_SETPOINT_INT		= new SET_GLOBAL_POSITION_SETPOINT_INT_class();		// (53)
	public static SAFETY_SET_ALLOWED_AREA_class					SAFETY_SET_ALLOWED_AREA					= new SAFETY_SET_ALLOWED_AREA_class();					// (54)
	public static SAFETY_ALLOWED_AREA_class						SAFETY_ALLOWED_AREA						= new SAFETY_ALLOWED_AREA_class();						// (55)
	public static SET_ROLL_PITCH_YAW_THRUST_class				SET_ROLL_PITCH_YAW_THRUST				= new SET_ROLL_PITCH_YAW_THRUST_class();				// (56)
	public static SET_ROLL_PITCH_YAW_SPEED_THRUST_class			SET_ROLL_PITCH_YAW_SPEED_THRUST			= new SET_ROLL_PITCH_YAW_SPEED_THRUST_class();			// (57)
	public static ROLL_PITCH_YAW_THRUST_SETPOINT_class			ROLL_PITCH_YAW_THRUST_SETPOINT			= new ROLL_PITCH_YAW_THRUST_SETPOINT_class();			// (58)
	public static ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class	ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT	= new ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class();	// (59)
	public static SET_QUAD_MOTORS_SETPOINT_class				SET_QUAD_MOTORS_SETPOINT				= new SET_QUAD_MOTORS_SETPOINT_class();				// (60)
	public static SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class	SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST	= new SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST_class();	// (61)
	public static NAV_CONTROLLER_OUTPUT_class					NAV_CONTROLLER_OUTPUT					= new NAV_CONTROLLER_OUTPUT_class();					// (62)
	public static SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_class	SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST	= new SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST_class();	// (63)
	public static STATE_CORRECTION_class						STATE_CORRECTION						= new STATE_CORRECTION_class();						// (64)
	public static REQUEST_DATA_STREAM_class						REQUEST_DATA_STREAM						= new REQUEST_DATA_STREAM_class();						// (66)
	public static DATA_STREAM_class								DATA_STREAM								= new DATA_STREAM_class();								// (67)
	public static MANUAL_CONTROL_class							MANUAL_CONTROL							= new MANUAL_CONTROL_class();							// (69)
	public static RC_CHANNELS_OVERRIDE_class					RC_CHANNELS_OVERRIDE					= new RC_CHANNELS_OVERRIDE_class();					// (70)
	public static VFR_HUD_class									VFR_HUD									= new VFR_HUD_class();									// (74)
	public static COMMAND_LONG_class							COMMAND_LONG							= new COMMAND_LONG_class();							// (76)
	public static COMMAND_ACK_class								COMMAND_ACK								= new COMMAND_ACK_class();								// (77)
	public static ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class	ROLL_PITCH_YAW_RATES_THRUST_SETPOINT	= new ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class();	// (80)
	public static MANUAL_SETPOINT_class							MANUAL_SETPOINT							= new MANUAL_SETPOINT_class();							// (81)
	public static LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_class	LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET	= new LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_class();	// (89)
	public static HIL_STATE_class								HIL_STATE								= new HIL_STATE_class();								// (90)
	public static HIL_CONTROLS_class							HIL_CONTROLS							= new HIL_CONTROLS_class();							// (91)
	public static HIL_RC_INPUTS_RAW_class						HIL_RC_INPUTS_RAW						= new HIL_RC_INPUTS_RAW_class();						// (92)
	public static OPTICAL_FLOW_class							OPTICAL_FLOW							= new OPTICAL_FLOW_class();							// (100)
	public static GLOBAL_VISION_POSITION_ESTIMATE_class			GLOBAL_VISION_POSITION_ESTIMATE			= new GLOBAL_VISION_POSITION_ESTIMATE_class();			// (101)
	public static VISION_POSITION_ESTIMATE_class				VISION_POSITION_ESTIMATE				= new VISION_POSITION_ESTIMATE_class();				// (102)
	public static VISION_SPEED_ESTIMATE_class					VISION_SPEED_ESTIMATE					= new VISION_SPEED_ESTIMATE_class();					// (103)
	public static VICON_POSITION_ESTIMATE_class					VICON_POSITION_ESTIMATE					= new VICON_POSITION_ESTIMATE_class();					// (104)
	public static HIGHRES_IMU_class								HIGHRES_IMU								= new HIGHRES_IMU_class();								// (105)
	public static OMNIDIRECTIONAL_FLOW_class					OMNIDIRECTIONAL_FLOW					= new OMNIDIRECTIONAL_FLOW_class();					// (106)
	public static HIL_SENSOR_class								HIL_SENSOR								= new HIL_SENSOR_class();								// (107)
	public static SIM_STATE_class								SIM_STATE								= new SIM_STATE_class();								// (108)
	public static RADIO_STATUS_class							RADIO_STATUS							= new RADIO_STATUS_class();							// (109)
	public static FILE_TRANSFER_START_class						FILE_TRANSFER_START						= new FILE_TRANSFER_START_class();						// (110)
	public static FILE_TRANSFER_DIR_LIST_class					FILE_TRANSFER_DIR_LIST					= new FILE_TRANSFER_DIR_LIST_class();					// (111)
	public static FILE_TRANSFER_RES_class						FILE_TRANSFER_RES						= new FILE_TRANSFER_RES_class();						// (112)
	public static HIL_GPS_class									HIL_GPS									= new HIL_GPS_class();									// (113)
	public static HIL_OPTICAL_FLOW_class						HIL_OPTICAL_FLOW						= new HIL_OPTICAL_FLOW_class();						// (114)
	public static HIL_STATE_QUATERNION_class					HIL_STATE_QUATERNION					= new HIL_STATE_QUATERNION_class();					// (115)
	public static SCALED_IMU2_class								SCALED_IMU2								= new SCALED_IMU2_class();								// (116)
	public static LOG_REQUEST_LIST_class						LOG_REQUEST_LIST						= new LOG_REQUEST_LIST_class();						// (117)
	public static LOG_ENTRY_class								LOG_ENTRY								= new LOG_ENTRY_class();								// (118)
	public static LOG_REQUEST_DATA_class						LOG_REQUEST_DATA						= new LOG_REQUEST_DATA_class();						// (119)
	public static LOG_DATA_class								LOG_DATA								= new LOG_DATA_class();								// (120)
	public static LOG_ERASE_class								LOG_ERASE								= new LOG_ERASE_class();								// (121)
	public static LOG_REQUEST_END_class							LOG_REQUEST_END							= new LOG_REQUEST_END_class();							// (122)
	public static BATTERY_STATUS_class							BATTERY_STATUS							= new BATTERY_STATUS_class();							// (147)
	public static SETPOINT_8DOF_class							SETPOINT_8DOF							= new SETPOINT_8DOF_class();							// (148)
	public static SETPOINT_6DOF_class							SETPOINT_6DOF							= new SETPOINT_6DOF_class();							// (149)
	public static MEMORY_VECT_class								MEMORY_VECT								= new MEMORY_VECT_class();								// (249)
	public static DEBUG_VECT_class								DEBUG_VECT								= new DEBUG_VECT_class();								// (250)
	public static NAMED_VALUE_FLOAT_class						NAMED_VALUE_FLOAT						= new NAMED_VALUE_FLOAT_class();						// (251)
	public static NAMED_VALUE_INT_class							NAMED_VALUE_INT							= new NAMED_VALUE_INT_class();							// (252)
	public static STATUSTEXT_class								STATUSTEXT								= new STATUSTEXT_class();								// (253)
	public static DEBUG_class									DEBUG									= new DEBUG_class();									// (254)
	public static SENSOR_OFFSETS_class							SENSOR_OFFSETS							= new SENSOR_OFFSETS_class();							// (150)
	public static SET_MAG_OFFSETS_class							SET_MAG_OFFSETS							= new SET_MAG_OFFSETS_class();							// (151)
	public static MEMINFO_class									MEMINFO									= new MEMINFO_class();									// (152)
	public static AP_ADC_class									AP_ADC									= new AP_ADC_class();									// (153)
	public static DIGICAM_CONFIGURE_class						DIGICAM_CONFIGURE						= new DIGICAM_CONFIGURE_class();						// (154)
	public static DIGICAM_CONTROL_class							DIGICAM_CONTROL							= new DIGICAM_CONTROL_class();							// (155)
	public static MOUNT_CONFIGURE_class							MOUNT_CONFIGURE							= new MOUNT_CONFIGURE_class();							// (156)
	public static MOUNT_CONTROL_class							MOUNT_CONTROL							= new MOUNT_CONTROL_class();							// (157)
	public static MOUNT_STATUS_class							MOUNT_STATUS							= new MOUNT_STATUS_class();							// (158)
	public static FENCE_POINT_class								FENCE_POINT								= new FENCE_POINT_class();								// (160)
	public static FENCE_FETCH_POINT_class						FENCE_FETCH_POINT						= new FENCE_FETCH_POINT_class();						// (161)
	public static FENCE_STATUS_class							FENCE_STATUS							= new FENCE_STATUS_class();							// (162)
	public static AHRS_class									AHRS									= new AHRS_class();									// (163)
	public static SIMSTATE_class								SIMSTATE								= new SIMSTATE_class();								// (164)
	public static HWSTATUS_class								HWSTATUS								= new HWSTATUS_class();								// (165)
	public static RADIO_class									RADIO									= new RADIO_class();									// (166)
	public static LIMITS_STATUS_class							LIMITS_STATUS							= new LIMITS_STATUS_class();							// (167)
	public static WIND_class									WIND									= new WIND_class();									// (168)
	public static DATA16_class									DATA16									= new DATA16_class();									// (169)
	public static DATA32_class									DATA32									= new DATA32_class();									// (170)
	public static DATA64_class									DATA64									= new DATA64_class();									// (171)
	public static DATA96_class									DATA96									= new DATA96_class();									// (172)
	public static RANGEFINDER_class								RANGEFINDER								= new RANGEFINDER_class();								// (173)
	public static AIRSPEED_AUTOCAL_class						AIRSPEED_AUTOCAL						= new AIRSPEED_AUTOCAL_class();						// (174)
	public static RALLY_POINT_class								RALLY_POINT								= new RALLY_POINT_class();								// (175)
	public static RALLY_FETCH_POINT_class						RALLY_FETCH_POINT						= new RALLY_FETCH_POINT_class();						// (176)

	public static boolean processPacket(byte[] pkt, boolean valid)
	{
		switch(pkt[5])
		{
			case (byte)0:	return(HEARTBEAT.parse(pkt, valid));
			case (byte)1:	return(SYS_STATUS.parse(pkt, valid));
			case (byte)2:	return(SYSTEM_TIME.parse(pkt, valid));
			case (byte)4:	return(PING.parse(pkt, valid));
			case (byte)5:	return(CHANGE_OPERATOR_CONTROL.parse(pkt, valid));
			case (byte)6:	return(CHANGE_OPERATOR_CONTROL_ACK.parse(pkt, valid));
			case (byte)7:	return(AUTH_KEY.parse(pkt, valid));
			case (byte)11:	return(SET_MODE.parse(pkt, valid));
			case (byte)20:	return(PARAM_REQUEST_READ.parse(pkt, valid));
			case (byte)21:	return(PARAM_REQUEST_LIST.parse(pkt, valid));
			case (byte)22:	return(PARAM_VALUE.parse(pkt, valid));
			case (byte)23:	return(PARAM_SET.parse(pkt, valid));
			case (byte)24:	return(GPS_RAW_INT.parse(pkt, valid));
			case (byte)25:	return(GPS_STATUS.parse(pkt, valid));
			case (byte)26:	return(SCALED_IMU.parse(pkt, valid));
			case (byte)27:	return(RAW_IMU.parse(pkt, valid));
			case (byte)28:	return(RAW_PRESSURE.parse(pkt, valid));
			case (byte)29:	return(SCALED_PRESSURE.parse(pkt, valid));
			case (byte)30:	return(ATTITUDE.parse(pkt, valid));
			case (byte)31:	return(ATTITUDE_QUATERNION.parse(pkt, valid));
			case (byte)32:	return(LOCAL_POSITION_NED.parse(pkt, valid));
			case (byte)33:	return(GLOBAL_POSITION_INT.parse(pkt, valid));
			case (byte)34:	return(RC_CHANNELS_SCALED.parse(pkt, valid));
			case (byte)35:	return(RC_CHANNELS_RAW.parse(pkt, valid));
			case (byte)36:	return(SERVO_OUTPUT_RAW.parse(pkt, valid));
			case (byte)37:	return(MISSION_REQUEST_PARTIAL_LIST.parse(pkt, valid));
			case (byte)38:	return(MISSION_WRITE_PARTIAL_LIST.parse(pkt, valid));
			case (byte)39:	return(MISSION_ITEM.parse(pkt, valid));
			case (byte)40:	return(MISSION_REQUEST.parse(pkt, valid));
			case (byte)41:	return(MISSION_SET_CURRENT.parse(pkt, valid));
			case (byte)42:	return(MISSION_CURRENT.parse(pkt, valid));
			case (byte)43:	return(MISSION_REQUEST_LIST.parse(pkt, valid));
			case (byte)44:	return(MISSION_COUNT.parse(pkt, valid));
			case (byte)45:	return(MISSION_CLEAR_ALL.parse(pkt, valid));
			case (byte)46:	return(MISSION_ITEM_REACHED.parse(pkt, valid));
			case (byte)47:	return(MISSION_ACK.parse(pkt, valid));
			case (byte)48:	return(SET_GPS_GLOBAL_ORIGIN.parse(pkt, valid));
			case (byte)49:	return(GPS_GLOBAL_ORIGIN.parse(pkt, valid));
			case (byte)50:	return(SET_LOCAL_POSITION_SETPOINT.parse(pkt, valid));
			case (byte)51:	return(LOCAL_POSITION_SETPOINT.parse(pkt, valid));
			case (byte)52:	return(GLOBAL_POSITION_SETPOINT_INT.parse(pkt, valid));
			case (byte)53:	return(SET_GLOBAL_POSITION_SETPOINT_INT.parse(pkt, valid));
			case (byte)54:	return(SAFETY_SET_ALLOWED_AREA.parse(pkt, valid));
			case (byte)55:	return(SAFETY_ALLOWED_AREA.parse(pkt, valid));
			case (byte)56:	return(SET_ROLL_PITCH_YAW_THRUST.parse(pkt, valid));
			case (byte)57:	return(SET_ROLL_PITCH_YAW_SPEED_THRUST.parse(pkt, valid));
			case (byte)58:	return(ROLL_PITCH_YAW_THRUST_SETPOINT.parse(pkt, valid));
			case (byte)59:	return(ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT.parse(pkt, valid));
			case (byte)60:	return(SET_QUAD_MOTORS_SETPOINT.parse(pkt, valid));
			case (byte)61:	return(SET_QUAD_SWARM_ROLL_PITCH_YAW_THRUST.parse(pkt, valid));
			case (byte)62:	return(NAV_CONTROLLER_OUTPUT.parse(pkt, valid));
			case (byte)63:	return(SET_QUAD_SWARM_LED_ROLL_PITCH_YAW_THRUST.parse(pkt, valid));
			case (byte)64:	return(STATE_CORRECTION.parse(pkt, valid));
			case (byte)66:	return(REQUEST_DATA_STREAM.parse(pkt, valid));
			case (byte)67:	return(DATA_STREAM.parse(pkt, valid));
			case (byte)69:	return(MANUAL_CONTROL.parse(pkt, valid));
			case (byte)70:	return(RC_CHANNELS_OVERRIDE.parse(pkt, valid));
			case (byte)74:	return(VFR_HUD.parse(pkt, valid));
			case (byte)76:	return(COMMAND_LONG.parse(pkt, valid));
			case (byte)77:	return(COMMAND_ACK.parse(pkt, valid));
			case (byte)80:	return(ROLL_PITCH_YAW_RATES_THRUST_SETPOINT.parse(pkt, valid));
			case (byte)81:	return(MANUAL_SETPOINT.parse(pkt, valid));
			case (byte)89:	return(LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET.parse(pkt, valid));
			case (byte)90:	return(HIL_STATE.parse(pkt, valid));
			case (byte)91:	return(HIL_CONTROLS.parse(pkt, valid));
			case (byte)92:	return(HIL_RC_INPUTS_RAW.parse(pkt, valid));
			case (byte)100:	return(OPTICAL_FLOW.parse(pkt, valid));
			case (byte)101:	return(GLOBAL_VISION_POSITION_ESTIMATE.parse(pkt, valid));
			case (byte)102:	return(VISION_POSITION_ESTIMATE.parse(pkt, valid));
			case (byte)103:	return(VISION_SPEED_ESTIMATE.parse(pkt, valid));
			case (byte)104:	return(VICON_POSITION_ESTIMATE.parse(pkt, valid));
			case (byte)105:	return(HIGHRES_IMU.parse(pkt, valid));
			case (byte)106:	return(OMNIDIRECTIONAL_FLOW.parse(pkt, valid));
			case (byte)107:	return(HIL_SENSOR.parse(pkt, valid));
			case (byte)108:	return(SIM_STATE.parse(pkt, valid));
			case (byte)109:	return(RADIO_STATUS.parse(pkt, valid));
			case (byte)110:	return(FILE_TRANSFER_START.parse(pkt, valid));
			case (byte)111:	return(FILE_TRANSFER_DIR_LIST.parse(pkt, valid));
			case (byte)112:	return(FILE_TRANSFER_RES.parse(pkt, valid));
			case (byte)113:	return(HIL_GPS.parse(pkt, valid));
			case (byte)114:	return(HIL_OPTICAL_FLOW.parse(pkt, valid));
			case (byte)115:	return(HIL_STATE_QUATERNION.parse(pkt, valid));
			case (byte)116:	return(SCALED_IMU2.parse(pkt, valid));
			case (byte)117:	return(LOG_REQUEST_LIST.parse(pkt, valid));
			case (byte)118:	return(LOG_ENTRY.parse(pkt, valid));
			case (byte)119:	return(LOG_REQUEST_DATA.parse(pkt, valid));
			case (byte)120:	return(LOG_DATA.parse(pkt, valid));
			case (byte)121:	return(LOG_ERASE.parse(pkt, valid));
			case (byte)122:	return(LOG_REQUEST_END.parse(pkt, valid));
			case (byte)147:	return(BATTERY_STATUS.parse(pkt, valid));
			case (byte)148:	return(SETPOINT_8DOF.parse(pkt, valid));
			case (byte)149:	return(SETPOINT_6DOF.parse(pkt, valid));
			case (byte)249:	return(MEMORY_VECT.parse(pkt, valid));
			case (byte)250:	return(DEBUG_VECT.parse(pkt, valid));
			case (byte)251:	return(NAMED_VALUE_FLOAT.parse(pkt, valid));
			case (byte)252:	return(NAMED_VALUE_INT.parse(pkt, valid));
			case (byte)253:	return(STATUSTEXT.parse(pkt, valid));
			case (byte)254:	return(DEBUG.parse(pkt, valid));
			case (byte)150:	return(SENSOR_OFFSETS.parse(pkt, valid));
			case (byte)151:	return(SET_MAG_OFFSETS.parse(pkt, valid));
			case (byte)152:	return(MEMINFO.parse(pkt, valid));
			case (byte)153:	return(AP_ADC.parse(pkt, valid));
			case (byte)154:	return(DIGICAM_CONFIGURE.parse(pkt, valid));
			case (byte)155:	return(DIGICAM_CONTROL.parse(pkt, valid));
			case (byte)156:	return(MOUNT_CONFIGURE.parse(pkt, valid));
			case (byte)157:	return(MOUNT_CONTROL.parse(pkt, valid));
			case (byte)158:	return(MOUNT_STATUS.parse(pkt, valid));
			case (byte)160:	return(FENCE_POINT.parse(pkt, valid));
			case (byte)161:	return(FENCE_FETCH_POINT.parse(pkt, valid));
			case (byte)162:	return(FENCE_STATUS.parse(pkt, valid));
			case (byte)163:	return(AHRS.parse(pkt, valid));
			case (byte)164:	return(SIMSTATE.parse(pkt, valid));
			case (byte)165:	return(HWSTATUS.parse(pkt, valid));
			case (byte)166:	return(RADIO.parse(pkt, valid));
			case (byte)167:	return(LIMITS_STATUS.parse(pkt, valid));
			case (byte)168:	return(WIND.parse(pkt, valid));
			case (byte)169:	return(DATA16.parse(pkt, valid));
			case (byte)170:	return(DATA32.parse(pkt, valid));
			case (byte)171:	return(DATA64.parse(pkt, valid));
			case (byte)172:	return(DATA96.parse(pkt, valid));
			case (byte)173:	return(RANGEFINDER.parse(pkt, valid));
			case (byte)174:	return(AIRSPEED_AUTOCAL.parse(pkt, valid));
			case (byte)175:	return(RALLY_POINT.parse(pkt, valid));
			case (byte)176:	return(RALLY_FETCH_POINT.parse(pkt, valid));
			default:
				return(false);
		}
	}

	public static void initMessages()
	{
		PING.target_system = 1;
		PING.target_component = 1;
		CHANGE_OPERATOR_CONTROL.target_system = 1;
		SET_MODE.target_system = 1;
		PARAM_REQUEST_READ.target_system = 1;
		PARAM_REQUEST_READ.target_component = 1;
		PARAM_REQUEST_LIST.target_system = 1;
		PARAM_REQUEST_LIST.target_component = 1;
		PARAM_SET.target_system = 1;
		PARAM_SET.target_component = 1;
		MISSION_REQUEST_PARTIAL_LIST.target_system = 1;
		MISSION_REQUEST_PARTIAL_LIST.target_component = 1;
		MISSION_WRITE_PARTIAL_LIST.target_system = 1;
		MISSION_WRITE_PARTIAL_LIST.target_component = 1;
		MISSION_ITEM.target_system = 1;
		MISSION_ITEM.target_component = 1;
		MISSION_REQUEST.target_system = 1;
		MISSION_REQUEST.target_component = 1;
		MISSION_SET_CURRENT.target_system = 1;
		MISSION_SET_CURRENT.target_component = 1;
		MISSION_REQUEST_LIST.target_system = 1;
		MISSION_REQUEST_LIST.target_component = 1;
		MISSION_COUNT.target_system = 1;
		MISSION_COUNT.target_component = 1;
		MISSION_CLEAR_ALL.target_system = 1;
		MISSION_CLEAR_ALL.target_component = 1;
		MISSION_ACK.target_system = 1;
		MISSION_ACK.target_component = 1;
		SET_GPS_GLOBAL_ORIGIN.target_system = 1;
		SET_LOCAL_POSITION_SETPOINT.target_system = 1;
		SET_LOCAL_POSITION_SETPOINT.target_component = 1;
		SAFETY_SET_ALLOWED_AREA.target_system = 1;
		SAFETY_SET_ALLOWED_AREA.target_component = 1;
		SET_ROLL_PITCH_YAW_THRUST.target_system = 1;
		SET_ROLL_PITCH_YAW_THRUST.target_component = 1;
		SET_ROLL_PITCH_YAW_SPEED_THRUST.target_system = 1;
		SET_ROLL_PITCH_YAW_SPEED_THRUST.target_component = 1;
		SET_QUAD_MOTORS_SETPOINT.target_system = 1;
		REQUEST_DATA_STREAM.target_system = 1;
		REQUEST_DATA_STREAM.target_component = 1;
		RC_CHANNELS_OVERRIDE.target_system = 1;
		RC_CHANNELS_OVERRIDE.target_component = 1;
		COMMAND_LONG.target_system = 1;
		COMMAND_LONG.target_component = 1;
		LOG_REQUEST_LIST.target_system = 1;
		LOG_REQUEST_LIST.target_component = 1;
		LOG_REQUEST_DATA.target_system = 1;
		LOG_REQUEST_DATA.target_component = 1;
		LOG_ERASE.target_system = 1;
		LOG_ERASE.target_component = 1;
		LOG_REQUEST_END.target_system = 1;
		LOG_REQUEST_END.target_component = 1;
		SETPOINT_8DOF.target_system = 1;
		SETPOINT_6DOF.target_system = 1;
		SET_MAG_OFFSETS.target_system = 1;
		SET_MAG_OFFSETS.target_component = 1;
		DIGICAM_CONFIGURE.target_system = 1;
		DIGICAM_CONFIGURE.target_component = 1;
		DIGICAM_CONTROL.target_system = 1;
		DIGICAM_CONTROL.target_component = 1;
		MOUNT_CONFIGURE.target_system = 1;
		MOUNT_CONFIGURE.target_component = 1;
		MOUNT_CONTROL.target_system = 1;
		MOUNT_CONTROL.target_component = 1;
		MOUNT_STATUS.target_system = 1;
		MOUNT_STATUS.target_component = 1;
		FENCE_POINT.target_system = 1;
		FENCE_POINT.target_component = 1;
		FENCE_FETCH_POINT.target_system = 1;
		FENCE_FETCH_POINT.target_component = 1;
		RALLY_POINT.target_system = 1;
		RALLY_POINT.target_component = 1;
		RALLY_FETCH_POINT.target_system = 1;
		RALLY_FETCH_POINT.target_component = 1;
	}
}
