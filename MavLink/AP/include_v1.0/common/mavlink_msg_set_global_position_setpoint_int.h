// MESSAGE SET_GLOBAL_POSITION_SETPOINT_INT PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT 53 

typedef struct __mavlink_set_global_position_setpoint_int_t 
{ 
  uint8_t coordinate_frame;  ///< Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
  int32_t latitude;  ///< Latitude (WGS84), in degrees * 1E7
  int32_t longitude;  ///< Longitude (WGS84), in degrees * 1E7
  int32_t altitude;  ///< Altitude (WGS84), in meters * 1000 (positive for up)
  int16_t yaw;  ///< Desired yaw angle in degrees * 100
} mavlink_set_global_position_setpoint_int_t;

#define MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN 15
#define MAVLINK_MSG_ID_53_LEN 15

#define MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC 0
#define MAVLINK_MSG_ID_53_CRC 0

#define MAVLINK_MESSAGE_INFO_SET_GLOBAL_POSITION_SETPOINT_INT \
{ \
  "SET_GLOBAL_POSITION_SETPOINT_INT", \
  5, \
  { \
    { "coordinate_frame", NULL, MAVLINK_TYPE_UINT8_T, 0, 0, offsetof(mavlink_set_global_position_setpoint_int_t, coordinate_frame) }, \
    { "latitude", NULL, MAVLINK_TYPE_INT32_T, 0, 1, offsetof(mavlink_set_global_position_setpoint_int_t, latitude) }, \
    { "longitude", NULL, MAVLINK_TYPE_INT32_T, 0, 5, offsetof(mavlink_set_global_position_setpoint_int_t, longitude) }, \
    { "altitude", NULL, MAVLINK_TYPE_INT32_T, 0, 9, offsetof(mavlink_set_global_position_setpoint_int_t, altitude) }, \
    { "yaw", NULL, MAVLINK_TYPE_INT16_T, 0, 13, offsetof(mavlink_set_global_position_setpoint_int_t, yaw) }, \
  } \
}

/**
 * @brief Pack a set_global_position_setpoint_int message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
 * @param latitude Latitude (WGS84), in degrees * 1E7
 * @param longitude Longitude (WGS84), in degrees * 1E7
 * @param altitude Altitude (WGS84), in meters * 1000 (positive for up)
 * @param yaw Desired yaw angle in degrees * 100
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_set_global_position_setpoint_int_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t coordinate_frame
	,int32_t latitude
	,int32_t longitude
	,int32_t altitude
	,int16_t yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_int32_t(buf, 1, latitude);
	_mav_put_int32_t(buf, 5, longitude);
	_mav_put_int32_t(buf, 9, altitude);
	_mav_put_int16_t(buf, 13, yaw);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#else
	mavlink_set_global_position_setpoint_int_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.latitude = latitude;
	packet.longitude = longitude;
	packet.altitude = altitude;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
}

/**
 * @brief Pack a set_global_position_setpoint_int message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
 * @param latitude Latitude (WGS84), in degrees * 1E7
 * @param longitude Longitude (WGS84), in degrees * 1E7
 * @param altitude Altitude (WGS84), in meters * 1000 (positive for up)
 * @param yaw Desired yaw angle in degrees * 100
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_set_global_position_setpoint_int_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t coordinate_frame
	,int32_t latitude
	,int32_t longitude
	,int32_t altitude
	,int16_t yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_int32_t(buf, 1, latitude);
	_mav_put_int32_t(buf, 5, longitude);
	_mav_put_int32_t(buf, 9, altitude);
	_mav_put_int16_t(buf, 13, yaw);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#else
	mavlink_set_global_position_setpoint_int_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.latitude = latitude;
	packet.longitude = longitude;
	packet.altitude = altitude;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
}

/**
 * @brief Encode a set_global_position_setpoint_int struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param set_global_position_setpoint_int C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_set_global_position_setpoint_int_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_set_global_position_setpoint_int_t* set_global_position_setpoint_int
	)
{
	return mavlink_msg_set_global_position_setpoint_int_pack(
	 system_id
	,component_id
	,msg
	,set_global_position_setpoint_int->coordinate_frame
	,set_global_position_setpoint_int->latitude
	,set_global_position_setpoint_int->longitude
	,set_global_position_setpoint_int->altitude
	,set_global_position_setpoint_int->yaw
	);
}

/**
 * @brief Encode a set_global_position_setpoint_int struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param set_global_position_setpoint_int C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_set_global_position_setpoint_int_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_set_global_position_setpoint_int_t* set_global_position_setpoint_int
	)
{
	return mavlink_msg_set_global_position_setpoint_int_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,set_global_position_setpoint_int->coordinate_frame
	,set_global_position_setpoint_int->latitude
	,set_global_position_setpoint_int->longitude
	,set_global_position_setpoint_int->altitude
	,set_global_position_setpoint_int->yaw
	);
}

/**
 * @brief Send a set_global_position_setpoint_int message
 * @param chan The MAVLink channel to send this message
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
 * @param latitude Latitude (WGS84), in degrees * 1E7
 * @param longitude Longitude (WGS84), in degrees * 1E7
 * @param altitude Altitude (WGS84), in meters * 1000 (positive for up)
 * @param yaw Desired yaw angle in degrees * 100
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_set_global_position_setpoint_int_send(
	 mavlink_channel_t chan
	,uint8_t coordinate_frame
	,int32_t latitude
	,int32_t longitude
	,int32_t altitude
	,int16_t yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_int32_t(buf, 1, latitude);
	_mav_put_int32_t(buf, 5, longitude);
	_mav_put_int32_t(buf, 9, altitude);
	_mav_put_int16_t(buf, 13, yaw);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
#else
	mavlink_set_global_position_setpoint_int_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.latitude = latitude;
	packet.longitude = longitude;
	packet.altitude = altitude;
	packet.yaw = yaw;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, (const char*)&packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, (const char*)&packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_set_global_position_setpoint_int_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t coordinate_frame
	,int32_t latitude
	,int32_t longitude
	,int32_t altitude
	,int16_t yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_int32_t(buf, 1, latitude);
	_mav_put_int32_t(buf, 5, longitude);
	_mav_put_int32_t(buf, 9, altitude);
	_mav_put_int16_t(buf, 13, yaw);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, buf, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
#else
	mavlink_set_global_position_setpoint_int_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.latitude = latitude;
	packet.longitude = longitude;
	packet.altitude = altitude;
	packet.yaw = yaw;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, (const char*)&packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT, (const char*)&packet, MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE SET_GLOBAL_POSITION_SETPOINT_INT UNPACKING

/**
 * @brief Get field coordinate_frame from set_global_position_setpoint_int message
 *
 * @return Coordinate frame - valid values are only MAV_FRAME_GLOBAL or MAV_FRAME_GLOBAL_RELATIVE_ALT
 */
static inline uint8_t mavlink_msg_set_global_position_setpoint_int_get_coordinate_frame(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field latitude from set_global_position_setpoint_int message
 *
 * @return Latitude (WGS84), in degrees * 1E7
 */
static inline int32_t mavlink_msg_set_global_position_setpoint_int_get_latitude(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int32_t(msg,1);
}

/**
 * @brief Get field longitude from set_global_position_setpoint_int message
 *
 * @return Longitude (WGS84), in degrees * 1E7
 */
static inline int32_t mavlink_msg_set_global_position_setpoint_int_get_longitude(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int32_t(msg,5);
}

/**
 * @brief Get field altitude from set_global_position_setpoint_int message
 *
 * @return Altitude (WGS84), in meters * 1000 (positive for up)
 */
static inline int32_t mavlink_msg_set_global_position_setpoint_int_get_altitude(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int32_t(msg,9);
}

/**
 * @brief Get field yaw from set_global_position_setpoint_int message
 *
 * @return Desired yaw angle in degrees * 100
 */
static inline int16_t mavlink_msg_set_global_position_setpoint_int_get_yaw(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int16_t(msg,13);
}

/**
 * @brief Decode a set_global_position_setpoint_int message into a struct
 *
 * @param msg The message to decode
 * @param set_global_position_setpoint_int C-struct to decode the message contents into
 */
static inline void mavlink_msg_set_global_position_setpoint_int_decode(const mavlink_message_t* msg, mavlink_set_global_position_setpoint_int_t* set_global_position_setpoint_int)
{
#if MAVLINK_NEED_BYTE_SWAP
	set_global_position_setpoint_int->coordinate_frame = mavlink_msg_set_global_position_setpoint_int_get_coordinate_frame(msg);
	set_global_position_setpoint_int->latitude = mavlink_msg_set_global_position_setpoint_int_get_latitude(msg);
	set_global_position_setpoint_int->longitude = mavlink_msg_set_global_position_setpoint_int_get_longitude(msg);
	set_global_position_setpoint_int->altitude = mavlink_msg_set_global_position_setpoint_int_get_altitude(msg);
	set_global_position_setpoint_int->yaw = mavlink_msg_set_global_position_setpoint_int_get_yaw(msg);
#else
	memcpy(set_global_position_setpoint_int, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_SET_GLOBAL_POSITION_SETPOINT_INT_LEN);
#endif
}
