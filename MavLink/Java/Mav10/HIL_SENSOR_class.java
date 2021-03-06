//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: HIL_SENSOR(107)
--------------------------------------
%%~ The IMU readings in SI units in NED body frame
--------------------------------------
*/
public class HIL_SENSOR_class //implements Loggable
{
	public static final int msgID = 107;
	public long	 time_usec;		 	// Timestamp (microseconds, synced to UNIX time or since system boot)
	public float	 xacc;			 	// X acceleration (m/s^2)
	public float	 yacc;			 	// Y acceleration (m/s^2)
	public float	 zacc;			 	// Z acceleration (m/s^2)
	public float	 xgyro;			 	// Angular speed around X axis in body frame (rad / sec)
	public float	 ygyro;			 	// Angular speed around Y axis in body frame (rad / sec)
	public float	 zgyro;			 	// Angular speed around Z axis in body frame (rad / sec)
	public float	 xmag;			 	// X Magnetic field (Gauss)
	public float	 ymag;			 	// Y Magnetic field (Gauss)
	public float	 zmag;			 	// Z Magnetic field (Gauss)
	public float	 abs_pressure;	 	// Absolute pressure in millibar
	public float	 diff_pressure;	 	// Differential pressure (airspeed) in millibar
	public float	 pressure_alt;	 	// Altitude calculated from pressure
	public float	 temperature;		 	// Temperature in degrees celsius
	public long	 fields_updated;	 	// Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature

	private packet rcvPacket;
	private packet sndPacket;

	public HIL_SENSOR_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public HIL_SENSOR_class(HIL_SENSOR_class o)
	{
		time_usec = o.time_usec;
		xacc = o.xacc;
		yacc = o.yacc;
		zacc = o.zacc;
		xgyro = o.xgyro;
		ygyro = o.ygyro;
		zgyro = o.zgyro;
		xmag = o.xmag;
		ymag = o.ymag;
		zmag = o.zmag;
		abs_pressure = o.abs_pressure;
		diff_pressure = o.diff_pressure;
		pressure_alt = o.pressure_alt;
		temperature = o.temperature;
		fields_updated = o.fields_updated;
	}

	public boolean parse(byte[] b)
	{
		return parse(b, false);
	}

	public boolean parse(byte[] b, boolean valid)
	{
		rcvPacket.load(b);

		boolean pstatus = valid || rcvPacket.isPacket();
		if (pstatus)
		{
			rcvPacket.updateSeqNum();

			// int[] mavLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8};

			time_usec		= rcvPacket.getLong();
			xacc				= rcvPacket.getFloat();
			yacc				= rcvPacket.getFloat();
			zacc				= rcvPacket.getFloat();
			xgyro			= rcvPacket.getFloat();
			ygyro			= rcvPacket.getFloat();
			zgyro			= rcvPacket.getFloat();
			xmag				= rcvPacket.getFloat();
			ymag				= rcvPacket.getFloat();
			zmag				= rcvPacket.getFloat();
			abs_pressure		= rcvPacket.getFloat();
			diff_pressure	= rcvPacket.getFloat();
			pressure_alt		= rcvPacket.getFloat();
			temperature		= rcvPacket.getFloat();
			fields_updated	= rcvPacket.getLongI();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_usec
					 ,xacc
					 ,yacc
					 ,zacc
					 ,xgyro
					 ,ygyro
					 ,zgyro
					 ,xmag
					 ,ymag
					 ,zmag
					 ,abs_pressure
					 ,diff_pressure
					 ,pressure_alt
					 ,temperature
					 ,fields_updated
					 );
	}

	public byte[] encode(
						 long v_time_usec
						,float v_xacc
						,float v_yacc
						,float v_zacc
						,float v_xgyro
						,float v_ygyro
						,float v_zgyro
						,float v_xmag
						,float v_ymag
						,float v_zmag
						,float v_abs_pressure
						,float v_diff_pressure
						,float v_pressure_alt
						,float v_temperature
						,long v_fields_updated
						)
	{
		// int[] mavLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 8};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putFloat(v_xacc);	// Add "xacc" parameter
		sndPacket.putFloat(v_yacc);	// Add "yacc" parameter
		sndPacket.putFloat(v_zacc);	// Add "zacc" parameter
		sndPacket.putFloat(v_xgyro);	// Add "xgyro" parameter
		sndPacket.putFloat(v_ygyro);	// Add "ygyro" parameter
		sndPacket.putFloat(v_zgyro);	// Add "zgyro" parameter
		sndPacket.putFloat(v_xmag);	// Add "xmag" parameter
		sndPacket.putFloat(v_ymag);	// Add "ymag" parameter
		sndPacket.putFloat(v_zmag);	// Add "zmag" parameter
		sndPacket.putFloat(v_abs_pressure);	// Add "abs_pressure" parameter
		sndPacket.putFloat(v_diff_pressure);	// Add "diff_pressure" parameter
		sndPacket.putFloat(v_pressure_alt);	// Add "pressure_alt" parameter
		sndPacket.putFloat(v_temperature);	// Add "temperature" parameter
		sndPacket.putIntL(v_fields_updated);	// Add "fields_updated" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", HIL_SENSOR_time_usec"
 				+ ", HIL_SENSOR_xacc"
 				+ ", HIL_SENSOR_yacc"
 				+ ", HIL_SENSOR_zacc"
 				+ ", HIL_SENSOR_xgyro"
 				+ ", HIL_SENSOR_ygyro"
 				+ ", HIL_SENSOR_zgyro"
 				+ ", HIL_SENSOR_xmag"
 				+ ", HIL_SENSOR_ymag"
 				+ ", HIL_SENSOR_zmag"
 				+ ", HIL_SENSOR_abs_pressure"
 				+ ", HIL_SENSOR_diff_pressure"
 				+ ", HIL_SENSOR_pressure_alt"
 				+ ", HIL_SENSOR_temperature"
 				+ ", HIL_SENSOR_fields_updated"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_usec
 				+ ", " + xacc
 				+ ", " + yacc
 				+ ", " + zacc
 				+ ", " + xgyro
 				+ ", " + ygyro
 				+ ", " + zgyro
 				+ ", " + xmag
 				+ ", " + ymag
 				+ ", " + zmag
 				+ ", " + abs_pressure
 				+ ", " + diff_pressure
 				+ ", " + pressure_alt
 				+ ", " + temperature
 				+ ", " + fields_updated
				);
		return param;
	}
}
