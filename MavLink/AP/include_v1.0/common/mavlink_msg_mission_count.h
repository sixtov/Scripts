// MESSAGE MISSION_COUNT PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_MISSION_COUNT 44 

typedef struct __mavlink_mission_count_t 
{ 
  uint8_t target_system;  ///< System ID
  uint8_t target_component;  ///< Component ID
  uint16_t count;  ///< Number of mission items in the sequence
} mavlink_mission_count_t;

#define MAVLINK_MSG_ID_MISSION_COUNT_LEN 4
#define MAVLINK_MSG_ID_44_LEN 4

#define MAVLINK_MSG_ID_MISSION_COUNT_CRC 0
#define MAVLINK_MSG_ID_44_CRC 0

#define MAVLINK_MESSAGE_INFO_MISSION_COUNT \
{ \
  "MISSION_COUNT", \
  3, \
  { \
    { "target_system", NULL, MAVLINK_TYPE_UINT8_T, 0, 0, offsetof(mavlink_mission_count_t, target_system) }, \
    { "target_component", NULL, MAVLINK_TYPE_UINT8_T, 0, 1, offsetof(mavlink_mission_count_t, target_component) }, \
    { "count", NULL, MAVLINK_TYPE_UINT16_T, 0, 2, offsetof(mavlink_mission_count_t, count) }, \
  } \
}

/**
 * @brief Pack a mission_count message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param count Number of mission items in the sequence
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_mission_count_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t target_system
	,uint8_t target_component
	,uint16_t count
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_MISSION_COUNT_LEN];
	_mav_put_uint8_t(buf, 0, target_system);
	_mav_put_uint8_t(buf, 1, target_component);
	_mav_put_uint16_t(buf, 2, count);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#else
	mavlink_mission_count_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	packet.count = count;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_MISSION_COUNT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
}

/**
 * @brief Pack a mission_count message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param count Number of mission items in the sequence
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_mission_count_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t target_system
	,uint8_t target_component
	,uint16_t count
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_MISSION_COUNT_LEN];
	_mav_put_uint8_t(buf, 0, target_system);
	_mav_put_uint8_t(buf, 1, target_component);
	_mav_put_uint16_t(buf, 2, count);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#else
	mavlink_mission_count_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	packet.count = count;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_MISSION_COUNT;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
}

/**
 * @brief Encode a mission_count struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param mission_count C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_mission_count_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_mission_count_t* mission_count
	)
{
	return mavlink_msg_mission_count_pack(
	 system_id
	,component_id
	,msg
	,mission_count->target_system
	,mission_count->target_component
	,mission_count->count
	);
}

/**
 * @brief Encode a mission_count struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param mission_count C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_mission_count_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_mission_count_t* mission_count
	)
{
	return mavlink_msg_mission_count_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,mission_count->target_system
	,mission_count->target_component
	,mission_count->count
	);
}

/**
 * @brief Send a mission_count message
 * @param chan The MAVLink channel to send this message
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param count Number of mission items in the sequence
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_mission_count_send(
	 mavlink_channel_t chan
	,uint8_t target_system
	,uint8_t target_component
	,uint16_t count
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_MISSION_COUNT_LEN];
	_mav_put_uint8_t(buf, 0, target_system);
	_mav_put_uint8_t(buf, 1, target_component);
	_mav_put_uint16_t(buf, 2, count);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_MISSION_COUNT, buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_MISSION_COUNT, buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
#else
	mavlink_mission_count_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	packet.count = count;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_MISSION_COUNT, (const char*)&packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_MISSION_COUNT, (const char*)&packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_mission_count_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t target_system
	,uint8_t target_component
	,uint16_t count
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_MISSION_COUNT_LEN];
	_mav_put_uint8_t(buf, 0, target_system);
	_mav_put_uint8_t(buf, 1, target_component);
	_mav_put_uint16_t(buf, 2, count);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_MISSION_COUNT, buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_MISSION_COUNT, buf, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
#else
	mavlink_mission_count_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	packet.count = count;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_MISSION_COUNT, (const char*)&packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN, MAVLINK_MSG_ID_MISSION_COUNT_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_MISSION_COUNT, (const char*)&packet, MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE MISSION_COUNT UNPACKING

/**
 * @brief Get field target_system from mission_count message
 *
 * @return System ID
 */
static inline uint8_t mavlink_msg_mission_count_get_target_system(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field target_component from mission_count message
 *
 * @return Component ID
 */
static inline uint8_t mavlink_msg_mission_count_get_target_component(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,1);
}

/**
 * @brief Get field count from mission_count message
 *
 * @return Number of mission items in the sequence
 */
static inline uint16_t mavlink_msg_mission_count_get_count(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,2);
}

/**
 * @brief Decode a mission_count message into a struct
 *
 * @param msg The message to decode
 * @param mission_count C-struct to decode the message contents into
 */
static inline void mavlink_msg_mission_count_decode(const mavlink_message_t* msg, mavlink_mission_count_t* mission_count)
{
#if MAVLINK_NEED_BYTE_SWAP
	mission_count->target_system = mavlink_msg_mission_count_get_target_system(msg);
	mission_count->target_component = mavlink_msg_mission_count_get_target_component(msg);
	mission_count->count = mavlink_msg_mission_count_get_count(msg);
#else
	memcpy(mission_count, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_MISSION_COUNT_LEN);
#endif
}