// MESSAGE BATTERY_STATUS PACKING
// Generated from parse_APM_XML.m on 24-Feb-2014 13:50:53

#define MAVLINK_MSG_ID_BATTERY_STATUS 147 

typedef struct __mavlink_battery_status_t 
{ 
  int32_t current_consumed;  ///< Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
  int32_t energy_consumed;  ///< Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
  int16_t temperature;  ///< Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
  uint16_t voltages;  ///< Battery voltage of cells, in millivolts (1 = 1 millivolt)
  int16_t current_battery[0];  ///< Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
  uint8_t id;  ///< Battery ID
  uint8_t battery_function;  ///< Function of the battery
  uint8_t type;  ///< Type (chemistry) of the battery
  int8_t battery_remaining;  ///< Remaining battery energy: (0%%: 0, 100%%: 100), -1: autopilot does not estimate the remaining battery
} mavlink_battery_status_t;

#define MAVLINK_MSG_ID_BATTERY_STATUS_LEN 36
#define MAVLINK_MSG_ID_147_LEN 36

#define MAVLINK_MSG_ID_BATTERY_STATUS_CRC 0
#define MAVLINK_MSG_ID_147_CRC 0

#define MAVLINK_MESSAGE_INFO_BATTERY_STATUS \
{ \
  "BATTERY_STATUS", \
  9, \
  { \
    { "current_consumed", NULL, MAVLINK_TYPE_INT32_T, 0, 0, offsetof(mavlink_battery_status_t, current_consumed) }, \
    { "energy_consumed", NULL, MAVLINK_TYPE_INT32_T, 0, 4, offsetof(mavlink_battery_status_t, energy_consumed) }, \
    { "temperature", NULL, MAVLINK_TYPE_INT16_T, 0, 8, offsetof(mavlink_battery_status_t, temperature) }, \
    { "voltages", NULL, MAVLINK_TYPE_UINT16_T, 10, 10, offsetof(mavlink_battery_status_t, voltages) }, \
    { "current_battery", NULL, MAVLINK_TYPE_INT16_T, 0, 12, offsetof(mavlink_battery_status_t, current_battery) }, \
    { "id", NULL, MAVLINK_TYPE_UINT8_T, 0, 14, offsetof(mavlink_battery_status_t, id) }, \
    { "battery_function", NULL, MAVLINK_TYPE_UINT8_T, 0, 15, offsetof(mavlink_battery_status_t, battery_function) }, \
    { "type", NULL, MAVLINK_TYPE_UINT8_T, 0, 16, offsetof(mavlink_battery_status_t, type) }, \
    { "battery_remaining", NULL, MAVLINK_TYPE_INT8_T, 0, 17, offsetof(mavlink_battery_status_t, battery_remaining) }, \
  } \
}

/**
 * @brief Pack a battery_status message
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 *
 * @param id Battery ID
 * @param battery_function Function of the battery
 * @param type Type (chemistry) of the battery
 * @param temperature Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
 * @param voltages Battery voltage of cells, in millivolts (1 = 1 millivolt)
 * @param current_battery Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
 * @param current_consumed Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
 * @param energy_consumed Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_battery_status_pack(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,uint8_t id
	,uint8_t battery_function
	,uint8_t type
	,int16_t temperature
	,const uint16_t* voltages
	,int16_t current_battery
	,int32_t current_consumed
	,int32_t energy_consumed
	,int8_t battery_remaining
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BATTERY_STATUS_LEN];
	_mav_put_int32_t(buf, 0, current_consumed);
	_mav_put_int32_t(buf, 4, energy_consumed);
	_mav_put_int16_t(buf, 8, temperature);
	_mav_put_uint16_t(buf, 10, voltages);
	_mav_put_int16_t_array(buf, 12, current_battery, 0);
	_mav_put_uint8_t(buf, 14, id);
	_mav_put_uint8_t(buf, 15, battery_function);
	_mav_put_uint8_t(buf, 16, type);
	_mav_put_int8_t(buf, 17, battery_remaining);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#else
	mavlink_battery_status_t packet;
	packet.current_consumed = current_consumed;
	packet.energy_consumed = energy_consumed;
	packet.temperature = temperature;
	packet.voltages = voltages;
	mav_array_memcpy(packet.current_battery, current_battery, sizeof(int16_t)*0);
	packet.id = id;
	packet.battery_function = battery_function;
	packet.type = type;
	packet.battery_remaining = battery_remaining;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_BATTERY_STATUS;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else
	return mavlink_finalize_message(msg, system_id, component_id, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
}

/**
 * @brief Pack a battery_status message on a channel
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message was sent over
 * @param msg The MAVLink message to compress the data into
 *
 * @param id Battery ID
 * @param battery_function Function of the battery
 * @param type Type (chemistry) of the battery
 * @param temperature Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
 * @param voltages Battery voltage of cells, in millivolts (1 = 1 millivolt)
 * @param current_battery Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
 * @param current_consumed Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
 * @param energy_consumed Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
 * @return length of the message in bytes (excluding serial stream start sign)
 */
static inline uint16_t mavlink_msg_battery_status_pack_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,uint8_t id
	,uint8_t battery_function
	,uint8_t type
	,int16_t temperature
	,const uint16_t* voltages
	,int16_t current_battery
	,int32_t current_consumed
	,int32_t energy_consumed
	,int8_t battery_remaining
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BATTERY_STATUS_LEN];
	_mav_put_int32_t(buf, 0, current_consumed);
	_mav_put_int32_t(buf, 4, energy_consumed);
	_mav_put_int16_t(buf, 8, temperature);
	_mav_put_uint16_t(buf, 10, voltages);
	_mav_put_int16_t_array(buf, 12, current_battery, 0);
	_mav_put_uint8_t(buf, 14, id);
	_mav_put_uint8_t(buf, 15, battery_function);
	_mav_put_uint8_t(buf, 16, type);
	_mav_put_int8_t(buf, 17, battery_remaining);

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#else
	mavlink_battery_status_t packet;
	packet.id = id;
	packet.battery_function = battery_function;
	packet.type = type;
	packet.temperature = temperature;
	mav_array_memcpy(packet.voltages, voltages, sizeof(uint16_t)*10);
	packet.current_battery = current_battery;
	packet.current_consumed = current_consumed;
	packet.energy_consumed = energy_consumed;
	packet.battery_remaining = battery_remaining;

	memcpy(_MAV_PAYLOAD_NON_CONST(msg), &packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif

	msg->msgid = MAVLINK_MSG_ID_BATTERY_STATUS;
#if MAVLINK_CRC_EXTRA
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else
	return mavlink_finalize_message_chan(msg, system_id, component_id, chan, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
}

/**
 * @brief Encode a battery_status struct into a message
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param msg The MAVLink message to compress the data into
 * @param battery_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_battery_status_encode(
	 uint8_t system_id
	,uint8_t component_id
	,mavlink_message_t* msg
	,const mavlink_battery_status_t* battery_status
	)
{
	return mavlink_msg_battery_status_pack(
	 system_id
	,component_id
	,msg
	,battery_status->id
	,battery_status->battery_function
	,battery_status->type
	,battery_status->temperature
	,battery_status->voltages
	,battery_status->current_battery
	,battery_status->current_consumed
	,battery_status->energy_consumed
	,battery_status->battery_remaining
	);
}

/**
 * @brief Encode a battery_status struct on a channel
 *
 * @param system_id ID of this system
 * @param component_id ID of this component (e.g. 200 for IMU)
 * @param chan The MAVLink channel this message will be sent over
 * @param msg The MAVLink message to compress the data into
 * @param battery_status C-struct to read the message contents from
 */
static inline uint16_t mavlink_msg_battery_status_encode_chan(
	 uint8_t system_id
	,uint8_t component_id
	,uint8_t chan
	,mavlink_message_t* msg
	,const mavlink_battery_status_t* battery_status
	)
{
	return mavlink_msg_battery_status_pack_chan(
	 system_id
	,component_id
	,chan
	,msg
	,battery_status->id
	,battery_status->battery_function
	,battery_status->type
	,battery_status->temperature
	,battery_status->voltages
	,battery_status->current_battery
	,battery_status->current_consumed
	,battery_status->energy_consumed
	,battery_status->battery_remaining
	);
}

/**
 * @brief Send a battery_status message
 * @param chan The MAVLink channel to send this message
 *
 * @param id Battery ID
 * @param battery_function Function of the battery
 * @param type Type (chemistry) of the battery
 * @param temperature Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
 * @param voltages Battery voltage of cells, in millivolts (1 = 1 millivolt)
 * @param current_battery Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
 * @param current_consumed Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
 * @param energy_consumed Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
 * @param battery_remaining Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
 */
#ifdef MAVLINK_USE_CONVENIENCE_FUNCTIONS

static inline void mavlink_msg_battery_status_send(
	 mavlink_channel_t chan
	,uint8_t id
	,uint8_t battery_function
	,uint8_t type
	,int16_t temperature
	,const uint16_t* voltages
	,int16_t current_battery
	,int32_t current_consumed
	,int32_t energy_consumed
	,int8_t battery_remaining
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BATTERY_STATUS_LEN];
	_mav_put_int32_t(buf, 0, current_consumed);
	_mav_put_int32_t(buf, 4, energy_consumed);
	_mav_put_int16_t(buf, 8, temperature);
	_mav_put_uint16_t(buf, 10, voltages);
	_mav_put_int16_t_array(buf, 12, current_battery, 0);
	_mav_put_uint8_t(buf, 14, id);
	_mav_put_uint8_t(buf, 15, battery_function);
	_mav_put_uint8_t(buf, 16, type);
	_mav_put_int8_t(buf, 17, battery_remaining);
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BATTERY_STATUS, buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BATTERY_STATUS, buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
#else
	mavlink_battery_status_t packet;
	packet.id = id;
	packet.battery_function = battery_function;
	packet.type = type;
	packet.temperature = temperature;
	mav_array_memcpy(packet.voltages, voltages, sizeof(uint16_t)*10);
	packet.current_battery = current_battery;
	packet.current_consumed = current_consumed;
	packet.energy_consumed = energy_consumed;
	packet.battery_remaining = battery_remaining;
#if MAVLINK_CRC_EXTRA

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BATTERY_STATUS, (const char*)&packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else

	_mav_finalize_message_chan_send(chan, MAVLINK_MSG_ID_BATTERY_STATUS, (const char*)&packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
#endif
}

static inline void mavlink_msg_wID_battery_status_send(
	 mavlink_channel_t chan
	,uint8_t sID
	,uint8_t cID
	,uint8_t id
	,uint8_t battery_function
	,uint8_t type
	,int16_t temperature
	,const uint16_t* voltages
	,int16_t current_battery
	,int32_t current_consumed
	,int32_t energy_consumed
	,int8_t battery_remaining
	)
{
#if MAVLINK_NEED_BYTE_SWAP || !MAVLINK_ALIGNED_FIELDS
	char buf[MAVLINK_MSG_ID_BATTERY_STATUS_LEN];
	_mav_put_int32_t(buf, 0, current_consumed);
	_mav_put_int32_t(buf, 4, energy_consumed);
	_mav_put_int16_t(buf, 8, temperature);
	_mav_put_uint16_t(buf, 10, voltages);
	_mav_put_int16_t_array(buf, 12, current_battery, 0);
	_mav_put_uint8_t(buf, 14, id);
	_mav_put_uint8_t(buf, 15, battery_function);
	_mav_put_uint8_t(buf, 16, type);
	_mav_put_int8_t(buf, 17, battery_remaining);
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BATTERY_STATUS, buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BATTERY_STATUS, buf, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
#else
	mavlink_battery_status_t packet;
	packet.id = id;
	packet.battery_function = battery_function;
	packet.type = type;
	packet.temperature = temperature;
	mav_array_memcpy(packet.voltages, voltages, sizeof(uint16_t)*10);
	packet.current_battery = current_battery;
	packet.current_consumed = current_consumed;
	packet.energy_consumed = energy_consumed;
	packet.battery_remaining = battery_remaining;
#if MAVLINK_CRC_EXTRA

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BATTERY_STATUS, (const char*)&packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN, MAVLINK_MSG_ID_BATTERY_STATUS_CRC);
#else

	_mav_wID_finalize_message_chan_send(chan, sID, cID, MAVLINK_MSG_ID_BATTERY_STATUS, (const char*)&packet, MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
#endif
}

#endif // MAVLINK_USE_CONVENIENCE_FUNCTIONS

// MESSAGE BATTERY_STATUS UNPACKING

/**
 * @brief Get field id from battery_status message
 *
 * @return Battery ID
 */
static inline uint8_t mavlink_msg_battery_status_get_id(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,0);
}

/**
 * @brief Get field battery_function from battery_status message
 *
 * @return Function of the battery
 */
static inline uint8_t mavlink_msg_battery_status_get_battery_function(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,1);
}

/**
 * @brief Get field type from battery_status message
 *
 * @return Type (chemistry) of the battery
 */
static inline uint8_t mavlink_msg_battery_status_get_type(const mavlink_message_t* msg)
{
	return _MAV_RETURN_uint8_t(msg,2);
}

/**
 * @brief Get field temperature from battery_status message
 *
 * @return Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
 */
static inline int16_t mavlink_msg_battery_status_get_temperature(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int16_t(msg,3);
}

/**
 * @brief Get field voltages from battery_status message
 *
 * @return Battery voltage of cells, in millivolts (1 = 1 millivolt)
 */
static inline uint16_t mavlink_msg_battery_status_get_voltages(const mavlink_message_t* msg, uint16_t* voltages)
{
	return _MAV_RETURN_uint16_t_array(msg,voltages,10,5);
}

/**
 * @brief Get field current_battery from battery_status message
 *
 * @return Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
 */
static inline int16_t mavlink_msg_battery_status_get_current_battery(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int16_t(msg,7);
}

/**
 * @brief Get field current_consumed from battery_status message
 *
 * @return Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
 */
static inline int32_t mavlink_msg_battery_status_get_current_consumed(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int32_t(msg,9);
}

/**
 * @brief Get field energy_consumed from battery_status message
 *
 * @return Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
 */
static inline int32_t mavlink_msg_battery_status_get_energy_consumed(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int32_t(msg,13);
}

/**
 * @brief Get field battery_remaining from battery_status message
 *
 * @return Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery
 */
static inline int8_t mavlink_msg_battery_status_get_battery_remaining(const mavlink_message_t* msg)
{
	return _MAV_RETURN_int8_t(msg,17);
}

/**
 * @brief Decode a battery_status message into a struct
 *
 * @param msg The message to decode
 * @param battery_status C-struct to decode the message contents into
 */
static inline void mavlink_msg_battery_status_decode(const mavlink_message_t* msg, mavlink_battery_status_t* battery_status)
{
#if MAVLINK_NEED_BYTE_SWAP
	battery_status->id = mavlink_msg_battery_status_get_id(msg);
	battery_status->battery_function = mavlink_msg_battery_status_get_battery_function(msg);
	battery_status->type = mavlink_msg_battery_status_get_type(msg);
	battery_status->temperature = mavlink_msg_battery_status_get_temperature(msg);
	mavlink_msg_battery_status_get_voltages(msg, battery_status->voltages);
	battery_status->current_battery = mavlink_msg_battery_status_get_current_battery(msg);
	battery_status->current_consumed = mavlink_msg_battery_status_get_current_consumed(msg);
	battery_status->energy_consumed = mavlink_msg_battery_status_get_energy_consumed(msg);
	battery_status->battery_remaining = mavlink_msg_battery_status_get_battery_remaining(msg);
#else
	memcpy(battery_status, _MAV_PAYLOAD(msg), MAVLINK_MSG_ID_BATTERY_STATUS_LEN);
#endif
}
