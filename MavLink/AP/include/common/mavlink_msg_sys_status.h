// MESSAGE SYS_STATUS PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_SYS_STATUS 34 

typedef struct __mavlink_sys_status_t 
{ 
  uint16_t load;  ///< Maximum usage in percent of the mainloop time, (0%%: 0, 100%%: 1000) should be always below 1000
  uint16_t vbat;  ///< Battery voltage, in millivolts (1 = 1 millivolt)
  uint16_t battery_remaining;  ///< Remaining battery energy: (0%%: 0, 100%%: 1000)
  uint16_t packet_drop;  ///< Dropped packets (packets that were corrupted on reception on the MAV)
  uint8_t mode;  ///< System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
  uint8_t nav_mode;  ///< Navigation mode, see MAV_NAV_MODE ENUM
  uint8_t status;  ///< System status flag, see MAV_STATUS ENUM
} mavlink_sys_status_t;

#define MAVLINK_MSG_ID_SYS_STATUS_LEN 11
#define MAVLINK_MSG_ID_34_LEN 11

#define MAVLINK_MESSAGE_INFO_SYS_STATUS \
{ \
  "SYS_STATUS", \
  7, \
  { \
    { "load", NULL, MAVLINK_TYPE_UINT16_T, 0, 0, offsetof(mavlink_sys_status_t, load) }, \
    { "vbat", NULL, MAVLINK_TYPE_UINT16_T, 0, 2, offsetof(mavlink_sys_status_t, vbat) }, \
    { "battery_remaining", NULL, MAVLINK_TYPE_UINT16_T, 0, 4, offsetof(mavlink_sys_status_t, battery_remaining) }, \
    { "packet_drop", NULL, MAVLINK_TYPE_UINT16_T, 0, 6, offsetof(mavlink_sys_status_t, packet_drop) }, \
    { "mode", NULL, MAVLINK_TYPE_UINT8_T, 0, 8, offsetof(mavlink_sys_status_t, mode) }, \
    { "nav_mode", NULL, MAVLINK_TYPE_UINT8_T, 0, 9, offsetof(mavlink_sys_status_t, nav_mode) }, \
    { "status", NULL, MAVLINK_TYPE_UINT8_T, 0, 10, offsetof(mavlink_sys_status_t, status) }, \
  } \
}

/**
 * @brief Pack a sys_status message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param mode System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
 * @param nav_mode Navigation mode, see MAV_NAV_MODE ENUM
 * @param status System status flag, see MAV_STATUS ENUM
 * @param load Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
 * @param vbat Battery voltage, in millivolts (1 = 1 millivolt)
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 1000)
 * @param packet_drop Dropped packets (packets that were corrupted on reception on the MAV)
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_sys_status_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t mode
	,uint8_t nav_mode
	,uint8_t status
	,uint16_t load
	,uint16_t vbat
	,uint16_t battery_remaining
	,uint16_t packet_drop
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SYS_STATUS_LEN];
	_mav_put_uint16_t(buf, 0, load);
	_mav_put_uint16_t(buf, 2, vbat);
	_mav_put_uint16_t(buf, 4, battery_remaining);
	_mav_put_uint16_t(buf, 6, packet_drop);
	_mav_put_uint8_t(buf, 8, mode);
	_mav_put_uint8_t(buf, 9, nav_mode);
	_mav_put_uint8_t(buf, 10, status);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#else
	mavlink_sys_status_t packet;
	packet.load = load;
	packet.vbat = vbat;
	packet.battery_remaining = battery_remaining;
	packet.packet_drop = packet_drop;
	packet.mode = mode;
	packet.nav_mode = nav_mode;
	packet.status = status;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SYS_STATUS;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_SYS_STATUS_LEN);
}

/**
 * @brief Pack a sys_status message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param mode System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
 * @param nav_mode Navigation mode, see MAV_NAV_MODE ENUM
 * @param status System status flag, see MAV_STATUS ENUM
 * @param load Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
 * @param vbat Battery voltage, in millivolts (1 = 1 millivolt)
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 1000)
 * @param packet_drop Dropped packets (packets that were corrupted on reception on the MAV)
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_sys_status_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t mode
	,uint8_t nav_mode
	,uint8_t status
	,uint16_t load
	,uint16_t vbat
	,uint16_t battery_remaining
	,uint16_t packet_drop
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SYS_STATUS_LEN];
	_mav_put_uint16_t(buf, 0, load);
	_mav_put_uint16_t(buf, 2, vbat);
	_mav_put_uint16_t(buf, 4, battery_remaining);
	_mav_put_uint16_t(buf, 6, packet_drop);
	_mav_put_uint8_t(buf, 8, mode);
	_mav_put_uint8_t(buf, 9, nav_mode);
	_mav_put_uint8_t(buf, 10, status);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#else
	mavlink_sys_status_t packet;
	packet.mode = mode;
	packet.nav_mode = nav_mode;
	packet.status = status;
	packet.load = load;
	packet.vbat = vbat;
	packet.battery_remaining = battery_remaining;
	packet.packet_drop = packet_drop;

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_SYS_STATUS;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_SYS_STATUS_LEN);
}

/**
 * @brief Encode a sys_status struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param sys_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_sys_status_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_sys_status_t* sys_status
	)
{
	return mavlink_msg_sys_status_pack(
	 system_id
	,component_id
	,msg
	,sys_status->mode
	,sys_status->nav_mode
	,sys_status->status
	,sys_status->load
	,sys_status->vbat
	,sys_status->battery_remaining
	,sys_status->packet_drop
	);
}

/**
 * @brief Send a sys_status message
 * @param chan The MAVLink channel to send this message
 *
 * @param mode System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
 * @param nav_mode Navigation mode, see MAV_NAV_MODE ENUM
 * @param status System status flag, see MAV_STATUS ENUM
 * @param load Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
 * @param vbat Battery voltage, in millivolts (1 = 1 millivolt)
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 1000)
 * @param packet_drop Dropped packets (packets that were corrupted on reception on the MAV)
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_sys_status_send(
	 mavlink_channel_t chan
	,uint8_t mode
	,uint8_t nav_mode
	,uint8_t status
	,uint16_t load
	,uint16_t vbat
	,uint16_t battery_remaining
	,uint16_t packet_drop
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SYS_STATUS_LEN];
	_mav_put_uint16_t(buf, 0, load);
	_mav_put_uint16_t(buf, 2, vbat);
	_mav_put_uint16_t(buf, 4, battery_remaining);
	_mav_put_uint16_t(buf, 6, packet_drop);
	_mav_put_uint8_t(buf, 8, mode);
	_mav_put_uint8_t(buf, 9, nav_mode);
	_mav_put_uint8_t(buf, 10, status);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SYS_STATUS, buf, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#else
	mavlink_sys_status_t packet;
	packet.mode = mode;
	packet.nav_mode = nav_mode;
	packet.status = status;
	packet.load = load;
	packet.vbat = vbat;
	packet.battery_remaining = battery_remaining;
	packet.packet_drop = packet_drop;

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_SYS_STATUS, (const char*)&packet, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#endif
}

static inline void mavlink_msg_wID_sys_status_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t mode
	,uint8_t nav_mode
	,uint8_t status
	,uint16_t load
	,uint16_t vbat
	,uint16_t battery_remaining
	,uint16_t packet_drop
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_SYS_STATUS_LEN];
	_mav_put_uint16_t(buf, 0, load);
	_mav_put_uint16_t(buf, 2, vbat);
	_mav_put_uint16_t(buf, 4, battery_remaining);
	_mav_put_uint16_t(buf, 6, packet_drop);
	_mav_put_uint8_t(buf, 8, mode);
	_mav_put_uint8_t(buf, 9, nav_mode);
	_mav_put_uint8_t(buf, 10, status);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SYS_STATUS, buf, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#else
	mavlink_sys_status_t packet;
	packet.mode = mode;
	packet.nav_mode = nav_mode;
	packet.status = status;
	packet.load = load;
	packet.vbat = vbat;
	packet.battery_remaining = battery_remaining;
	packet.packet_drop = packet_drop;

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_SYS_STATUS, (const char*)&packet, MAVLINK_MSG_ID_SYS_STATUS_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE SYS_STATUS UNPACKING

/**
 * @brief Get field mode from sys_status message
 *
 * @return System mode, see MAV_MODE ENUM in mavlink/include/mavlink_types.h
 */
static inline uint8_t mavlink_msg_sys_status_get_mode(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field nav_mode from sys_status message
 *
 * @return Navigation mode, see MAV_NAV_MODE ENUM
 */
static inline uint8_t mavlink_msg_sys_status_get_nav_mode(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,1);
}

/**
 * @brief Get field status from sys_status message
 *
 * @return System status flag, see MAV_STATUS ENUM
 */
static inline uint8_t mavlink_msg_sys_status_get_status(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,2);
}

/**
 * @brief Get field load from sys_status message
 *
 * @return Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000
 */
static inline uint16_t mavlink_msg_sys_status_get_load(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,3);
}

/**
 * @brief Get field vbat from sys_status message
 *
 * @return Battery voltage, in millivolts (1 = 1 millivolt)
 */
static inline uint16_t mavlink_msg_sys_status_get_vbat(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,5);
}

/**
 * @brief Get field battery_remaining from sys_status message
 *
 * @return Remaining battery energy: (0%: 0, 100%: 1000)
 */
static inline uint16_t mavlink_msg_sys_status_get_battery_remaining(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,7);
}

/**
 * @brief Get field packet_drop from sys_status message
 *
 * @return Dropped packets (packets that were corrupted on reception on the MAV)
 */
static inline uint16_t mavlink_msg_sys_status_get_packet_drop(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,9);
}

/**
 * @brief Decode a sys_status message into a struct
 *
 * @param msg The message to decode
 * @param sys_status C-struct to decode the message contents into
 */
static inline void mavlink_msg_sys_status_decode(const mavlink_message_t* msg, mavlink_sys_status_t* sys_status)
{
#if MAVLINK_NEED_BYTE_SWAP
	sys_status->mode = mavlink_msg_sys_status_get_mode(msg);
	sys_status->nav_mode = mavlink_msg_sys_status_get_nav_mode(msg);
	sys_status->status = mavlink_msg_sys_status_get_status(msg);
	sys_status->load = mavlink_msg_sys_status_get_load(msg);
	sys_status->vbat = mavlink_msg_sys_status_get_vbat(msg);
	sys_status->battery_remaining = mavlink_msg_sys_status_get_battery_remaining(msg);
	sys_status->packet_drop = mavlink_msg_sys_status_get_packet_drop(msg);
#else
	memcpy(sys_status, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_SYS_STATUS_LEN);
#endif
}
