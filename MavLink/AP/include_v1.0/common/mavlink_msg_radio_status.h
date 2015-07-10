// MESSAGE RADIO_STATUS PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_RADIO_STATUS 109 

typedef struct __mavlink_radio_status_t 
{ 
  uint8_t rssi;  ///< local signal strength
  uint8_t remrssi;  ///< remote signal strength
  uint8_t txbuf;  ///< how full the tx buffer is as a percentage
  uint8_t noise;  ///< background noise level
  uint8_t remnoise;  ///< remote background noise level
  uint16_t rxerrors;  ///< receive errors
  uint16_t fixed;  ///< count of error corrected packets
} mavlink_radio_status_t;

#define MAVLINK_MSG_ID_RADIO_STATUS_LEN 9
#define MAVLINK_MSG_ID_109_LEN 9

#define MAVLINK_MSG_ID_RADIO_STATUS_CRC 0
#define MAVLINK_MSG_ID_109_CRC 0

#define MAVLINK_MESSAGE_INFO_RADIO_STATUS \
{ \
  "RADIO_STATUS", \
  7, \
  { \
    { "rssi", NULL, MAVLINK_TYPE_UINT8_T, 0, 0, offsetof(mavlink_radio_status_t, rssi) }, \
    { "remrssi", NULL, MAVLINK_TYPE_UINT8_T, 0, 1, offsetof(mavlink_radio_status_t, remrssi) }, \
    { "txbuf", NULL, MAVLINK_TYPE_UINT8_T, 0, 2, offsetof(mavlink_radio_status_t, txbuf) }, \
    { "noise", NULL, MAVLINK_TYPE_UINT8_T, 0, 3, offsetof(mavlink_radio_status_t, noise) }, \
    { "remnoise", NULL, MAVLINK_TYPE_UINT8_T, 0, 4, offsetof(mavlink_radio_status_t, remnoise) }, \
    { "rxerrors", NULL, MAVLINK_TYPE_UINT16_T, 0, 5, offsetof(mavlink_radio_status_t, rxerrors) }, \
    { "fixed", NULL, MAVLINK_TYPE_UINT16_T, 0, 7, offsetof(mavlink_radio_status_t, fixed) }, \
  } \
}

/**
 * @brief Pack a radio_status message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param rssi local signal strength
 * @param remrssi remote signal strength
 * @param txbuf how full the tx buffer is as a percentage
 * @param noise background noise level
 * @param remnoise remote background noise level
 * @param rxerrors receive errors
 * @param fixed count of error corrected packets
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_radio_status_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t rssi
	,uint8_t remrssi
	,uint8_t txbuf
	,uint8_t noise
	,uint8_t remnoise
	,uint16_t rxerrors
	,uint16_t fixed
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_RADIO_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, rssi);
	_mav_put_uint8_t(buf, 1, remrssi);
	_mav_put_uint8_t(buf, 2, txbuf);
	_mav_put_uint8_t(buf, 3, noise);
	_mav_put_uint8_t(buf, 4, remnoise);
	_mav_put_uint16_t(buf, 5, rxerrors);
	_mav_put_uint16_t(buf, 7, fixed);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#else
	mavlink_radio_status_t packet;
	packet.rssi = rssi;
	packet.remrssi = remrssi;
	packet.txbuf = txbuf;
	packet.noise = noise;
	packet.remnoise = remnoise;
	packet.rxerrors = rxerrors;
	packet.fixed = fixed;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_RADIO_STATUS;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
}

/**
 * @brief Pack a radio_status message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param rssi local signal strength
 * @param remrssi remote signal strength
 * @param txbuf how full the tx buffer is as a percentage
 * @param noise background noise level
 * @param remnoise remote background noise level
 * @param rxerrors receive errors
 * @param fixed count of error corrected packets
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_radio_status_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t rssi
	,uint8_t remrssi
	,uint8_t txbuf
	,uint8_t noise
	,uint8_t remnoise
	,uint16_t rxerrors
	,uint16_t fixed
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_RADIO_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, rssi);
	_mav_put_uint8_t(buf, 1, remrssi);
	_mav_put_uint8_t(buf, 2, txbuf);
	_mav_put_uint8_t(buf, 3, noise);
	_mav_put_uint8_t(buf, 4, remnoise);
	_mav_put_uint16_t(buf, 5, rxerrors);
	_mav_put_uint16_t(buf, 7, fixed);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#else
	mavlink_radio_status_t packet;
	packet.rssi = rssi;
	packet.remrssi = remrssi;
	packet.txbuf = txbuf;
	packet.noise = noise;
	packet.remnoise = remnoise;
	packet.rxerrors = rxerrors;
	packet.fixed = fixed;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_RADIO_STATUS;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
}

/**
 * @brief Encode a radio_status struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param radio_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_radio_status_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_radio_status_t* radio_status
	)
{
	return mavlink_msg_radio_status_pack(
	 system_id
	,component_id
	,msg
	,radio_status->rssi
	,radio_status->remrssi
	,radio_status->txbuf
	,radio_status->noise
	,radio_status->remnoise
	,radio_status->rxerrors
	,radio_status->fixed
	);
}

/**
 * @brief Encode a radio_status struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param radio_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_radio_status_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_radio_status_t* radio_status
	)
{
	return mavlink_msg_radio_status_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,radio_status->rssi
	,radio_status->remrssi
	,radio_status->txbuf
	,radio_status->noise
	,radio_status->remnoise
	,radio_status->rxerrors
	,radio_status->fixed
	);
}

/**
 * @brief Send a radio_status message
 * @param chan The MAVLink channel to send this message
 *
 * @param rssi local signal strength
 * @param remrssi remote signal strength
 * @param txbuf how full the tx buffer is as a percentage
 * @param noise background noise level
 * @param remnoise remote background noise level
 * @param rxerrors receive errors
 * @param fixed count of error corrected packets
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_radio_status_send(
	 mavlink_channel_t chan
	,uint8_t rssi
	,uint8_t remrssi
	,uint8_t txbuf
	,uint8_t noise
	,uint8_t remnoise
	,uint16_t rxerrors
	,uint16_t fixed
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_RADIO_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, rssi);
	_mav_put_uint8_t(buf, 1, remrssi);
	_mav_put_uint8_t(buf, 2, txbuf);
	_mav_put_uint8_t(buf, 3, noise);
	_mav_put_uint8_t(buf, 4, remnoise);
	_mav_put_uint16_t(buf, 5, rxerrors);
	_mav_put_uint16_t(buf, 7, fixed);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_RADIO_STATUS, buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_RADIO_STATUS, buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
#else
	mavlink_radio_status_t packet;
	packet.rssi = rssi;
	packet.remrssi = remrssi;
	packet.txbuf = txbuf;
	packet.noise = noise;
	packet.remnoise = remnoise;
	packet.rxerrors = rxerrors;
	packet.fixed = fixed;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_RADIO_STATUS, (const char*)&packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_RADIO_STATUS, (const char*)&packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_radio_status_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t rssi
	,uint8_t remrssi
	,uint8_t txbuf
	,uint8_t noise
	,uint8_t remnoise
	,uint16_t rxerrors
	,uint16_t fixed
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_RADIO_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, rssi);
	_mav_put_uint8_t(buf, 1, remrssi);
	_mav_put_uint8_t(buf, 2, txbuf);
	_mav_put_uint8_t(buf, 3, noise);
	_mav_put_uint8_t(buf, 4, remnoise);
	_mav_put_uint16_t(buf, 5, rxerrors);
	_mav_put_uint16_t(buf, 7, fixed);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_RADIO_STATUS, buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_RADIO_STATUS, buf, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
#else
	mavlink_radio_status_t packet;
	packet.rssi = rssi;
	packet.remrssi = remrssi;
	packet.txbuf = txbuf;
	packet.noise = noise;
	packet.remnoise = remnoise;
	packet.rxerrors = rxerrors;
	packet.fixed = fixed;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_RADIO_STATUS, (const char*)&packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN, MAVLINK_MSG_ID_RADIO_STATUS_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_RADIO_STATUS, (const char*)&packet, MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE RADIO_STATUS UNPACKING

/**
 * @brief Get field rssi from radio_status message
 *
 * @return local signal strength
 */
static inline uint8_t mavlink_msg_radio_status_get_rssi(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field remrssi from radio_status message
 *
 * @return remote signal strength
 */
static inline uint8_t mavlink_msg_radio_status_get_remrssi(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,1);
}

/**
 * @brief Get field txbuf from radio_status message
 *
 * @return how full the tx buffer is as a percentage
 */
static inline uint8_t mavlink_msg_radio_status_get_txbuf(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,2);
}

/**
 * @brief Get field noise from radio_status message
 *
 * @return background noise level
 */
static inline uint8_t mavlink_msg_radio_status_get_noise(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,3);
}

/**
 * @brief Get field remnoise from radio_status message
 *
 * @return remote background noise level
 */
static inline uint8_t mavlink_msg_radio_status_get_remnoise(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,4);
}

/**
 * @brief Get field rxerrors from radio_status message
 *
 * @return receive errors
 */
static inline uint16_t mavlink_msg_radio_status_get_rxerrors(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,5);
}

/**
 * @brief Get field fixed from radio_status message
 *
 * @return count of error corrected packets
 */
static inline uint16_t mavlink_msg_radio_status_get_fixed(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint16_t(msg,7);
}

/**
 * @brief Decode a radio_status message into a struct
 *
 * @param msg The message to decode
 * @param radio_status C-struct to decode the message contents into
 */
static inline void mavlink_msg_radio_status_decode(const mavlink_message_t* msg, mavlink_radio_status_t* radio_status)
{
#if MAVLINK_NEED_BYTE_SWAP
	radio_status->rssi = mavlink_msg_radio_status_get_rssi(msg);
	radio_status->remrssi = mavlink_msg_radio_status_get_remrssi(msg);
	radio_status->txbuf = mavlink_msg_radio_status_get_txbuf(msg);
	radio_status->noise = mavlink_msg_radio_status_get_noise(msg);
	radio_status->remnoise = mavlink_msg_radio_status_get_remnoise(msg);
	radio_status->rxerrors = mavlink_msg_radio_status_get_rxerrors(msg);
	radio_status->fixed = mavlink_msg_radio_status_get_fixed(msg);
#else
	memcpy(radio_status, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_RADIO_STATUS_LEN);
#endif
}
