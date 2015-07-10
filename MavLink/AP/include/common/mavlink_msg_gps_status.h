// MESSAGE GPS_STATUS PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_GPS_STATUS 27 

typedef struct __mavlink_gps_status_t 
{ 
  uint8_t satellite_prn;  ///< Global satellite ID
  uint8_t satellite_used[20];  ///< 0: Satellite not used, 1: used for localization
  uint8_t satellite_elevation[20];  ///< Elevation (0: right on top of receiver, 90: on the horizon) of satellite
  uint8_t satellite_azimuth[20];  ///< Direction of satellite, 0: 0 deg, 255: 360 deg.
  uint8_t satellite_snr[20];  ///< Signal to noise ratio of satellite
  uint8_t satellites_visible[0];  ///< Number of satellites visible
} mavlink_gps_status_t;

#define MAVLINK_MSG_ID_GPS_STATUS_LEN 101
#define MAVLINK_MSG_ID_27_LEN 101

#define MAVLINK_MESSAGE_INFO_GPS_STATUS \
{ \
  "GPS_STATUS", \
  6, \
  { \
    { "satellite_prn", NULL, MAVLINK_TYPE_UINT8_T, 20, 0, offsetof(mavlink_gps_status_t, satellite_prn) }, \
    { "satellite_used", NULL, MAVLINK_TYPE_UINT8_T, 20, 20, offsetof(mavlink_gps_status_t, satellite_used) }, \
    { "satellite_elevation", NULL, MAVLINK_TYPE_UINT8_T, 20, 40, offsetof(mavlink_gps_status_t, satellite_elevation) }, \
    { "satellite_azimuth", NULL, MAVLINK_TYPE_UINT8_T, 20, 60, offsetof(mavlink_gps_status_t, satellite_azimuth) }, \
    { "satellite_snr", NULL, MAVLINK_TYPE_UINT8_T, 20, 80, offsetof(mavlink_gps_status_t, satellite_snr) }, \
    { "satellites_visible", NULL, MAVLINK_TYPE_UINT8_T, 0, 100, offsetof(mavlink_gps_status_t, satellites_visible) }, \
  } \
}

/**
 * @brief Pack a gps_status message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param satellites_visible Number of satellites visible
 * @param satellite_prn Global satellite ID
 * @param satellite_used 0: Satellite not used, 1: used for localization
 * @param satellite_elevation Elevation (0: right on top of receiver, 90: on the horizon) of satellite
 * @param satellite_azimuth Direction of satellite, 0: 0 deg, 255: 360 deg.
 * @param satellite_snr Signal to noise ratio of satellite
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_gps_status_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t satellites_visible
	,const uint8_t* satellite_prn
	,const uint8_t* satellite_used
	,const uint8_t* satellite_elevation
	,const uint8_t* satellite_azimuth
	,const uint8_t* satellite_snr
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_GPS_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, satellite_prn);
	_mav_put_uint8_t_array(buf, 20, satellite_used, 20);
	_mav_put_uint8_t_array(buf, 40, satellite_elevation, 20);
	_mav_put_uint8_t_array(buf, 60, satellite_azimuth, 20);
	_mav_put_uint8_t_array(buf, 80, satellite_snr, 20);
	_mav_put_uint8_t_array(buf, 100, satellites_visible, 0);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#else
	mavlink_gps_status_t packet;
	packet.satellite_prn = satellite_prn;
	mav_array_memcpy(packet.satellite_used, satellite_used, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_elevation, satellite_elevation, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_azimuth, satellite_azimuth, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_snr, satellite_snr, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellites_visible, satellites_visible, sizeof(uint8_t)*0);

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_GPS_STATUS;
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_GPS_STATUS_LEN);
}

/**
 * @brief Pack a gps_status message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param satellites_visible Number of satellites visible
 * @param satellite_prn Global satellite ID
 * @param satellite_used 0: Satellite not used, 1: used for localization
 * @param satellite_elevation Elevation (0: right on top of receiver, 90: on the horizon) of satellite
 * @param satellite_azimuth Direction of satellite, 0: 0 deg, 255: 360 deg.
 * @param satellite_snr Signal to noise ratio of satellite
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_gps_status_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t satellites_visible
	,const uint8_t* satellite_prn
	,const uint8_t* satellite_used
	,const uint8_t* satellite_elevation
	,const uint8_t* satellite_azimuth
	,const uint8_t* satellite_snr
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_GPS_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, satellite_prn);
	_mav_put_uint8_t_array(buf, 20, satellite_used, 20);
	_mav_put_uint8_t_array(buf, 40, satellite_elevation, 20);
	_mav_put_uint8_t_array(buf, 60, satellite_azimuth, 20);
	_mav_put_uint8_t_array(buf, 80, satellite_snr, 20);
	_mav_put_uint8_t_array(buf, 100, satellites_visible, 0);

	memcpy(_MAV_PAYLOAD(msg), buf, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#else
	mavlink_gps_status_t packet;
	packet.satellites_visible = satellites_visible;
	mav_array_memcpy(packet.satellite_prn, satellite_prn, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_used, satellite_used, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_elevation, satellite_elevation, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_azimuth, satellite_azimuth, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_snr, satellite_snr, sizeof(uint8_t)*20);

	memcpy(_MAV_PAYLOAD(msg), &packet, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_GPS_STATUS;
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_GPS_STATUS_LEN);
}

/**
 * @brief Encode a gps_status struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param gps_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_gps_status_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_gps_status_t* gps_status
	)
{
	return mavlink_msg_gps_status_pack(
	 system_id
	,component_id
	,msg
	,gps_status->satellites_visible
	,gps_status->satellite_prn
	,gps_status->satellite_used
	,gps_status->satellite_elevation
	,gps_status->satellite_azimuth
	,gps_status->satellite_snr
	);
}

/**
 * @brief Send a gps_status message
 * @param chan The MAVLink channel to send this message
 *
 * @param satellites_visible Number of satellites visible
 * @param satellite_prn Global satellite ID
 * @param satellite_used 0: Satellite not used, 1: used for localization
 * @param satellite_elevation Elevation (0: right on top of receiver, 90: on the horizon) of satellite
 * @param satellite_azimuth Direction of satellite, 0: 0 deg, 255: 360 deg.
 * @param satellite_snr Signal to noise ratio of satellite
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_gps_status_send(
	 mavlink_channel_t chan
	,uint8_t satellites_visible
	,const uint8_t* satellite_prn
	,const uint8_t* satellite_used
	,const uint8_t* satellite_elevation
	,const uint8_t* satellite_azimuth
	,const uint8_t* satellite_snr
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_GPS_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, satellite_prn);
	_mav_put_uint8_t_array(buf, 20, satellite_used, 20);
	_mav_put_uint8_t_array(buf, 40, satellite_elevation, 20);
	_mav_put_uint8_t_array(buf, 60, satellite_azimuth, 20);
	_mav_put_uint8_t_array(buf, 80, satellite_snr, 20);
	_mav_put_uint8_t_array(buf, 100, satellites_visible, 0);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_GPS_STATUS, buf, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#else
	mavlink_gps_status_t packet;
	packet.satellites_visible = satellites_visible;
	mav_array_memcpy(packet.satellite_prn, satellite_prn, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_used, satellite_used, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_elevation, satellite_elevation, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_azimuth, satellite_azimuth, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_snr, satellite_snr, sizeof(uint8_t)*20);

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_GPS_STATUS, (const char*)&packet, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#endif
}

static inline void mavlink_msg_wID_gps_status_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t satellites_visible
	,const uint8_t* satellite_prn
	,const uint8_t* satellite_used
	,const uint8_t* satellite_elevation
	,const uint8_t* satellite_azimuth
	,const uint8_t* satellite_snr
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_GPS_STATUS_LEN];
	_mav_put_uint8_t(buf, 0, satellite_prn);
	_mav_put_uint8_t_array(buf, 20, satellite_used, 20);
	_mav_put_uint8_t_array(buf, 40, satellite_elevation, 20);
	_mav_put_uint8_t_array(buf, 60, satellite_azimuth, 20);
	_mav_put_uint8_t_array(buf, 80, satellite_snr, 20);
	_mav_put_uint8_t_array(buf, 100, satellites_visible, 0);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_GPS_STATUS, buf, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#else
	mavlink_gps_status_t packet;
	packet.satellites_visible = satellites_visible;
	mav_array_memcpy(packet.satellite_prn, satellite_prn, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_used, satellite_used, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_elevation, satellite_elevation, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_azimuth, satellite_azimuth, sizeof(uint8_t)*20);
	mav_array_memcpy(packet.satellite_snr, satellite_snr, sizeof(uint8_t)*20);

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_GPS_STATUS, (const char*)&packet, MAVLINK_MSG_ID_GPS_STATUS_LEN);
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE GPS_STATUS UNPACKING

/**
 * @brief Get field satellites_visible from gps_status message
 *
 * @return Number of satellites visible
 */
static inline uint8_t mavlink_msg_gps_status_get_satellites_visible(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field satellite_prn from gps_status message
 *
 * @return Global satellite ID
 */
static inline uint8_t mavlink_msg_gps_status_get_satellite_prn(const mavlink_message_t* msg, uint8_t* satellite_prn)
{
	return _MAV_RETURN_uint8_t_array(msg,satellite_prn,20,1);
}

/**
 * @brief Get field satellite_used from gps_status message
 *
 * @return 0: Satellite not used, 1: used for localization
 */
static inline uint8_t mavlink_msg_gps_status_get_satellite_used(const mavlink_message_t* msg, uint8_t* satellite_used)
{
	return _MAV_RETURN_uint8_t_array(msg,satellite_used,20,21);
}

/**
 * @brief Get field satellite_elevation from gps_status message
 *
 * @return Elevation (0: right on top of receiver, 90: on the horizon) of satellite
 */
static inline uint8_t mavlink_msg_gps_status_get_satellite_elevation(const mavlink_message_t* msg, uint8_t* satellite_elevation)
{
	return _MAV_RETURN_uint8_t_array(msg,satellite_elevation,20,41);
}

/**
 * @brief Get field satellite_azimuth from gps_status message
 *
 * @return Direction of satellite, 0: 0 deg, 255: 360 deg.
 */
static inline uint8_t mavlink_msg_gps_status_get_satellite_azimuth(const mavlink_message_t* msg, uint8_t* satellite_azimuth)
{
	return _MAV_RETURN_uint8_t_array(msg,satellite_azimuth,20,61);
}

/**
 * @brief Get field satellite_snr from gps_status message
 *
 * @return Signal to noise ratio of satellite
 */
static inline uint8_t mavlink_msg_gps_status_get_satellite_snr(const mavlink_message_t* msg, uint8_t* satellite_snr)
{
	return _MAV_RETURN_uint8_t_array(msg,satellite_snr,20,81);
}

/**
 * @brief Decode a gps_status message into a struct
 *
 * @param msg The message to decode
 * @param gps_status C-struct to decode the message contents into
 */
static inline void mavlink_msg_gps_status_decode(const mavlink_message_t* msg, mavlink_gps_status_t* gps_status)
{
#if MAVLINK_NEED_BYTE_SWAP
	gps_status->satellites_visible = mavlink_msg_gps_status_get_satellites_visible(msg);
	mavlink_msg_gps_status_get_satellite_prn(msg, gps_status->satellite_prn);
	mavlink_msg_gps_status_get_satellite_used(msg, gps_status->satellite_used);
	mavlink_msg_gps_status_get_satellite_elevation(msg, gps_status->satellite_elevation);
	mavlink_msg_gps_status_get_satellite_azimuth(msg, gps_status->satellite_azimuth);
	mavlink_msg_gps_status_get_satellite_snr(msg, gps_status->satellite_snr);
#else
	memcpy(gps_status, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_GPS_STATUS_LEN);
#endif
}
