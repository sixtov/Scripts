// MESSAGE SET_ALTITUDE PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_SET_ALTITUDE 65 

typedef struct __mavlink_set_altitude_t 
{ 
  uint32_t mode;  ///< The new altitude in meters
  uint8_t target;  ///< The system setting the altitude
} mavlink_set_altitude_t;

#define MAVLINK_MSG_ID_SET_ALTITUDE_LEN 5
#define MAVLINK_MSG_ID_65_LEN 5

#define MAVLINK_MESSAGE_INFO_SET_ALTITUDE \
{ \
  "SET_ALTITUDE", \
  2, \
  { \
    { "mode", NULL, MAVLINK_TYPE_UINT32_T, 0, 0, offsetof(mavlink_set_altitude_t, mode) }, \
    { "target", NULL, MAVLINK_TYPE_UINT8_T, 0, 4, offsetof(mavlink_set_altitude_t, target) }, \
  } \
}

/**
 * @brief Pack a set_altitude message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param target The system setting the altitude
 * @param mode The new altitude in meters
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_set_altitude_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t target
	,uint32_t mode
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_ALTITUDE_LEN];
	_mav_put_uint32_t(buf, 0, mode);
	_mav_put_uint8_t(buf, 4, target);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#else
	mavlink_set_altitude_t packet;
	packet.mode = mode;
	packet.target = target;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SET_ALTITUDE;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
}

/**
 * @brief Pack a set_altitude message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param target The system setting the altitude
 * @param mode The new altitude in meters
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_set_altitude_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t target
	,uint32_t mode
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_ALTITUDE_LEN];
	_mav_put_uint32_t(buf, 0, mode);
	_mav_put_uint8_t(buf, 4, target);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#else
	mavlink_set_altitude_t packet;
	packet.target = target;
	packet.mode = mode;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SET_ALTITUDE;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
}

/**
 * @brief Encode a set_altitude struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param set_altitude C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_set_altitude_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_set_altitude_t* set_altitude
	)
{
	return mavlink_msg_set_altitude_pack(
	 system_id
	,component_id
	,msg
	,set_altitude->target
	,set_altitude->mode
	);
}

/**
 * @brief Send a set_altitude message
 * @param chan The MAVLink channel to send this message
 *
 * @param target The system setting the altitude
 * @param mode The new altitude in meters
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_set_altitude_send(
	 mavlink_channel_t chan
	,uint8_t target
	,uint32_t mode
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_ALTITUDE_LEN];
	_mav_put_uint32_t(buf, 0, mode);
	_mav_put_uint8_t(buf, 4, target);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_ALTITUDE, buf, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#else
	mavlink_set_altitude_t packet;
	packet.target = target;
	packet.mode = mode;

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SET_ALTITUDE, (const char*)&packet, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#endif
}

static inline void mavlink_msg_wID_set_altitude_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t target
	,uint32_t mode
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SET_ALTITUDE_LEN];
	_mav_put_uint32_t(buf, 0, mode);
	_mav_put_uint8_t(buf, 4, target);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_ALTITUDE, buf, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#else
	mavlink_set_altitude_t packet;
	packet.target = target;
	packet.mode = mode;

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SET_ALTITUDE, (const char*)&packet, MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE SET_ALTITUDE UNPACKING

/**
 * @brief Get field target from set_altitude message
 *
 * @return The system setting the altitude
 */
static inline uint8_t mavlink_msg_set_altitude_get_target(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field mode from set_altitude message
 *
 * @return The new altitude in meters
 */
static inline uint32_t mavlink_msg_set_altitude_get_mode(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint32_t(msg,1);
}

/**
 * @brief Decode a set_altitude message into a struct
 *
 * @param msg The message to decode
 * @param set_altitude C-struct to decode the message contents into
 */
static inline void mavlink_msg_set_altitude_decode(const mavlink_message_t* msg, mavlink_set_altitude_t* set_altitude)
{
#if MAVLINK_NEED_BYTE_SWAP
	set_altitude->target = mavlink_msg_set_altitude_get_target(msg);
	set_altitude->mode = mavlink_msg_set_altitude_get_mode(msg);
#else
	memcpy(set_altitude, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_SET_ALTITUDE_LEN);
#endif
}
