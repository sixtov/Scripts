/**
 * @author svazquez
 *
 */
public class APData
{
	public static ANALOG_RAW_class							ANALOG_RAW							= new ANALOG_RAW_class();							// (111)
	public static ANALOG_EU_class							ANALOG_EU							= new ANALOG_EU_class();							// (112)
	public static CDNR_CONTROLLER_class						CDNR_CONTROLLER						= new CDNR_CONTROLLER_class();						// (113)
	public static TRAFFIC_DATA_class						TRAFFIC_DATA						= new TRAFFIC_DATA_class();						// (114)
	public static STATE_DATA_class							STATE_DATA							= new STATE_DATA_class();							// (115)
	public static TRAFFIC_SIM_TIMING_class					TRAFFIC_SIM_TIMING					= new TRAFFIC_SIM_TIMING_class();					// (116)
	public static STATE_DATA_AUG_class						STATE_DATA_AUG						= new STATE_DATA_AUG_class();						// (117)
	public static BHM_SOC_EOD_RUL_class						BHM_SOC_EOD_RUL						= new BHM_SOC_EOD_RUL_class();						// (120)
	public static BHM_CURRENT_VOLTAGE_class					BHM_CURRENT_VOLTAGE					= new BHM_CURRENT_VOLTAGE_class();					// (121)
	public static HEARTBEAT_class							HEARTBEAT							= new HEARTBEAT_class();							// (0)
	public static BOOT_class								BOOT								= new BOOT_class();								// (1)
	public static SYSTEM_TIME_class							SYSTEM_TIME							= new SYSTEM_TIME_class();							// (2)
	public static PING_class								PING								= new PING_class();								// (3)
	public static SYSTEM_TIME_UTC_class						SYSTEM_TIME_UTC						= new SYSTEM_TIME_UTC_class();						// (4)
	public static CHANGE_OPERATOR_CONTROL_class				CHANGE_OPERATOR_CONTROL				= new CHANGE_OPERATOR_CONTROL_class();				// (5)
	public static CHANGE_OPERATOR_CONTROL_ACK_class			CHANGE_OPERATOR_CONTROL_ACK			= new CHANGE_OPERATOR_CONTROL_ACK_class();			// (6)
	public static AUTH_KEY_class							AUTH_KEY							= new AUTH_KEY_class();							// (7)
	public static ACTION_ACK_class							ACTION_ACK							= new ACTION_ACK_class();							// (9)
	public static ACTION_class								ACTION								= new ACTION_class();								// (10)
	public static SET_MODE_class							SET_MODE							= new SET_MODE_class();							// (11)
	public static SET_NAV_MODE_class						SET_NAV_MODE						= new SET_NAV_MODE_class();						// (12)
	public static PARAM_REQUEST_READ_class					PARAM_REQUEST_READ					= new PARAM_REQUEST_READ_class();					// (20)
	public static PARAM_REQUEST_LIST_class					PARAM_REQUEST_LIST					= new PARAM_REQUEST_LIST_class();					// (21)
	public static PARAM_VALUE_class							PARAM_VALUE							= new PARAM_VALUE_class();							// (22)
	public static PARAM_SET_class							PARAM_SET							= new PARAM_SET_class();							// (23)
	public static GPS_RAW_INT_class							GPS_RAW_INT							= new GPS_RAW_INT_class();							// (25)
	public static SCALED_IMU_class							SCALED_IMU							= new SCALED_IMU_class();							// (26)
	public static GPS_STATUS_class							GPS_STATUS							= new GPS_STATUS_class();							// (27)
	public static RAW_IMU_class								RAW_IMU								= new RAW_IMU_class();								// (28)
	public static RAW_PRESSURE_class						RAW_PRESSURE						= new RAW_PRESSURE_class();						// (29)
	public static SCALED_PRESSURE_class						SCALED_PRESSURE						= new SCALED_PRESSURE_class();						// (38)
	public static ATTITUDE_class							ATTITUDE							= new ATTITUDE_class();							// (30)
	public static LOCAL_POSITION_class						LOCAL_POSITION						= new LOCAL_POSITION_class();						// (31)
	public static GLOBAL_POSITION_class						GLOBAL_POSITION						= new GLOBAL_POSITION_class();						// (33)
	public static GPS_RAW_class								GPS_RAW								= new GPS_RAW_class();								// (32)
	public static SYS_STATUS_class							SYS_STATUS							= new SYS_STATUS_class();							// (34)
	public static RC_CHANNELS_RAW_class						RC_CHANNELS_RAW						= new RC_CHANNELS_RAW_class();						// (35)
	public static RC_CHANNELS_SCALED_class					RC_CHANNELS_SCALED					= new RC_CHANNELS_SCALED_class();					// (36)
	public static SERVO_OUTPUT_RAW_class					SERVO_OUTPUT_RAW					= new SERVO_OUTPUT_RAW_class();					// (37)
	public static WAYPOINT_class							WAYPOINT							= new WAYPOINT_class();							// (39)
	public static WAYPOINT_REQUEST_class					WAYPOINT_REQUEST					= new WAYPOINT_REQUEST_class();					// (40)
	public static WAYPOINT_SET_CURRENT_class				WAYPOINT_SET_CURRENT				= new WAYPOINT_SET_CURRENT_class();				// (41)
	public static WAYPOINT_CURRENT_class					WAYPOINT_CURRENT					= new WAYPOINT_CURRENT_class();					// (42)
	public static WAYPOINT_REQUEST_LIST_class				WAYPOINT_REQUEST_LIST				= new WAYPOINT_REQUEST_LIST_class();				// (43)
	public static WAYPOINT_COUNT_class						WAYPOINT_COUNT						= new WAYPOINT_COUNT_class();						// (44)
	public static WAYPOINT_CLEAR_ALL_class					WAYPOINT_CLEAR_ALL					= new WAYPOINT_CLEAR_ALL_class();					// (45)
	public static WAYPOINT_REACHED_class					WAYPOINT_REACHED					= new WAYPOINT_REACHED_class();					// (46)
	public static WAYPOINT_ACK_class						WAYPOINT_ACK						= new WAYPOINT_ACK_class();						// (47)
	public static GPS_SET_GLOBAL_ORIGIN_class				GPS_SET_GLOBAL_ORIGIN				= new GPS_SET_GLOBAL_ORIGIN_class();				// (48)
	public static GPS_LOCAL_ORIGIN_SET_class				GPS_LOCAL_ORIGIN_SET				= new GPS_LOCAL_ORIGIN_SET_class();				// (49)
	public static LOCAL_POSITION_SETPOINT_SET_class			LOCAL_POSITION_SETPOINT_SET			= new LOCAL_POSITION_SETPOINT_SET_class();			// (50)
	public static LOCAL_POSITION_SETPOINT_class				LOCAL_POSITION_SETPOINT				= new LOCAL_POSITION_SETPOINT_class();				// (51)
	public static CONTROL_STATUS_class						CONTROL_STATUS						= new CONTROL_STATUS_class();						// (52)
	public static SAFETY_SET_ALLOWED_AREA_class				SAFETY_SET_ALLOWED_AREA				= new SAFETY_SET_ALLOWED_AREA_class();				// (53)
	public static SAFETY_ALLOWED_AREA_class					SAFETY_ALLOWED_AREA					= new SAFETY_ALLOWED_AREA_class();					// (54)
	public static SET_ROLL_PITCH_YAW_THRUST_class			SET_ROLL_PITCH_YAW_THRUST			= new SET_ROLL_PITCH_YAW_THRUST_class();			// (55)
	public static SET_ROLL_PITCH_YAW_SPEED_THRUST_class		SET_ROLL_PITCH_YAW_SPEED_THRUST		= new SET_ROLL_PITCH_YAW_SPEED_THRUST_class();		// (56)
	public static ROLL_PITCH_YAW_THRUST_SETPOINT_class		ROLL_PITCH_YAW_THRUST_SETPOINT		= new ROLL_PITCH_YAW_THRUST_SETPOINT_class();		// (57)
	public static ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class	ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT	= new ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class();	// (58)
	public static NAV_CONTROLLER_OUTPUT_class				NAV_CONTROLLER_OUTPUT				= new NAV_CONTROLLER_OUTPUT_class();				// (62)
	public static POSITION_TARGET_class						POSITION_TARGET						= new POSITION_TARGET_class();						// (63)
	public static STATE_CORRECTION_class					STATE_CORRECTION					= new STATE_CORRECTION_class();					// (64)
	public static SET_ALTITUDE_class						SET_ALTITUDE						= new SET_ALTITUDE_class();						// (65)
	public static REQUEST_DATA_STREAM_class					REQUEST_DATA_STREAM					= new REQUEST_DATA_STREAM_class();					// (66)
	public static HIL_STATE_class							HIL_STATE							= new HIL_STATE_class();							// (67)
	public static HIL_CONTROLS_class						HIL_CONTROLS						= new HIL_CONTROLS_class();						// (68)
	public static MANUAL_CONTROL_class						MANUAL_CONTROL						= new MANUAL_CONTROL_class();						// (69)
	public static RC_CHANNELS_OVERRIDE_class				RC_CHANNELS_OVERRIDE				= new RC_CHANNELS_OVERRIDE_class();				// (70)
	public static GLOBAL_POSITION_INT_class					GLOBAL_POSITION_INT					= new GLOBAL_POSITION_INT_class();					// (73)
	public static VFR_HUD_class								VFR_HUD								= new VFR_HUD_class();								// (74)
	public static COMMAND_class								COMMAND								= new COMMAND_class();								// (75)
	public static COMMAND_ACK_class							COMMAND_ACK							= new COMMAND_ACK_class();							// (76)
	public static OPTICAL_FLOW_class						OPTICAL_FLOW						= new OPTICAL_FLOW_class();						// (100)
	public static OBJECT_DETECTION_EVENT_class				OBJECT_DETECTION_EVENT				= new OBJECT_DETECTION_EVENT_class();				// (140)
	public static DEBUG_VECT_class							DEBUG_VECT							= new DEBUG_VECT_class();							// (251)
	public static NAMED_VALUE_FLOAT_class					NAMED_VALUE_FLOAT					= new NAMED_VALUE_FLOAT_class();					// (252)
	public static NAMED_VALUE_INT_class						NAMED_VALUE_INT						= new NAMED_VALUE_INT_class();						// (253)
	public static STATUSTEXT_class							STATUSTEXT							= new STATUSTEXT_class();							// (254)
	public static DEBUG_class								DEBUG								= new DEBUG_class();								// (255)
	public static SENSOR_OFFSETS_class						SENSOR_OFFSETS						= new SENSOR_OFFSETS_class();						// (150)
	public static SET_MAG_OFFSETS_class						SET_MAG_OFFSETS						= new SET_MAG_OFFSETS_class();						// (151)
	public static MEMINFO_class								MEMINFO								= new MEMINFO_class();								// (152)
	public static AP_ADC_class								AP_ADC								= new AP_ADC_class();								// (153)
	public static DIGICAM_CONFIGURE_class					DIGICAM_CONFIGURE					= new DIGICAM_CONFIGURE_class();					// (154)
	public static DIGICAM_CONTROL_class						DIGICAM_CONTROL						= new DIGICAM_CONTROL_class();						// (155)
	public static MOUNT_CONFIGURE_class						MOUNT_CONFIGURE						= new MOUNT_CONFIGURE_class();						// (156)
	public static MOUNT_CONTROL_class						MOUNT_CONTROL						= new MOUNT_CONTROL_class();						// (157)
	public static MOUNT_STATUS_class						MOUNT_STATUS						= new MOUNT_STATUS_class();						// (158)
	public static FENCE_POINT_class							FENCE_POINT							= new FENCE_POINT_class();							// (160)
	public static FENCE_FETCH_POINT_class					FENCE_FETCH_POINT					= new FENCE_FETCH_POINT_class();					// (161)
	public static FENCE_STATUS_class						FENCE_STATUS						= new FENCE_STATUS_class();						// (162)

	public static boolean processPacket(byte[] pkt, boolean valid)
	{
		switch(pkt[5])
		{
			case (byte)111:	return(ANALOG_RAW.parse(pkt, valid));
			case (byte)112:	return(ANALOG_EU.parse(pkt, valid));
			case (byte)113:	return(CDNR_CONTROLLER.parse(pkt, valid));
			case (byte)114:	return(TRAFFIC_DATA.parse(pkt, valid));
			case (byte)115:	return(STATE_DATA.parse(pkt, valid));
			case (byte)116:	return(TRAFFIC_SIM_TIMING.parse(pkt, valid));
			case (byte)117:	return(STATE_DATA_AUG.parse(pkt, valid));
			case (byte)120:	return(BHM_SOC_EOD_RUL.parse(pkt, valid));
			case (byte)121:	return(BHM_CURRENT_VOLTAGE.parse(pkt, valid));
			case (byte)0:	return(HEARTBEAT.parse(pkt, valid));
			case (byte)1:	return(BOOT.parse(pkt, valid));
			case (byte)2:	return(SYSTEM_TIME.parse(pkt, valid));
			case (byte)3:	return(PING.parse(pkt, valid));
			case (byte)4:	return(SYSTEM_TIME_UTC.parse(pkt, valid));
			case (byte)5:	return(CHANGE_OPERATOR_CONTROL.parse(pkt, valid));
			case (byte)6:	return(CHANGE_OPERATOR_CONTROL_ACK.parse(pkt, valid));
			case (byte)7:	return(AUTH_KEY.parse(pkt, valid));
			case (byte)9:	return(ACTION_ACK.parse(pkt, valid));
			case (byte)10:	return(ACTION.parse(pkt, valid));
			case (byte)11:	return(SET_MODE.parse(pkt, valid));
			case (byte)12:	return(SET_NAV_MODE.parse(pkt, valid));
			case (byte)20:	return(PARAM_REQUEST_READ.parse(pkt, valid));
			case (byte)21:	return(PARAM_REQUEST_LIST.parse(pkt, valid));
			case (byte)22:	return(PARAM_VALUE.parse(pkt, valid));
			case (byte)23:	return(PARAM_SET.parse(pkt, valid));
			case (byte)25:	return(GPS_RAW_INT.parse(pkt, valid));
			case (byte)26:	return(SCALED_IMU.parse(pkt, valid));
			case (byte)27:	return(GPS_STATUS.parse(pkt, valid));
			case (byte)28:	return(RAW_IMU.parse(pkt, valid));
			case (byte)29:	return(RAW_PRESSURE.parse(pkt, valid));
			case (byte)38:	return(SCALED_PRESSURE.parse(pkt, valid));
			case (byte)30:	return(ATTITUDE.parse(pkt, valid));
			case (byte)31:	return(LOCAL_POSITION.parse(pkt, valid));
			case (byte)33:	return(GLOBAL_POSITION.parse(pkt, valid));
			case (byte)32:	return(GPS_RAW.parse(pkt, valid));
			case (byte)34:	return(SYS_STATUS.parse(pkt, valid));
			case (byte)35:	return(RC_CHANNELS_RAW.parse(pkt, valid));
			case (byte)36:	return(RC_CHANNELS_SCALED.parse(pkt, valid));
			case (byte)37:	return(SERVO_OUTPUT_RAW.parse(pkt, valid));
			case (byte)39:	return(WAYPOINT.parse(pkt, valid));
			case (byte)40:	return(WAYPOINT_REQUEST.parse(pkt, valid));
			case (byte)41:	return(WAYPOINT_SET_CURRENT.parse(pkt, valid));
			case (byte)42:	return(WAYPOINT_CURRENT.parse(pkt, valid));
			case (byte)43:	return(WAYPOINT_REQUEST_LIST.parse(pkt, valid));
			case (byte)44:	return(WAYPOINT_COUNT.parse(pkt, valid));
			case (byte)45:	return(WAYPOINT_CLEAR_ALL.parse(pkt, valid));
			case (byte)46:	return(WAYPOINT_REACHED.parse(pkt, valid));
			case (byte)47:	return(WAYPOINT_ACK.parse(pkt, valid));
			case (byte)48:	return(GPS_SET_GLOBAL_ORIGIN.parse(pkt, valid));
			case (byte)49:	return(GPS_LOCAL_ORIGIN_SET.parse(pkt, valid));
			case (byte)50:	return(LOCAL_POSITION_SETPOINT_SET.parse(pkt, valid));
			case (byte)51:	return(LOCAL_POSITION_SETPOINT.parse(pkt, valid));
			case (byte)52:	return(CONTROL_STATUS.parse(pkt, valid));
			case (byte)53:	return(SAFETY_SET_ALLOWED_AREA.parse(pkt, valid));
			case (byte)54:	return(SAFETY_ALLOWED_AREA.parse(pkt, valid));
			case (byte)55:	return(SET_ROLL_PITCH_YAW_THRUST.parse(pkt, valid));
			case (byte)56:	return(SET_ROLL_PITCH_YAW_SPEED_THRUST.parse(pkt, valid));
			case (byte)57:	return(ROLL_PITCH_YAW_THRUST_SETPOINT.parse(pkt, valid));
			case (byte)58:	return(ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT.parse(pkt, valid));
			case (byte)62:	return(NAV_CONTROLLER_OUTPUT.parse(pkt, valid));
			case (byte)63:	return(POSITION_TARGET.parse(pkt, valid));
			case (byte)64:	return(STATE_CORRECTION.parse(pkt, valid));
			case (byte)65:	return(SET_ALTITUDE.parse(pkt, valid));
			case (byte)66:	return(REQUEST_DATA_STREAM.parse(pkt, valid));
			case (byte)67:	return(HIL_STATE.parse(pkt, valid));
			case (byte)68:	return(HIL_CONTROLS.parse(pkt, valid));
			case (byte)69:	return(MANUAL_CONTROL.parse(pkt, valid));
			case (byte)70:	return(RC_CHANNELS_OVERRIDE.parse(pkt, valid));
			case (byte)73:	return(GLOBAL_POSITION_INT.parse(pkt, valid));
			case (byte)74:	return(VFR_HUD.parse(pkt, valid));
			case (byte)75:	return(COMMAND.parse(pkt, valid));
			case (byte)76:	return(COMMAND_ACK.parse(pkt, valid));
			case (byte)100:	return(OPTICAL_FLOW.parse(pkt, valid));
			case (byte)140:	return(OBJECT_DETECTION_EVENT.parse(pkt, valid));
			case (byte)251:	return(DEBUG_VECT.parse(pkt, valid));
			case (byte)252:	return(NAMED_VALUE_FLOAT.parse(pkt, valid));
			case (byte)253:	return(NAMED_VALUE_INT.parse(pkt, valid));
			case (byte)254:	return(STATUSTEXT.parse(pkt, valid));
			case (byte)255:	return(DEBUG.parse(pkt, valid));
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
			default:
				return(false);
		}
	}

	public static void initMessages()
	{
		PING.target_system = 1;
		PING.target_component = 1;
		CHANGE_OPERATOR_CONTROL.target_system = 1;
		ACTION.target_component = 1;
		PARAM_REQUEST_READ.target_system = 1;
		PARAM_REQUEST_READ.target_component = 1;
		PARAM_REQUEST_LIST.target_system = 1;
		PARAM_REQUEST_LIST.target_component = 1;
		PARAM_SET.target_system = 1;
		PARAM_SET.target_component = 1;
		WAYPOINT.target_system = 1;
		WAYPOINT.target_component = 1;
		WAYPOINT_REQUEST.target_system = 1;
		WAYPOINT_REQUEST.target_component = 1;
		WAYPOINT_SET_CURRENT.target_system = 1;
		WAYPOINT_SET_CURRENT.target_component = 1;
		WAYPOINT_REQUEST_LIST.target_system = 1;
		WAYPOINT_REQUEST_LIST.target_component = 1;
		WAYPOINT_COUNT.target_system = 1;
		WAYPOINT_COUNT.target_component = 1;
		WAYPOINT_CLEAR_ALL.target_system = 1;
		WAYPOINT_CLEAR_ALL.target_component = 1;
		WAYPOINT_ACK.target_system = 1;
		WAYPOINT_ACK.target_component = 1;
		GPS_SET_GLOBAL_ORIGIN.target_system = 1;
		GPS_SET_GLOBAL_ORIGIN.target_component = 1;
		LOCAL_POSITION_SETPOINT_SET.target_system = 1;
		LOCAL_POSITION_SETPOINT_SET.target_component = 1;
		SAFETY_SET_ALLOWED_AREA.target_system = 1;
		SAFETY_SET_ALLOWED_AREA.target_component = 1;
		SET_ROLL_PITCH_YAW_THRUST.target_system = 1;
		SET_ROLL_PITCH_YAW_THRUST.target_component = 1;
		SET_ROLL_PITCH_YAW_SPEED_THRUST.target_system = 1;
		SET_ROLL_PITCH_YAW_SPEED_THRUST.target_component = 1;
		REQUEST_DATA_STREAM.target_system = 1;
		REQUEST_DATA_STREAM.target_component = 1;
		RC_CHANNELS_OVERRIDE.target_system = 1;
		RC_CHANNELS_OVERRIDE.target_component = 1;
		COMMAND.target_system = 1;
		COMMAND.target_component = 1;
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
	}
}
