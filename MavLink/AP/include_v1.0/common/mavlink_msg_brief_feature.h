// MESSAGE BRIEF_FEATURE PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_BRIEF_FEATURE 195 

typedef struct __mavlink_brief_feature_t 
{ 
  float x;  ///< x position in m
  float y;  ///< y position in m
  float z;  ///< z position in m
  float response;  ///< Harris operator response at this location
  uint16_t size;  ///< Size in pixels
  uint16_t orientation;  ///< Orientation
  uint8_t orientation_assignment[0];  ///< Orientation assignment 0: false, 1:true
  uint8_t descriptor;  ///< Descriptor
} mavlink_brief_feature_t;

#define MAVLINK_MSG_ID_BRIEF_FEATURE_LEN 53
#define MAVLINK_MSG_ID_195_LEN 53

#define MAVLINK_MSG_ID_BRIEF_FEATURE_CRC 0
#define MAVLINK_MSG_ID_195_CRC 0

#define MAVLINK_MESSAGE_INFO_BRIEF_FEATURE \
{ \
  "BRIEF_FEATURE", \
  8, \
  { \
    { "x", NULL, MAVLINK_TYPE_FLOAT, 0, 0, offsetof(mavlink_brief_feature_t, x) }, \
    { "y", NULL, MAVLINK_TYPE_FLOAT, 0, 4, offsetof(mavlink_brief_feature_t, y) }, \
    { "z", NULL, MAVLINK_TYPE_FLOAT, 0, 8, offsetof(mavlink_brief_feature_t, z) }, \
    { "response", NULL, MAVLINK_TYPE_FLOAT, 0, 12, offsetof(mavlink_brief_feature_t, response) }, \
    { "size", NULL, MAVLINK_TYPE_UINT16_T, 0, 16, offsetof(mavlink_brief_feature_t, size) }, \
    { "orientation", NULL, MAVLINK_TYPE_UINT16_T, 0, 18, offsetof(mavlink_brief_feature_t, orientation) }, \
    { "orientation_assignment", NULL, MAVLINK_TYPE_UINT8_T, 0, 20, offsetof(mavlink_brief_feature_t, orientation_assignment) }, \
    { "descriptor", NULL, MAVLINK_TYPE_UINT8_T, 32, 21, offsetof(mavlink_brief_feature_t, descriptor) }, \
  } \
}

/**
 * @brief Pack a brief_feature message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param x x position in m
 * @param y y position in m
 * @param z z position in m
 * @param orientation_assignment Orientation assignment 0: false, 1:true
 * @param size Size in pixels
 * @param orientation Orientation
 * @param descriptor Descriptor
 * @param response Harris operator response at this location
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_brief_feature_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,float x
	,float y
	,float z
	,uint8_t orientation_assignment
	,uint16_t size
	,uint16_t orientation
	,const uint8_t* descriptor
	,float response
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BRIEF_FEATURE_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, response);
	_mav_put_uint16_t(buf, 16, size);
	_mav_put_uint16_t(buf, 18, orientation);
	_mav_put_uint8_t_array(buf, 20, orientation_assignment, 0);
	_mav_put_uint8_t(buf, 21, descriptor);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#else
	mavlink_brief_feature_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.response = response;
	packet.size = size;
	packet.orientation = orientation;
	mav_array_memcpy(packet.orientation_assignment, orientation_assignment, sizeof(uint8_t)*0);
	packet.descriptor = descriptor;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_BRIEF_FEATURE;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
}

/**
 * @brief Pack a brief_feature message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param x x position in m
 * @param y y position in m
 * @param z z position in m
 * @param orientation_assignment Orientation assignment 0: false, 1:true
 * @param size Size in pixels
 * @param orientation Orientation
 * @param descriptor Descriptor
 * @param response Harris operator response at this location
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_brief_feature_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,float x
	,float y
	,float z
	,uint8_t orientation_assignment
	,uint16_t size
	,uint16_t orientation
	,const uint8_t* descriptor
	,float response
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BRIEF_FEATURE_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, response);
	_mav_put_uint16_t(buf, 16, size);
	_mav_put_uint16_t(buf, 18, orientation);
	_mav_put_uint8_t_array(buf, 20, orientation_assignment, 0);
	_mav_put_uint8_t(buf, 21, descriptor);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#else
	mavlink_brief_feature_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.orientation_assignment = orientation_assignment;
	packet.size = size;
	packet.orientation = orientation;
	mav_array_memcpy(packet.descriptor, descriptor, sizeof(uint8_t)*32);
	packet.response = response;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_BRIEF_FEATURE;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
}

/**
 * @brief Encode a brief_feature struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param brief_feature C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_brief_feature_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_brief_feature_t* brief_feature
	)
{
	return mavlink_msg_brief_feature_pack(
	 system_id
	,component_id
	,msg
	,brief_feature->x
	,brief_feature->y
	,brief_feature->z
	,brief_feature->orientation_assignment
	,brief_feature->size
	,brief_feature->orientation
	,brief_feature->descriptor
	,brief_feature->response
	);
}

/**
 * @brief Encode a brief_feature struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param brief_feature C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_brief_feature_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_brief_feature_t* brief_feature
	)
{
	return mavlink_msg_brief_feature_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,brief_feature->x
	,brief_feature->y
	,brief_feature->z
	,brief_feature->orientation_assignment
	,brief_feature->size
	,brief_feature->orientation
	,brief_feature->descriptor
	,brief_feature->response
	);
}

/**
 * @brief Send a brief_feature message
 * @param chan The MAVLink channel to send this message
 *
 * @param x x position in m
 * @param y y position in m
 * @param z z position in m
 * @param orientation_assignment Orientation assignment 0: false, 1:true
 * @param size Size in pixels
 * @param orientation Orientation
 * @param descriptor Descriptor
 * @param response Harris operator response at this location
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_brief_feature_send(
	 mavlink_channel_t chan
	,float x
	,float y
	,float z
	,uint8_t orientation_assignment
	,uint16_t size
	,uint16_t orientation
	,const uint8_t* descriptor
	,float response
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BRIEF_FEATURE_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, response);
	_mav_put_uint16_t(buf, 16, size);
	_mav_put_uint16_t(buf, 18, orientation);
	_mav_put_uint8_t_array(buf, 20, orientation_assignment, 0);
	_mav_put_uint8_t(buf, 21, descriptor);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BRIEF_FEATURE, buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BRIEF_FEATURE, buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
#else
	mavlink_brief_feature_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.orientation_assignment = orientation_assignment;
	packet.size = size;
	packet.orientation = orientation;
	mav_array_memcpy(packet.descriptor, descriptor, sizeof(uint8_t)*32);
	packet.response = response;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BRIEF_FEATURE, (const char*)&packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BRIEF_FEATURE, (const char*)&packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_brief_feature_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,float x
	,float y
	,float z
	,uint8_t orientation_assignment
	,uint16_t size
	,uint16_t orientation
	,const uint8_t* descriptor
	,float response
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BRIEF_FEATURE_LEN];
	_mav_put_float(buf, 0, x);
	_mav_put_float(buf, 4, y);
	_mav_put_float(buf, 8, z);
	_mav_put_float(buf, 12, response);
	_mav_put_uint16_t(buf, 16, size);
	_mav_put_uint16_t(buf, 18, orientation);
	_mav_put_uint8_t_array(buf, 20, orientation_assignment, 0);
	_mav_put_uint8_t(buf, 21, descriptor);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BRIEF_FEATURE, buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BRIEF_FEATURE, buf, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
#else
	mavlink_brief_feature_t packet;
	packet.x = x;
	packet.y = y;
	packet.z = z;
	packet.orientation_assignment = orientation_assignment;
	packet.size = size;
	packet.orientation = orientation;
	mav_array_memcpy(packet.descriptor, descriptor, sizeof(uint8_t)*32);
	packet.response = response;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BRIEF_FEATURE, (const char*)&packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN, MAVLINK_MSG_ID_BRIEF_FEATURE_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BRIEF_FEATURE, (const char*)&packet, MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE BRIEF_FEATURE UNPACKING

/**
 * @brief Get field x from brief_feature message
 *
 * @return x position in m
 */
static inline float mavlink_msg_brief_feature_get_x(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,0);
}

/**
 * @brief Get field y from brief_feature message
 *
 * @return y position in m
 */
static inline float mavlink_msg_brief_feature_get_y(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,4);
}

/**
 * @brief Get field z from brief_feature message
 *
 * @return z position in m
 */
static inline float mavlink_msg_brief_feature_get_z(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,8);
}

/**
 * @brief Get field orientation_assignment from brief_feature message
 *
 * @return Orientation assignment 0: false, 1:true
 */
static inline uint8_t mavlink_msg_brief_feature_get_orientation_assignment(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,12);
}

/**
 * @brief Get field size from brief_feature message
 *
 * @return Size in pixels
 */
static inline uint16_t mavlink_msg_brief_feature_get_size(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,13);
}

/**
 * @brief Get field orientation from brief_feature message
 *
 * @return Orientation
 */
static inline uint16_t mavlink_msg_brief_feature_get_orientation(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,15);
}

/**
 * @brief Get field descriptor from brief_feature message
 *
 * @return Descriptor
 */
static inline uint8_t mavlink_msg_brief_feature_get_descriptor(const mavlink_message_t* msg, uint8_t* descriptor)
{
	return _MAV_RETURN_uint8_t_array(msg,descriptor,32,17);
}

/**
 * @brief Get field response from brief_feature message
 *
 * @return Harris operator response at this location
 */
static inline float mavlink_msg_brief_feature_get_response(const mavlink_message_t* msg)
{
	return _MAV_RETURN_float(msg,18);
}

/**
 * @brief Decode a brief_feature message into a struct
 *
 * @param msg The message to decode
 * @param brief_feature C-struct to decode the message contents into
 */
static inline void mavlink_msg_brief_feature_decode(const mavlink_message_t* msg, mavlink_brief_feature_t* brief_feature)
{
#if MAVLINK_NEED_BYTE_SWAP
	brief_feature->x = mavlink_msg_brief_feature_get_x(msg);
	brief_feature->y = mavlink_msg_brief_feature_get_y(msg);
	brief_feature->z = mavlink_msg_brief_feature_get_z(msg);
	brief_feature->orientation_assignment = mavlink_msg_brief_feature_get_orientation_assignment(msg);
	brief_feature->size = mavlink_msg_brief_feature_get_size(msg);
	brief_feature->orientation = mavlink_msg_brief_feature_get_orientation(msg);
	mavlink_msg_brief_feature_get_descriptor(msg, brief_feature->descriptor);
	brief_feature->response = mavlink_msg_brief_feature_get_response(msg);
#else
	memcpy(brief_feature, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_BRIEF_FEATURE_LEN);
#endif
}
