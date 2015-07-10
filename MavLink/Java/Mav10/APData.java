/**
 * @author svazquez
 *
 */
public class APData
{
	public static HEARTBEAT_class							HEARTBEAT							= new HEARTBEAT_class();							// (0)
	public static SYS_STATUS_class							SYS_STATUS							= new SYS_STATUS_class();							// (1)
	public static SYSTEM_TIME_class							SYSTEM_TIME							= new SYSTEM_TIME_class();							// (2)
	public static PING_class								PING								= new PING_class();								// (4)
	public static CHANGE_OPERATOR_CONTROL_class				CHANGE_OPERATOR_CONTROL				= new CHANGE_OPERATOR_CONTROL_class();				// (5)
	public static CHANGE_OPERATOR_CONTROL_ACK_class			CHANGE_OPERATOR_CONTROL_ACK			= new CHANGE_OPERATOR_CONTROL_ACK_class();			// (6)
	public static AUTH_KEY_class							AUTH_KEY							= new AUTH_KEY_class();							// (7)
	public static SET_MODE_class							SET_MODE							= new SET_MODE_class();							// (11)
	public static PARAM_REQUEST_READ_class					PARAM_REQUEST_READ					= new PARAM_REQUEST_READ_class();					// (20)
	public static PARAM_REQUEST_LIST_class					PARAM_REQUEST_LIST					= new PARAM_REQUEST_LIST_class();					// (21)
	public static PARAM_VALUE_class							PARAM_VALUE							= new PARAM_VALUE_class();							// (22)
	public static PARAM_SET_class							PARAM_SET							= new PARAM_SET_class();							// (23)
	public static GPS_RAW_INT_class							GPS_RAW_INT							= new GPS_RAW_INT_class();							// (24)
	public static GPS_STATUS_class							GPS_STATUS							= new GPS_STATUS_class();							// (25)
	public static SCALED_IMU_class							SCALED_IMU							= new SCALED_IMU_class();							// (26)
	public static RAW_IMU_class								RAW_IMU								= new RAW_IMU_class();								// (27)
	public static RAW_PRESSURE_class						RAW_PRESSURE						= new RAW_PRESSURE_class();						// (28)
	public static SCALED_PRESSURE_class						SCALED_PRESSURE						= new SCALED_PRESSURE_class();						// (29)
	public static ATTITUDE_class							ATTITUDE							= new ATTITUDE_class();							// (30)
	public static ATTITUDE_QUATERNION_class					ATTITUDE_QUATERNION					= new ATTITUDE_QUATERNION_class();					// (31)
	public static LOCAL_POSITION_NED_class					LOCAL_POSITION_NED					= new LOCAL_POSITION_NED_class();					// (32)
	public static GLOBAL_POSITION_INT_class					GLOBAL_POSITION_INT					= new GLOBAL_POSITION_INT_class();					// (33)
	public static RC_CHANNELS_SCALED_class					RC_CHANNELS_SCALED					= new RC_CHANNELS_SCALED_class();					// (34)
	public static RC_CHANNELS_RAW_class						RC_CHANNELS_RAW						= new RC_CHANNELS_RAW_class();						// (35)
	public static SERVO_OUTPUT_RAW_class					SERVO_OUTPUT_RAW					= new SERVO_OUTPUT_RAW_class();					// (36)
	public static MISSION_REQUEST_PARTIAL_LIST_class		MISSION_REQUEST_PARTIAL_LIST		= new MISSION_REQUEST_PARTIAL_LIST_class();		// (37)
	public static MISSION_WRITE_PARTIAL_LIST_class			MISSION_WRITE_PARTIAL_LIST			= new MISSION_WRITE_PARTIAL_LIST_class();			// (38)
	public static MISSION_ITEM_class						MISSION_ITEM						= new MISSION_ITEM_class();						// (39)
	public static MISSION_REQUEST_class						MISSION_REQUEST						= new MISSION_REQUEST_class();						// (40)
	public static MISSION_SET_CURRENT_class					MISSION_SET_CURRENT					= new MISSION_SET_CURRENT_class();					// (41)
	public static MISSION_CURRENT_class						MISSION_CURRENT						= new MISSION_CURRENT_class();						// (42)
	public static MISSION_REQUEST_LIST_class				MISSION_REQUEST_LIST				= new MISSION_REQUEST_LIST_class();				// (43)
	public static MISSION_COUNT_class						MISSION_COUNT						= new MISSION_COUNT_class();						// (44)
	public static MISSION_CLEAR_ALL_class					MISSION_CLEAR_ALL					= new MISSION_CLEAR_ALL_class();					// (45)
	public static MISSION_ITEM_REACHED_class				MISSION_ITEM_REACHED				= new MISSION_ITEM_REACHED_class();				// (46)
	public static MISSION_ACK_class							MISSION_ACK							= new MISSION_ACK_class();							// (47)
	public static SET_GPS_GLOBAL_ORIGIN_class				SET_GPS_GLOBAL_ORIGIN				= new SET_GPS_GLOBAL_ORIGIN_class();				// (48)
	public static GPS_GLOBAL_ORIGIN_class					GPS_GLOBAL_ORIGIN					= new GPS_GLOBAL_ORIGIN_class();					// (49)
	public static PARAM_MAP_RC_class						PARAM_MAP_RC						= new PARAM_MAP_RC_class();						// (50)
	public static SAFETY_SET_ALLOWED_AREA_class				SAFETY_SET_ALLOWED_AREA				= new SAFETY_SET_ALLOWED_AREA_class();				// (54)
	public static SAFETY_ALLOWED_AREA_class					SAFETY_ALLOWED_AREA					= new SAFETY_ALLOWED_AREA_class();					// (55)
	public static ATTITUDE_QUATERNION_COV_class				ATTITUDE_QUATERNION_COV				= new ATTITUDE_QUATERNION_COV_class();				// (61)
	public static NAV_CONTROLLER_OUTPUT_class				NAV_CONTROLLER_OUTPUT				= new NAV_CONTROLLER_OUTPUT_class();				// (62)
	public static GLOBAL_POSITION_INT_COV_class				GLOBAL_POSITION_INT_COV				= new GLOBAL_POSITION_INT_COV_class();				// (63)
	public static LOCAL_POSITION_NED_COV_class				LOCAL_POSITION_NED_COV				= new LOCAL_POSITION_NED_COV_class();				// (64)
	public static RC_CHANNELS_class							RC_CHANNELS							= new RC_CHANNELS_class();							// (65)
	public static REQUEST_DATA_STREAM_class					REQUEST_DATA_STREAM					= new REQUEST_DATA_STREAM_class();					// (66)
	public static DATA_STREAM_class							DATA_STREAM							= new DATA_STREAM_class();							// (67)
	public static MANUAL_CONTROL_class						MANUAL_CONTROL						= new MANUAL_CONTROL_class();						// (69)
	public static RC_CHANNELS_OVERRIDE_class				RC_CHANNELS_OVERRIDE				= new RC_CHANNELS_OVERRIDE_class();				// (70)
	public static MISSION_ITEM_INT_class					MISSION_ITEM_INT					= new MISSION_ITEM_INT_class();					// (73)
	public static VFR_HUD_class								VFR_HUD								= new VFR_HUD_class();								// (74)
	public static COMMAND_INT_class							COMMAND_INT							= new COMMAND_INT_class();							// (75)
	public static COMMAND_LONG_class						COMMAND_LONG						= new COMMAND_LONG_class();						// (76)
	public static COMMAND_ACK_class							COMMAND_ACK							= new COMMAND_ACK_class();							// (77)
	public static MANUAL_SETPOINT_class						MANUAL_SETPOINT						= new MANUAL_SETPOINT_class();						// (81)
	public static SET_ATTITUDE_TARGET_class					SET_ATTITUDE_TARGET					= new SET_ATTITUDE_TARGET_class();					// (82)
	public static ATTITUDE_TARGET_class						ATTITUDE_TARGET						= new ATTITUDE_TARGET_class();						// (83)
	public static SET_POSITION_TARGET_LOCAL_NED_class		SET_POSITION_TARGET_LOCAL_NED		= new SET_POSITION_TARGET_LOCAL_NED_class();		// (84)
	public static POSITION_TARGET_LOCAL_NED_class			POSITION_TARGET_LOCAL_NED			= new POSITION_TARGET_LOCAL_NED_class();			// (85)
	public static SET_POSITION_TARGET_GLOBAL_INT_class		SET_POSITION_TARGET_GLOBAL_INT		= new SET_POSITION_TARGET_GLOBAL_INT_class();		// (86)
	public static POSITION_TARGET_GLOBAL_INT_class			POSITION_TARGET_GLOBAL_INT			= new POSITION_TARGET_GLOBAL_INT_class();			// (87)
	public static LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_class	LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET	= new LOCAL_POSITION_NED_SYSTEM_GLOBAL_OFFSET_class();	// (89)
	public static HIL_STATE_class							HIL_STATE							= new HIL_STATE_class();							// (90)
	public static HIL_CONTROLS_class						HIL_CONTROLS						= new HIL_CONTROLS_class();						// (91)
	public static HIL_RC_INPUTS_RAW_class					HIL_RC_INPUTS_RAW					= new HIL_RC_INPUTS_RAW_class();					// (92)
	public static OPTICAL_FLOW_class						OPTICAL_FLOW						= new OPTICAL_FLOW_class();						// (100)
	public static GLOBAL_VISION_POSITION_ESTIMATE_class		GLOBAL_VISION_POSITION_ESTIMATE		= new GLOBAL_VISION_POSITION_ESTIMATE_class();		// (101)
	public static VISION_POSITION_ESTIMATE_class			VISION_POSITION_ESTIMATE			= new VISION_POSITION_ESTIMATE_class();			// (102)
	public static VISION_SPEED_ESTIMATE_class				VISION_SPEED_ESTIMATE				= new VISION_SPEED_ESTIMATE_class();				// (103)
	public static VICON_POSITION_ESTIMATE_class				VICON_POSITION_ESTIMATE				= new VICON_POSITION_ESTIMATE_class();				// (104)
	public static HIGHRES_IMU_class							HIGHRES_IMU							= new HIGHRES_IMU_class();							// (105)
	public static OPTICAL_FLOW_RAD_class					OPTICAL_FLOW_RAD					= new OPTICAL_FLOW_RAD_class();					// (106)
	public static HIL_SENSOR_class							HIL_SENSOR							= new HIL_SENSOR_class();							// (107)
	public static SIM_STATE_class							SIM_STATE							= new SIM_STATE_class();							// (108)
	public static RADIO_STATUS_class						RADIO_STATUS						= new RADIO_STATUS_class();						// (109)
	public static FILE_TRANSFER_PROTOCOL_class				FILE_TRANSFER_PROTOCOL				= new FILE_TRANSFER_PROTOCOL_class();				// (110)
	public static TIMESYNC_class							TIMESYNC							= new TIMESYNC_class();							// (111)
	public static HIL_GPS_class								HIL_GPS								= new HIL_GPS_class();								// (113)
	public static HIL_OPTICAL_FLOW_class					HIL_OPTICAL_FLOW					= new HIL_OPTICAL_FLOW_class();					// (114)
	public static HIL_STATE_QUATERNION_class				HIL_STATE_QUATERNION				= new HIL_STATE_QUATERNION_class();				// (115)
	public static SCALED_IMU2_class							SCALED_IMU2							= new SCALED_IMU2_class();							// (116)
	public static LOG_REQUEST_LIST_class					LOG_REQUEST_LIST					= new LOG_REQUEST_LIST_class();					// (117)
	public static LOG_ENTRY_class							LOG_ENTRY							= new LOG_ENTRY_class();							// (118)
	public static LOG_REQUEST_DATA_class					LOG_REQUEST_DATA					= new LOG_REQUEST_DATA_class();					// (119)
	public static LOG_DATA_class							LOG_DATA							= new LOG_DATA_class();							// (120)
	public static LOG_ERASE_class							LOG_ERASE							= new LOG_ERASE_class();							// (121)
	public static LOG_REQUEST_END_class						LOG_REQUEST_END						= new LOG_REQUEST_END_class();						// (122)
	public static GPS_INJECT_DATA_class						GPS_INJECT_DATA						= new GPS_INJECT_DATA_class();						// (123)
	public static GPS2_RAW_class							GPS2_RAW							= new GPS2_RAW_class();							// (124)
	public static POWER_STATUS_class						POWER_STATUS						= new POWER_STATUS_class();						// (125)
	public static SERIAL_CONTROL_class						SERIAL_CONTROL						= new SERIAL_CONTROL_class();						// (126)
	public static GPS_RTK_class								GPS_RTK								= new GPS_RTK_class();								// (127)
	public static GPS2_RTK_class							GPS2_RTK							= new GPS2_RTK_class();							// (128)
	public static SCALED_IMU3_class							SCALED_IMU3							= new SCALED_IMU3_class();							// (129)
	public static DATA_TRANSMISSION_HANDSHAKE_class			DATA_TRANSMISSION_HANDSHAKE			= new DATA_TRANSMISSION_HANDSHAKE_class();			// (130)
	public static ENCAPSULATED_DATA_class					ENCAPSULATED_DATA					= new ENCAPSULATED_DATA_class();					// (131)
	public static DISTANCE_SENSOR_class						DISTANCE_SENSOR						= new DISTANCE_SENSOR_class();						// (132)
	public static TERRAIN_REQUEST_class						TERRAIN_REQUEST						= new TERRAIN_REQUEST_class();						// (133)
	public static TERRAIN_DATA_class						TERRAIN_DATA						= new TERRAIN_DATA_class();						// (134)
	public static TERRAIN_CHECK_class						TERRAIN_CHECK						= new TERRAIN_CHECK_class();						// (135)
	public static TERRAIN_REPORT_class						TERRAIN_REPORT						= new TERRAIN_REPORT_class();						// (136)
	public static SCALED_PRESSURE2_class					SCALED_PRESSURE2					= new SCALED_PRESSURE2_class();					// (137)
	public static ATT_POS_MOCAP_class						ATT_POS_MOCAP						= new ATT_POS_MOCAP_class();						// (138)
	public static SET_ACTUATOR_CONTROL_TARGET_class			SET_ACTUATOR_CONTROL_TARGET			= new SET_ACTUATOR_CONTROL_TARGET_class();			// (139)
	public static ACTUATOR_CONTROL_TARGET_class				ACTUATOR_CONTROL_TARGET				= new ACTUATOR_CONTROL_TARGET_class();				// (140)
	public static BATTERY_STATUS_class						BATTERY_STATUS						= new BATTERY_STATUS_class();						// (147)
	public static AUTOPILOT_VERSION_class					AUTOPILOT_VERSION					= new AUTOPILOT_VERSION_class();					// (148)
	public static V2_EXTENSION_class						V2_EXTENSION						= new V2_EXTENSION_class();						// (248)
	public static MEMORY_VECT_class							MEMORY_VECT							= new MEMORY_VECT_class();							// (249)
	public static DEBUG_VECT_class							DEBUG_VECT							= new DEBUG_VECT_class();							// (250)
	public static NAMED_VALUE_FLOAT_class					NAMED_VALUE_FLOAT					= new NAMED_VALUE_FLOAT_class();					// (251)
	public static NAMED_VALUE_INT_class						NAMED_VALUE_INT						= new NAMED_VALUE_INT_class();						// (252)
	public static STATUSTEXT_class							STATUSTEXT							= new STATUSTEXT_class();							// (253)
	public static DEBUG_class								DEBUG								= new DEBUG_class();								// (254)
	public static SET_CAM_SHUTTER_class						SET_CAM_SHUTTER						= new SET_CAM_SHUTTER_class();						// (151)
	public static IMAGE_TRIGGERED_class						IMAGE_TRIGGERED						= new IMAGE_TRIGGERED_class();						// (152)
	public static IMAGE_TRIGGER_CONTROL_class				IMAGE_TRIGGER_CONTROL				= new IMAGE_TRIGGER_CONTROL_class();				// (153)
	public static IMAGE_AVAILABLE_class						IMAGE_AVAILABLE						= new IMAGE_AVAILABLE_class();						// (154)
	public static SET_POSITION_CONTROL_OFFSET_class			SET_POSITION_CONTROL_OFFSET			= new SET_POSITION_CONTROL_OFFSET_class();			// (160)
	public static POSITION_CONTROL_SETPOINT_class			POSITION_CONTROL_SETPOINT			= new POSITION_CONTROL_SETPOINT_class();			// (170)
	public static MARKER_class								MARKER								= new MARKER_class();								// (171)
	public static RAW_AUX_class								RAW_AUX								= new RAW_AUX_class();								// (172)
	public static WATCHDOG_HEARTBEAT_class					WATCHDOG_HEARTBEAT					= new WATCHDOG_HEARTBEAT_class();					// (180)
	public static WATCHDOG_PROCESS_INFO_class				WATCHDOG_PROCESS_INFO				= new WATCHDOG_PROCESS_INFO_class();				// (181)
	public static WATCHDOG_PROCESS_STATUS_class				WATCHDOG_PROCESS_STATUS				= new WATCHDOG_PROCESS_STATUS_class();				// (182)
	public static WATCHDOG_COMMAND_class					WATCHDOG_COMMAND					= new WATCHDOG_COMMAND_class();					// (183)
	public static PATTERN_DETECTED_class					PATTERN_DETECTED					= new PATTERN_DETECTED_class();					// (190)
	public static POINT_OF_INTEREST_class					POINT_OF_INTEREST					= new POINT_OF_INTEREST_class();					// (191)
	public static POINT_OF_INTEREST_CONNECTION_class		POINT_OF_INTEREST_CONNECTION		= new POINT_OF_INTEREST_CONNECTION_class();		// (192)
	public static BRIEF_FEATURE_class						BRIEF_FEATURE						= new BRIEF_FEATURE_class();						// (195)
	public static ATTITUDE_CONTROL_class					ATTITUDE_CONTROL					= new ATTITUDE_CONTROL_class();					// (200)
	public static DETECTION_STATS_class						DETECTION_STATS						= new DETECTION_STATS_class();						// (205)
	public static ONBOARD_HEALTH_class						ONBOARD_HEALTH						= new ONBOARD_HEALTH_class();						// (206)

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
			case (byte)50:	return(PARAM_MAP_RC.parse(pkt, valid));
			case (byte)54:	return(SAFETY_SET_ALLOWED_AREA.parse(pkt, valid));
			case (byte)55:	return(SAFETY_ALLOWED_AREA.parse(pkt, valid));
			case (byte)61:	return(ATTITUDE_QUATERNION_COV.parse(pkt, valid));
			case (byte)62:	return(NAV_CONTROLLER_OUTPUT.parse(pkt, valid));
			case (byte)63:	return(GLOBAL_POSITION_INT_COV.parse(pkt, valid));
			case (byte)64:	return(LOCAL_POSITION_NED_COV.parse(pkt, valid));
			case (byte)65:	return(RC_CHANNELS.parse(pkt, valid));
			case (byte)66:	return(REQUEST_DATA_STREAM.parse(pkt, valid));
			case (byte)67:	return(DATA_STREAM.parse(pkt, valid));
			case (byte)69:	return(MANUAL_CONTROL.parse(pkt, valid));
			case (byte)70:	return(RC_CHANNELS_OVERRIDE.parse(pkt, valid));
			case (byte)73:	return(MISSION_ITEM_INT.parse(pkt, valid));
			case (byte)74:	return(VFR_HUD.parse(pkt, valid));
			case (byte)75:	return(COMMAND_INT.parse(pkt, valid));
			case (byte)76:	return(COMMAND_LONG.parse(pkt, valid));
			case (byte)77:	return(COMMAND_ACK.parse(pkt, valid));
			case (byte)81:	return(MANUAL_SETPOINT.parse(pkt, valid));
			case (byte)82:	return(SET_ATTITUDE_TARGET.parse(pkt, valid));
			case (byte)83:	return(ATTITUDE_TARGET.parse(pkt, valid));
			case (byte)84:	return(SET_POSITION_TARGET_LOCAL_NED.parse(pkt, valid));
			case (byte)85:	return(POSITION_TARGET_LOCAL_NED.parse(pkt, valid));
			case (byte)86:	return(SET_POSITION_TARGET_GLOBAL_INT.parse(pkt, valid));
			case (byte)87:	return(POSITION_TARGET_GLOBAL_INT.parse(pkt, valid));
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
			case (byte)106:	return(OPTICAL_FLOW_RAD.parse(pkt, valid));
			case (byte)107:	return(HIL_SENSOR.parse(pkt, valid));
			case (byte)108:	return(SIM_STATE.parse(pkt, valid));
			case (byte)109:	return(RADIO_STATUS.parse(pkt, valid));
			case (byte)110:	return(FILE_TRANSFER_PROTOCOL.parse(pkt, valid));
			case (byte)111:	return(TIMESYNC.parse(pkt, valid));
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
			case (byte)123:	return(GPS_INJECT_DATA.parse(pkt, valid));
			case (byte)124:	return(GPS2_RAW.parse(pkt, valid));
			case (byte)125:	return(POWER_STATUS.parse(pkt, valid));
			case (byte)126:	return(SERIAL_CONTROL.parse(pkt, valid));
			case (byte)127:	return(GPS_RTK.parse(pkt, valid));
			case (byte)128:	return(GPS2_RTK.parse(pkt, valid));
			case (byte)129:	return(SCALED_IMU3.parse(pkt, valid));
			case (byte)130:	return(DATA_TRANSMISSION_HANDSHAKE.parse(pkt, valid));
			case (byte)131:	return(ENCAPSULATED_DATA.parse(pkt, valid));
			case (byte)132:	return(DISTANCE_SENSOR.parse(pkt, valid));
			case (byte)133:	return(TERRAIN_REQUEST.parse(pkt, valid));
			case (byte)134:	return(TERRAIN_DATA.parse(pkt, valid));
			case (byte)135:	return(TERRAIN_CHECK.parse(pkt, valid));
			case (byte)136:	return(TERRAIN_REPORT.parse(pkt, valid));
			case (byte)137:	return(SCALED_PRESSURE2.parse(pkt, valid));
			case (byte)138:	return(ATT_POS_MOCAP.parse(pkt, valid));
			case (byte)139:	return(SET_ACTUATOR_CONTROL_TARGET.parse(pkt, valid));
			case (byte)140:	return(ACTUATOR_CONTROL_TARGET.parse(pkt, valid));
			case (byte)147:	return(BATTERY_STATUS.parse(pkt, valid));
			case (byte)148:	return(AUTOPILOT_VERSION.parse(pkt, valid));
			case (byte)248:	return(V2_EXTENSION.parse(pkt, valid));
			case (byte)249:	return(MEMORY_VECT.parse(pkt, valid));
			case (byte)250:	return(DEBUG_VECT.parse(pkt, valid));
			case (byte)251:	return(NAMED_VALUE_FLOAT.parse(pkt, valid));
			case (byte)252:	return(NAMED_VALUE_INT.parse(pkt, valid));
			case (byte)253:	return(STATUSTEXT.parse(pkt, valid));
			case (byte)254:	return(DEBUG.parse(pkt, valid));
			case (byte)151:	return(SET_CAM_SHUTTER.parse(pkt, valid));
			case (byte)152:	return(IMAGE_TRIGGERED.parse(pkt, valid));
			case (byte)153:	return(IMAGE_TRIGGER_CONTROL.parse(pkt, valid));
			case (byte)154:	return(IMAGE_AVAILABLE.parse(pkt, valid));
			case (byte)160:	return(SET_POSITION_CONTROL_OFFSET.parse(pkt, valid));
			case (byte)170:	return(POSITION_CONTROL_SETPOINT.parse(pkt, valid));
			case (byte)171:	return(MARKER.parse(pkt, valid));
			case (byte)172:	return(RAW_AUX.parse(pkt, valid));
			case (byte)180:	return(WATCHDOG_HEARTBEAT.parse(pkt, valid));
			case (byte)181:	return(WATCHDOG_PROCESS_INFO.parse(pkt, valid));
			case (byte)182:	return(WATCHDOG_PROCESS_STATUS.parse(pkt, valid));
			case (byte)183:	return(WATCHDOG_COMMAND.parse(pkt, valid));
			case (byte)190:	return(PATTERN_DETECTED.parse(pkt, valid));
			case (byte)191:	return(POINT_OF_INTEREST.parse(pkt, valid));
			case (byte)192:	return(POINT_OF_INTEREST_CONNECTION.parse(pkt, valid));
			case (byte)195:	return(BRIEF_FEATURE.parse(pkt, valid));
			case (byte)200:	return(ATTITUDE_CONTROL.parse(pkt, valid));
			case (byte)205:	return(DETECTION_STATS.parse(pkt, valid));
			case (byte)206:	return(ONBOARD_HEALTH.parse(pkt, valid));
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
		PARAM_MAP_RC.target_system = 1;
		PARAM_MAP_RC.target_component = 1;
		SAFETY_SET_ALLOWED_AREA.target_system = 1;
		SAFETY_SET_ALLOWED_AREA.target_component = 1;
		REQUEST_DATA_STREAM.target_system = 1;
		REQUEST_DATA_STREAM.target_component = 1;
		RC_CHANNELS_OVERRIDE.target_system = 1;
		RC_CHANNELS_OVERRIDE.target_component = 1;
		MISSION_ITEM_INT.target_system = 1;
		MISSION_ITEM_INT.target_component = 1;
		COMMAND_INT.target_system = 1;
		COMMAND_INT.target_component = 1;
		COMMAND_LONG.target_system = 1;
		COMMAND_LONG.target_component = 1;
		SET_ATTITUDE_TARGET.target_system = 1;
		SET_ATTITUDE_TARGET.target_component = 1;
		SET_POSITION_TARGET_LOCAL_NED.target_system = 1;
		SET_POSITION_TARGET_LOCAL_NED.target_component = 1;
		SET_POSITION_TARGET_GLOBAL_INT.target_system = 1;
		SET_POSITION_TARGET_GLOBAL_INT.target_component = 1;
		FILE_TRANSFER_PROTOCOL.target_system = 1;
		FILE_TRANSFER_PROTOCOL.target_component = 1;
		LOG_REQUEST_LIST.target_system = 1;
		LOG_REQUEST_LIST.target_component = 1;
		LOG_REQUEST_DATA.target_system = 1;
		LOG_REQUEST_DATA.target_component = 1;
		LOG_ERASE.target_system = 1;
		LOG_ERASE.target_component = 1;
		LOG_REQUEST_END.target_system = 1;
		LOG_REQUEST_END.target_component = 1;
		GPS_INJECT_DATA.target_system = 1;
		GPS_INJECT_DATA.target_component = 1;
		SET_ACTUATOR_CONTROL_TARGET.target_system = 1;
		SET_ACTUATOR_CONTROL_TARGET.target_component = 1;
		V2_EXTENSION.target_system = 1;
		V2_EXTENSION.target_component = 1;
		SET_POSITION_CONTROL_OFFSET.target_system = 1;
		SET_POSITION_CONTROL_OFFSET.target_component = 1;
	}
}
