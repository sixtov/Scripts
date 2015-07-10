// MESSAGE LOCAL_POSITION_SETPOINT PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT 51 

typedef struct __mavlink_local_position_setpoint_t 
{ 
  uint8_t coordinate_frame;  ///< Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
  float x;  ///< x position
  float y;  ///< y position
  float z;  ///< z position
  float yaw;  ///< Desired yaw angle
} mavlink_local_position_setpoint_t;

#define MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN 17
#define MAVLINK_MSG_ID_51_LEN 17

#define MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC 0
#define MAVLINK_MSG_ID_51_CRC 0

#define MAVLINK_MESSAGE_INFO_LOCAL_POSITION_SETPOINT \
{ \
  "LOCAL_POSITION_SETPOINT", \
  5, \
  { \
    { "coordinate_frame", NULL, MAVLINK_TYPE_UINT8_T, 0, 0, offsetof(mavlink_local_position_setpoint_t, coordinate_frame) }, \
    { "x", NULL, MAVLINK_TYPE_FLOAT, 0, 1, offsetof(mavlink_local_position_setpoint_t, x) }, \
    { "y", NULL, MAVLINK_TYPE_FLOAT, 0, 5, offsetof(mavlink_local_position_setpoint_t, y) }, \
    { "z", NULL, MAVLINK_TYPE_FLOAT, 0, 9, offsetof(mavlink_local_position_setpoint_t, z) }, \
    { "yaw", NULL, MAVLINK_TYPE_FLOAT, 0, 13, offsetof(mavlink_local_position_setpoint_t, yaw) }, \
  } \
}

/**
 * @brief Pack a local_position_setpoint message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw Desired yaw angle
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_local_position_setpoint_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t coordinate_frame
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_float(buf, 1, x);
	_mav_put_float(buf, 5, y);
	_mav_put_float(buf, 9, z);
	_mav_put_float(buf, 13, yaw);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#else
	mavlink_local_position_setpoint_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
}

/**
 * @brief Pack a local_position_setpoint message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw Desired yaw angle
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_local_position_setpoint_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t coordinate_frame
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_float(buf, 1, x);
	_mav_put_float(buf, 5, y);
	_mav_put_float(buf, 9, z);
	_mav_put_float(buf, 13, yaw);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#else
	mavlink_local_position_setpoint_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
}

/**
 * @brief Encode a local_position_setpoint struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param local_position_setpoint C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_local_position_setpoint_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_local_position_setpoint_t* local_position_setpoint
	)
{
	return mavlink_msg_local_position_setpoint_pack(
	 system_id
	,component_id
	,msg
	,local_position_setpoint->coordinate_frame
	,local_position_setpoint->x
	,local_position_setpoint->y
	,local_position_setpoint->z
	,local_position_setpoint->yaw
	);
}

/**
 * @brief Encode a local_position_setpoint struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param local_position_setpoint C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_local_position_setpoint_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_local_position_setpoint_t* local_position_setpoint
	)
{
	return mavlink_msg_local_position_setpoint_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,local_position_setpoint->coordinate_frame
	,local_position_setpoint->x
	,local_position_setpoint->y
	,local_position_setpoint->z
	,local_position_setpoint->yaw
	);
}

/**
 * @brief Send a local_position_setpoint message
 * @param chan The MAVLink channel to send this message
 *
 * @param coordinate_frame Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw Desired yaw angle
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_local_position_setpoint_send(
	 mavlink_channel_t chan
	,uint8_t coordinate_frame
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_float(buf, 1, x);
	_mav_put_float(buf, 5, y);
	_mav_put_float(buf, 9, z);
	_mav_put_float(buf, 13, yaw);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
#else
	mavlink_local_position_setpoint_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, (const char*)&packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, (const char*)&packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_local_position_setpoint_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t coordinate_frame
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN];
	_mav_put_uint8_t(buf, 0, coordinate_frame);
	_mav_put_float(buf, 1, x);
	_mav_put_float(buf, 5, y);
	_mav_put_float(buf, 9, z);
	_mav_put_float(buf, 13, yaw);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, buf, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
#else
	mavlink_local_position_setpoint_t packet;
	packet.coordinate_frame = coordinate_frame;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, (const char*)&packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT, (const char*)&packet, MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE LOCAL_POSITION_SETPOINT UNPACKING

/**
 * @brief Get field coordinate_frame from local_position_setpoint message
 *
 * @return Coordinate frame - valid values are only MAV_FRAME_LOCAL_NED or MAV_FRAME_LOCAL_ENU
 */
static inline uint8_t mavlink_msg_local_position_setpoint_get_coordinate_frame(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field x from local_position_setpoint message
 *
 * @return x position
 */
static inline float mavlink_msg_local_position_setpoint_get_x(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,1);
}

/**
 * @brief Get field y from local_position_setpoint message
 *
 * @return y position
 */
static inline float mavlink_msg_local_position_setpoint_get_y(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,5);
}

/**
 * @brief Get field z from local_position_setpoint message
 *
 * @return z position
 */
static inline float mavlink_msg_local_position_setpoint_get_z(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,9);
}

/**
 * @brief Get field yaw from local_position_setpoint message
 *
 * @return Desired yaw angle
 */
static inline float mavlink_msg_local_position_setpoint_get_yaw(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,13);
}

/**
 * @brief Decode a local_position_setpoint message into a struct
 *
 * @param msg The message to decode
 * @param local_position_setpoint C-struct to decode the message contents into
 */
static inline void mavlink_msg_local_position_setpoint_decode(const mavlink_message_t* msg, mavlink_local_position_setpoint_t* local_position_setpoint)
{
#if MAVLINK_NEED_BYTE_SWAP
	local_position_setpoint->coordinate_frame = mavlink_msg_local_position_setpoint_get_coordinate_frame(msg);
	local_position_setpoint->x = mavlink_msg_local_position_setpoint_get_x(msg);
	local_position_setpoint->y = mavlink_msg_local_position_setpoint_get_y(msg);
	local_position_setpoint->z = mavlink_msg_local_position_setpoint_get_z(msg);
	local_position_setpoint->yaw = mavlink_msg_local_position_setpoint_get_yaw(msg);
#else
	memcpy(local_position_setpoint, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_LOCAL_POSITION_SETPOINT_LEN);
#endif
}
