// MESSAGE LOG_ENTRY PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_LOG_ENTRY 118 

typedef struct __mavlink_log_entry_t 
{ 
  uint16_t id;  ///< Log id
  uint16_t num_logs;  ///< Total number of logs
  uint16_t last_log_num;  ///< High log number
  uint32_t time_utc;  ///< UTC timestamp of log in seconds since 1970, or 0 if not available
  uint32_t size;  ///< Size of the log (may be approximate) in bytes
} mavlink_log_entry_t;

#define MAVLINK_MSG_ID_LOG_ENTRY_LEN 14
#define MAVLINK_MSG_ID_118_LEN 14

#define MAVLINK_MSG_ID_LOG_ENTRY_CRC 0
#define MAVLINK_MSG_ID_118_CRC 0

#define MAVLINK_MESSAGE_INFO_LOG_ENTRY \
{ \
  "LOG_ENTRY", \
  5, \
  { \
    { "id", NULL, MAVLINK_TYPE_UINT16_T, 0, 0, offsetof(mavlink_log_entry_t, id) }, \
    { "num_logs", NULL, MAVLINK_TYPE_UINT16_T, 0, 2, offsetof(mavlink_log_entry_t, num_logs) }, \
    { "last_log_num", NULL, MAVLINK_TYPE_UINT16_T, 0, 4, offsetof(mavlink_log_entry_t, last_log_num) }, \
    { "time_utc", NULL, MAVLINK_TYPE_UINT32_T, 0, 6, offsetof(mavlink_log_entry_t, time_utc) }, \
    { "size", NULL, MAVLINK_TYPE_UINT32_T, 0, 10, offsetof(mavlink_log_entry_t, size) }, \
  } \
}

/**
 * @brief Pack a log_entry message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param id Log id
 * @param num_logs Total number of logs
 * @param last_log_num High log number
 * @param time_utc UTC timestamp of log in seconds since 1970, or 0 if not available
 * @param size Size of the log (may be approximate) in bytes
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_log_entry_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint16_t id
	,uint16_t num_logs
	,uint16_t last_log_num
	,uint32_t time_utc
	,uint32_t size
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOG_ENTRY_LEN];
	_mav_put_uint16_t(buf, 0, id);
	_mav_put_uint16_t(buf, 2, num_logs);
	_mav_put_uint16_t(buf, 4, last_log_num);
	_mav_put_uint32_t(buf, 6, time_utc);
	_mav_put_uint32_t(buf, 10, size);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#else
	mavlink_log_entry_t packet;
	packet.id = id;
	packet.num_logs = num_logs;
	packet.last_log_num = last_log_num;
	packet.time_utc = time_utc;
	packet.size = size;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_LOG_ENTRY;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
}

/**
 * @brief Pack a log_entry message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param id Log id
 * @param num_logs Total number of logs
 * @param last_log_num High log number
 * @param time_utc UTC timestamp of log in seconds since 1970, or 0 if not available
 * @param size Size of the log (may be approximate) in bytes
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_log_entry_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint16_t id
	,uint16_t num_logs
	,uint16_t last_log_num
	,uint32_t time_utc
	,uint32_t size
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOG_ENTRY_LEN];
	_mav_put_uint16_t(buf, 0, id);
	_mav_put_uint16_t(buf, 2, num_logs);
	_mav_put_uint16_t(buf, 4, last_log_num);
	_mav_put_uint32_t(buf, 6, time_utc);
	_mav_put_uint32_t(buf, 10, size);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#else
	mavlink_log_entry_t packet;
	packet.id = id;
	packet.num_logs = num_logs;
	packet.last_log_num = last_log_num;
	packet.time_utc = time_utc;
	packet.size = size;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_LOG_ENTRY;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
}

/**
 * @brief Encode a log_entry struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param log_entry C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_log_entry_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_log_entry_t* log_entry
	)
{
	return mavlink_msg_log_entry_pack(
	 system_id
	,component_id
	,msg
	,log_entry->id
	,log_entry->num_logs
	,log_entry->last_log_num
	,log_entry->time_utc
	,log_entry->size
	);
}

/**
 * @brief Encode a log_entry struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param log_entry C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_log_entry_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_log_entry_t* log_entry
	)
{
	return mavlink_msg_log_entry_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,log_entry->id
	,log_entry->num_logs
	,log_entry->last_log_num
	,log_entry->time_utc
	,log_entry->size
	);
}

/**
 * @brief Send a log_entry message
 * @param chan The MAVLink channel to send this message
 *
 * @param id Log id
 * @param num_logs Total number of logs
 * @param last_log_num High log number
 * @param time_utc UTC timestamp of log in seconds since 1970, or 0 if not available
 * @param size Size of the log (may be approximate) in bytes
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_log_entry_send(
	 mavlink_channel_t chan
	,uint16_t id
	,uint16_t num_logs
	,uint16_t last_log_num
	,uint32_t time_utc
	,uint32_t size
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOG_ENTRY_LEN];
	_mav_put_uint16_t(buf, 0, id);
	_mav_put_uint16_t(buf, 2, num_logs);
	_mav_put_uint16_t(buf, 4, last_log_num);
	_mav_put_uint32_t(buf, 6, time_utc);
	_mav_put_uint32_t(buf, 10, size);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOG_ENTRY, buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOG_ENTRY, buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
#else
	mavlink_log_entry_t packet;
	packet.id = id;
	packet.num_logs = num_logs;
	packet.last_log_num = last_log_num;
	packet.time_utc = time_utc;
	packet.size = size;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOG_ENTRY, (const char*)&packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_LOG_ENTRY, (const char*)&packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_log_entry_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint16_t id
	,uint16_t num_logs
	,uint16_t last_log_num
	,uint32_t time_utc
	,uint32_t size
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_LOG_ENTRY_LEN];
	_mav_put_uint16_t(buf, 0, id);
	_mav_put_uint16_t(buf, 2, num_logs);
	_mav_put_uint16_t(buf, 4, last_log_num);
	_mav_put_uint32_t(buf, 6, time_utc);
	_mav_put_uint32_t(buf, 10, size);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOG_ENTRY, buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOG_ENTRY, buf, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
#else
	mavlink_log_entry_t packet;
	packet.id = id;
	packet.num_logs = num_logs;
	packet.last_log_num = last_log_num;
	packet.time_utc = time_utc;
	packet.size = size;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOG_ENTRY, (const char*)&packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN, MAVLINK_MSG_ID_LOG_ENTRY_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_LOG_ENTRY, (const char*)&packet, MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE LOG_ENTRY UNPACKING

/**
 * @brief Get field id from log_entry message
 *
 * @return Log id
 */
static inline uint16_t mavlink_msg_log_entry_get_id(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,0);
}

/**
 * @brief Get field num_logs from log_entry message
 *
 * @return Total number of logs
 */
static inline uint16_t mavlink_msg_log_entry_get_num_logs(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,2);
}

/**
 * @brief Get field last_log_num from log_entry message
 *
 * @return High log number
 */
static inline uint16_t mavlink_msg_log_entry_get_last_log_num(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,4);
}

/**
 * @brief Get field time_utc from log_entry message
 *
 * @return UTC timestamp of log in seconds since 1970, or 0 if not available
 */
static inline uint32_t mavlink_msg_log_entry_get_time_utc(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint32_t(msg,6);
}

/**
 * @brief Get field size from log_entry message
 *
 * @return Size of the log (may be approximate) in bytes
 */
static inline uint32_t mavlink_msg_log_entry_get_size(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint32_t(msg,10);
}

/**
 * @brief Decode a log_entry message into a struct
 *
 * @param msg The message to decode
 * @param log_entry C-struct to decode the message contents into
 */
static inline void mavlink_msg_log_entry_decode(const mavlink_message_t* msg, mavlink_log_entry_t* log_entry)
{
#if MAVLINK_NEED_BYTE_SWAP
	log_entry->id = mavlink_msg_log_entry_get_id(msg);
	log_entry->num_logs = mavlink_msg_log_entry_get_num_logs(msg);
	log_entry->last_log_num = mavlink_msg_log_entry_get_last_log_num(msg);
	log_entry->time_utc = mavlink_msg_log_entry_get_time_utc(msg);
	log_entry->size = mavlink_msg_log_entry_get_size(msg);
#else
	memcpy(log_entry, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_LOG_ENTRY_LEN);
#endif
}