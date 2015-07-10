// MESSAGE NAMED_VALUE_FLOAT PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_NAMED_VALUE_FLOAT 252 

typedef struct __mavlink_named_value_float_t 
{ 
  char name[10];  ///< Name of the debug variable
  float value;  ///< Floating point value
} mavlink_named_value_float_t;

#define MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN 14
#define MAVLINK_MSG_ID_252_LEN 14

#define MAVLINK_MESSAGE_INFO_NAMED_VALUE_FLOAT \
{ \
  "NAMED_VALUE_FLOAT", \
  2, \
  { \
    { "name", NULL, MAVLINK_TYPE_CHAR, 10, 0, offsetof(mavlink_named_value_float_t, name) }, \
    { "value", NULL, MAVLINK_TYPE_FLOAT, 0, 1, offsetof(mavlink_named_value_float_t, value) }, \
  } \
}

/**
 * @brief Pack a named_value_float message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param name Name of the debug variable
 * @param value Floating point value
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_named_value_float_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const char* name
	,float value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN];
	_mav_put_char_array(buf, 0, name, 10);
	_mav_put_float(buf, 1, value);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#else
	mavlink_named_value_float_t packet;
	mav_array_memcpy(packet.name, name, sizeof(char)*10);
	packet.value = value;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_NAMED_VALUE_FLOAT;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
}

/**
 * @brief Pack a named_value_float message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param name Name of the debug variable
 * @param value Floating point value
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_named_value_float_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const char* name
	,float value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN];
	_mav_put_char_array(buf, 0, name, 10);
	_mav_put_float(buf, 1, value);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#else
	mavlink_named_value_float_t packet;
	mav_array_memcpy(packet.name, name, sizeof(char)*10);
	packet.value = value;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_NAMED_VALUE_FLOAT;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
}

/**
 * @brief Encode a named_value_float struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param named_value_float C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_named_value_float_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_named_value_float_t* named_value_float
	)
{
	return mavlink_msg_named_value_float_pack(
	 system_id
	,component_id
	,msg
	,named_value_float->name
	,named_value_float->value
	);
}

/**
 * @brief Send a named_value_float message
 * @param chan The MAVLink channel to send this message
 *
 * @param name Name of the debug variable
 * @param value Floating point value
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_named_value_float_send(
	 mavlink_channel_t chan
	,const char* name
	,float value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN];
	_mav_put_char_array(buf, 0, name, 10);
	_mav_put_float(buf, 1, value);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT, buf, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#else
	mavlink_named_value_float_t packet;
	mav_array_memcpy(packet.name, name, sizeof(char)*10);
	packet.value = value;

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT, (const char*)&packet, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#endif
}

static inline void mavlink_msg_wID_named_value_float_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,const char* name
	,float value
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN];
	_mav_put_char_array(buf, 0, name, 10);
	_mav_put_float(buf, 1, value);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT, buf, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#else
	mavlink_named_value_float_t packet;
	mav_array_memcpy(packet.name, name, sizeof(char)*10);
	packet.value = value;

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT, (const char*)&packet, MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE NAMED_VALUE_FLOAT UNPACKING

/**
 * @brief Get field name from named_value_float message
 *
 * @return Name of the debug variable
 */
static inline char mavlink_msg_named_value_float_get_name(const mavlink_message_t* msg, char* name)
{
	return _MAV_RETURN_char_array(msg,name,10,0);
}

/**
 * @brief Get field value from named_value_float message
 *
 * @return Floating point value
 */
static inline float mavlink_msg_named_value_float_get_value(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,1);
}

/**
 * @brief Decode a named_value_float message into a struct
 *
 * @param msg The message to decode
 * @param named_value_float C-struct to decode the message contents into
 */
static inline void mavlink_msg_named_value_float_decode(const mavlink_message_t* msg, mavlink_named_value_float_t* named_value_float)
{
#if MAVLINK_NEED_BYTE_SWAP
	mavlink_msg_named_value_float_get_name(msg, named_value_float->name);
	named_value_float->value = mavlink_msg_named_value_float_get_value(msg);
#else
	memcpy(named_value_float, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_NAMED_VALUE_FLOAT_LEN);
#endif
}
