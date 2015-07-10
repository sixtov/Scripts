// MESSAGE FILE_TRANSFER_DIR_LIST PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST 111 

typedef struct __mavlink_file_transfer_dir_list_t 
{ 
  uint64_t transfer_uid;  ///< Unique transfer ID
  char dir_path[240];  ///< Directory path to list
  uint8_t flags;  ///< RESERVED
} mavlink_file_transfer_dir_list_t;

#define MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN 249
#define MAVLINK_MSG_ID_111_LEN 249

#define MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC 0
#define MAVLINK_MSG_ID_111_CRC 0

#define MAVLINK_MESSAGE_INFO_FILE_TRANSFER_DIR_LIST \
{ \
  "FILE_TRANSFER_DIR_LIST", \
  3, \
  { \
    { "transfer_uid", NULL, MAVLINK_TYPE_UINT64_T, 0, 0, offsetof(mavlink_file_transfer_dir_list_t, transfer_uid) }, \
    { "dir_path", NULL, MAVLINK_TYPE_CHAR, 240, 8, offsetof(mavlink_file_transfer_dir_list_t, dir_path) }, \
    { "flags", NULL, MAVLINK_TYPE_UINT8_T, 0, 9, offsetof(mavlink_file_transfer_dir_list_t, flags) }, \
  } \
}

/**
 * @brief Pack a file_transfer_dir_list message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param transfer_uid Unique transfer ID
 * @param dir_path Directory path to list
 * @param flags RESERVED
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_file_transfer_dir_list_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint64_t transfer_uid
	,const char* dir_path
	,uint8_t flags
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN];
	_mav_put_uint64_t(buf, 0, transfer_uid);
	_mav_put_char_array(buf, 8, dir_path, 240);
	_mav_put_uint8_t(buf, 9, flags);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#else
	mavlink_file_transfer_dir_list_t packet;
	packet.transfer_uid = transfer_uid;
	mav_array_memcpy(packet.dir_path, dir_path, sizeof(char)*240);
	packet.flags = flags;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
}

/**
 * @brief Pack a file_transfer_dir_list message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param transfer_uid Unique transfer ID
 * @param dir_path Directory path to list
 * @param flags RESERVED
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_file_transfer_dir_list_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint64_t transfer_uid
	,const char* dir_path
	,uint8_t flags
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN];
	_mav_put_uint64_t(buf, 0, transfer_uid);
	_mav_put_char_array(buf, 8, dir_path, 240);
	_mav_put_uint8_t(buf, 9, flags);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#else
	mavlink_file_transfer_dir_list_t packet;
	packet.transfer_uid = transfer_uid;
	mav_array_memcpy(packet.dir_path, dir_path, sizeof(char)*240);
	packet.flags = flags;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
}

/**
 * @brief Encode a file_transfer_dir_list struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param file_transfer_dir_list C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_file_transfer_dir_list_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_file_transfer_dir_list_t* file_transfer_dir_list
	)
{
	return mavlink_msg_file_transfer_dir_list_pack(
	 system_id
	,component_id
	,msg
	,file_transfer_dir_list->transfer_uid
	,file_transfer_dir_list->dir_path
	,file_transfer_dir_list->flags
	);
}

/**
 * @brief Encode a file_transfer_dir_list struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param file_transfer_dir_list C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_file_transfer_dir_list_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_file_transfer_dir_list_t* file_transfer_dir_list
	)
{
	return mavlink_msg_file_transfer_dir_list_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,file_transfer_dir_list->transfer_uid
	,file_transfer_dir_list->dir_path
	,file_transfer_dir_list->flags
	);
}

/**
 * @brief Send a file_transfer_dir_list message
 * @param chan The MAVLink channel to send this message
 *
 * @param transfer_uid Unique transfer ID
 * @param dir_path Directory path to list
 * @param flags RESERVED
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_file_transfer_dir_list_send(
	 mavlink_channel_t chan
	,uint64_t transfer_uid
	,const char* dir_path
	,uint8_t flags
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN];
	_mav_put_uint64_t(buf, 0, transfer_uid);
	_mav_put_char_array(buf, 8, dir_path, 240);
	_mav_put_uint8_t(buf, 9, flags);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
#else
	mavlink_file_transfer_dir_list_t packet;
	packet.transfer_uid = transfer_uid;
	mav_array_memcpy(packet.dir_path, dir_path, sizeof(char)*240);
	packet.flags = flags;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, (const char*)&packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, (const char*)&packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_file_transfer_dir_list_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint64_t transfer_uid
	,const char* dir_path
	,uint8_t flags
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN];
	_mav_put_uint64_t(buf, 0, transfer_uid);
	_mav_put_char_array(buf, 8, dir_path, 240);
	_mav_put_uint8_t(buf, 9, flags);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, buf, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
#else
	mavlink_file_transfer_dir_list_t packet;
	packet.transfer_uid = transfer_uid;
	mav_array_memcpy(packet.dir_path, dir_path, sizeof(char)*240);
	packet.flags = flags;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, (const char*)&packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST, (const char*)&packet, MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE FILE_TRANSFER_DIR_LIST UNPACKING

/**
 * @brief Get field transfer_uid from file_transfer_dir_list message
 *
 * @return Unique transfer ID
 */
static inline uint64_t mavlink_msg_file_transfer_dir_list_get_transfer_uid(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint64_t(msg,0);
}

/**
 * @brief Get field dir_path from file_transfer_dir_list message
 *
 * @return Directory path to list
 */
static inline char mavlink_msg_file_transfer_dir_list_get_dir_path(const mavlink_message_t* msg, char* dir_path)
{
	return _MAV_RETURN_char_array(msg,dir_path,240,8);
}

/**
 * @brief Get field flags from file_transfer_dir_list message
 *
 * @return RESERVED
 */
static inline uint8_t mavlink_msg_file_transfer_dir_list_get_flags(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,9);
}

/**
 * @brief Decode a file_transfer_dir_list message into a struct
 *
 * @param msg The message to decode
 * @param file_transfer_dir_list C-struct to decode the message contents into
 */
static inline void mavlink_msg_file_transfer_dir_list_decode(const mavlink_message_t* msg, mavlink_file_transfer_dir_list_t* file_transfer_dir_list)
{
#if MAVLINK_NEED_BYTE_SWAP
	file_transfer_dir_list->transfer_uid = mavlink_msg_file_transfer_dir_list_get_transfer_uid(msg);
	mavlink_msg_file_transfer_dir_list_get_dir_path(msg, file_transfer_dir_list->dir_path);
	file_transfer_dir_list->flags = mavlink_msg_file_transfer_dir_list_get_flags(msg);
#else
	memcpy(file_transfer_dir_list, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_FILE_TRANSFER_DIR_LIST_LEN);
#endif
}
