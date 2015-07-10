// MESSAGE POSITION_TARGET PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_POSITION_TARGET 63 

typedef struct __mavlink_position_target_t 
{ 
  float x;  ///< x position
  float y;  ///< y position
  float z;  ///< z position
  float yaw;  ///< yaw orientation in radians, 0 = NORTH
} mavlink_position_target_t;

#define MAVLINK_MSG_ID_POSITION_TARGET_LEN 16
#define MAVLINK_MSG_ID_63_LEN 16

#define MAVLINK_MESSAGE_INFO_POSITION_TARGET \
{ \
  "POSITION_TARGET", \
  4, \
  { \
    { "x", NULL, MAVLINK_TYPE_FLOAT, 0, 0, offsetof(mavlink_position_target_t, x) }, \
    { "y", NULL, MAVLINK_TYPE_FLOAT, 0, 4, offsetof(mavlink_position_target_t, y) }, \
    { "z", NULL, MAVLINK_TYPE_FLOAT, 0, 8, offsetof(mavlink_position_target_t, z) }, \
    { "yaw", NULL, MAVLINK_TYPE_FLOAT, 0, 12, offsetof(mavlink_position_target_t, yaw) }, \
  } \
}

/**
 * @brief Pack a position_target message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw yaw orientation in radians, 0 = NORTH
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_position_target_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_POSITION_TARGET_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, yaw);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#else
	mavlink_position_target_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_POSITION_TARGET;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
}

/**
 * @brief Pack a position_target message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw yaw orientation in radians, 0 = NORTH
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_position_target_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_POSITION_TARGET_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, yaw);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#else
	mavlink_position_target_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_POSITION_TARGET;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
}

/**
 * @brief Encode a position_target struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param position_target C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_position_target_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_position_target_t* position_target
	)
{
	return mavlink_msg_position_target_pack(
	 system_id
	,component_id
	,msg
	,position_target->x
	,position_target->y
	,position_target->z
	,position_target->yaw
	);
}

/**
 * @brief Send a position_target message
 * @param chan The MAVLink channel to send this message
 *
 * @param x x position
 * @param y y position
 * @param z z position
 * @param yaw yaw orientation in radians, 0 = NORTH
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_position_target_send(
	 mavlink_channel_t chan
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_POSITION_TARGET_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, yaw);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_POSITION_TARGET, buf, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#else
	mavlink_position_target_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_POSITION_TARGET, (const char*)&packet, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#endif
}

static inline void mavlink_msg_wID_position_target_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,float x
	,float y
	,float z
	,float yaw
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_POSITION_TARGET_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, yaw);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_POSITION_TARGET, buf, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#else
	mavlink_position_target_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.yaw = yaw;

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_POSITION_TARGET, (const char*)&packet, MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE POSITION_TARGET UNPACKING

/**
 * @brief Get field x from position_target message
 *
 * @return x position
 */
static inline float mavlink_msg_position_target_get_x(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,0);
}

/**
 * @brief Get field y from position_target message
 *
 * @return y position
 */
static inline float mavlink_msg_position_target_get_y(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,4);
}

/**
 * @brief Get field z from position_target message
 *
 * @return z position
 */
static inline float mavlink_msg_position_target_get_z(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,8);
}

/**
 * @brief Get field yaw from position_target message
 *
 * @return yaw orientation in radians, 0 = NORTH
 */
static inline float mavlink_msg_position_target_get_yaw(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,12);
}

/**
 * @brief Decode a position_target message into a struct
 *
 * @param msg The message to decode
 * @param position_target C-struct to decode the message contents into
 */
static inline void mavlink_msg_position_target_decode(const mavlink_message_t* msg, mavlink_position_target_t* position_target)
{
#if MAVLINK_NEED_BYTE_SWAP
	position_target->x = mavlink_msg_position_target_get_x(msg);
	position_target->y = mavlink_msg_position_target_get_y(msg);
	position_target->z = mavlink_msg_position_target_get_z(msg);
	position_target->yaw = mavlink_msg_position_target_get_yaw(msg);
#else
	memcpy(position_target, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_POSITION_TARGET_LEN);
#endif
}