// MESSAGE PARAM_SET PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_PARAM_SET 23 

typedef struct __mavlink_param_set_t 
{ 
  uint8_t param_id;  ///< Onboard parameter id
  float param_value;  ///< Onboard parameter value
  uint8_t target_system[0];  ///< System ID
  uint8_t target_component;  ///< Component ID
} mavlink_param_set_t;

#define MAVLINK_MSG_ID_PARAM_SET_LEN 21
#define MAVLINK_MSG_ID_23_LEN 21

#define MAVLINK_MESSAGE_INFO_PARAM_SET \
{ \
  "PARAM_SET", \
  4, \
  { \
    { "param_id", NULL, MAVLINK_TYPE_UINT8_T, 15, 0, offsetof(mavlink_param_set_t, param_id) }, \
    { "param_value", NULL, MAVLINK_TYPE_FLOAT, 0, 15, offsetof(mavlink_param_set_t, param_value) }, \
    { "target_system", NULL, MAVLINK_TYPE_UINT8_T, 0, 19, offsetof(mavlink_param_set_t, target_system) }, \
    { "target_component", NULL, MAVLINK_TYPE_UINT8_T, 0, 20, offsetof(mavlink_param_set_t, target_component) }, \
  } \
}

/**
 * @brief Pack a param_set message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param param_id Onboard parameter id
 * @param param_value Onboard parameter value
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_param_set_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t target_system
	,uint8_t target_component
	,const uint8_t* param_id
	,float param_value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_PARAM_SET_LEN];
	_mav_put_uint8_t(buf, 0, param_id);
	_mav_put_float(buf, 15, param_value);
	_mav_put_uint8_t_array(buf, 19, target_system, 0);
	_mav_put_uint8_t(buf, 20, target_component);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_PARAM_SET_LEN);
#else
	mavlink_param_set_t packet;
	packet.param_id = param_id;
	packet.param_value = param_value;
	mav_array_memcpy(packet.target_system, target_system, sizeof(uint8_t)*0);
	packet.target_component = target_component;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_PARAM_SET_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_PARAM_SET;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_PARAM_SET_LEN);
}

/**
 * @brief Pack a param_set message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param param_id Onboard parameter id
 * @param param_value Onboard parameter value
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_param_set_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t target_system
	,uint8_t target_component
	,const uint8_t* param_id
	,float param_value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_PARAM_SET_LEN];
	_mav_put_uint8_t(buf, 0, param_id);
	_mav_put_float(buf, 15, param_value);
	_mav_put_uint8_t_array(buf, 19, target_system, 0);
	_mav_put_uint8_t(buf, 20, target_component);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_PARAM_SET_LEN);
#else
	mavlink_param_set_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	mav_array_memcpy(packet.param_id, param_id, sizeof(uint8_t)*15);
	packet.param_value = param_value;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_PARAM_SET_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_PARAM_SET;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_PARAM_SET_LEN);
}

/**
 * @brief Encode a param_set struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param param_set C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_param_set_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_param_set_t* param_set
	)
{
	return mavlink_msg_param_set_pack(
	 system_id
	,component_id
	,msg
	,param_set->target_system
	,param_set->target_component
	,param_set->param_id
	,param_set->param_value
	);
}

/**
 * @brief Send a param_set message
 * @param chan The MAVLink channel to send this message
 *
 * @param target_system System ID
 * @param target_component Component ID
 * @param param_id Onboard parameter id
 * @param param_value Onboard parameter value
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_param_set_send(
	 mavlink_channel_t chan
	,uint8_t target_system
	,uint8_t target_component
	,const uint8_t* param_id
	,float param_value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_PARAM_SET_LEN];
	_mav_put_uint8_t(buf, 0, param_id);
	_mav_put_float(buf, 15, param_value);
	_mav_put_uint8_t_array(buf, 19, target_system, 0);
	_mav_put_uint8_t(buf, 20, target_component);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_PARAM_SET, buf, MAVLINK_MSG_ID_PARAM_SET_LEN);
#else
	mavlink_param_set_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	mav_array_memcpy(packet.param_id, param_id, sizeof(uint8_t)*15);
	packet.param_value = param_value;

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_PARAM_SET, (const char*)&packet, MAVLINK_MSG_ID_PARAM_SET_LEN);
#endif
}

static inline void mavlink_msg_wID_param_set_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t target_system
	,uint8_t target_component
	,const uint8_t* param_id
	,float param_value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_PARAM_SET_LEN];
	_mav_put_uint8_t(buf, 0, param_id);
	_mav_put_float(buf, 15, param_value);
	_mav_put_uint8_t_array(buf, 19, target_system, 0);
	_mav_put_uint8_t(buf, 20, target_component);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_PARAM_SET, buf, MAVLINK_MSG_ID_PARAM_SET_LEN);
#else
	mavlink_param_set_t packet;
	packet.target_system = target_system;
	packet.target_component = target_component;
	mav_array_memcpy(packet.param_id, param_id, sizeof(uint8_t)*15);
	packet.param_value = param_value;

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_PARAM_SET, (const char*)&packet, MAVLINK_MSG_ID_PARAM_SET_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE PARAM_SET UNPACKING

/**
 * @brief Get field target_system from param_set message
 *
 * @return System ID
 */
static inline uint8_t mavlink_msg_param_set_get_target_system(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field target_component from param_set message
 *
 * @return Component ID
 */
static inline uint8_t mavlink_msg_param_set_get_target_component(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,1);
}

/**
 * @brief Get field param_id from param_set message
 *
 * @return Onboard parameter id
 */
static inline uint8_t mavlink_msg_param_set_get_param_id(const mavlink_message_t* msg, uint8_t* param_id)
{
	return _MAV_RETURN_uint8_t_array(msg,param_id,15,2);
}

/**
 * @brief Get field param_value from param_set message
 *
 * @return Onboard parameter value
 */
static inline float mavlink_msg_param_set_get_param_value(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,17);
}

/**
 * @brief Decode a param_set message into a struct
 *
 * @param msg The message to decode
 * @param param_set C-struct to decode the message contents into
 */
static inline void mavlink_msg_param_set_decode(const mavlink_message_t* msg, mavlink_param_set_t* param_set)
{
#if MAVLINK_NEED_BYTE_SWAP
	param_set->target_system = mavlink_msg_param_set_get_target_system(msg);
	param_set->target_component = mavlink_msg_param_set_get_target_component(msg);
	mavlink_msg_param_set_get_param_id(msg, param_set->param_id);
	param_set->param_value = mavlink_msg_param_set_get_param_value(msg);
#else
	memcpy(param_set, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_PARAM_SET_LEN);
#endif
}
