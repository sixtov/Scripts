//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_ATTITUDE_TARGET(82)
--------------------------------------
%%~ Set the vehicle attitude and body angular rates.
--------------------------------------
*/
public class SET_ATTITUDE_TARGET_class //implements Loggable
{
	public static final int msgID = 82;
	public long	 time_boot_ms;	 	// Timestamp in milliseconds since system boot
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 type_mask;		 	// Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude
	public float[]	 q = new float[16];					// Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
	public float	 body_roll_rate;	 	// Body roll rate in radians per second
	public float	 body_pitch_rate;	 	// Body roll rate in radians per second
	public float	 body_yaw_rate;	 	// Body roll rate in radians per second
	public float	 thrust;			 	// Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)

	private packet rcvPacket;
	private packet sndPacket;

	public SET_ATTITUDE_TARGET_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public SET_ATTITUDE_TARGET_class(SET_ATTITUDE_TARGET_class o)
	{
		time_boot_ms = o.time_boot_ms;
		target_system = o.target_system;
		target_component = o.target_component;
		type_mask = o.type_mask;
		q = o.q;
		body_roll_rate = o.body_roll_rate;
		body_pitch_rate = o.body_pitch_rate;
		body_yaw_rate = o.body_yaw_rate;
		thrust = o.thrust;
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

			// int[] mavLen = {4, 1, 1, 1, 4, 4, 4, 4, 4};
			// int[] javLen = {8, 2, 2, 2, 16, 4, 4, 4, 4};

			time_boot_ms		= rcvPacket.getLongI();
			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			type_mask		= rcvPacket.getShortB();
			rcvPacket.getByte(q, 0, 16);
			body_roll_rate	= rcvPacket.getFloat();
			body_pitch_rate	= rcvPacket.getFloat();
			body_yaw_rate	= rcvPacket.getFloat();
			thrust			= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,(short)1
					 ,(short)1
					 ,type_mask
					 ,q
					 ,body_roll_rate
					 ,body_pitch_rate
					 ,body_yaw_rate
					 ,thrust
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,short v_type_mask
						,float[] v_q
						,float v_body_roll_rate
						,float v_body_pitch_rate
						,float v_body_yaw_rate
						,float v_thrust
						)
	{
		return encode(
					  v_time_boot_ms
					 ,  (short)1
					 ,  (short)1
					 ,v_type_mask
					 ,v_q
					 ,v_body_roll_rate
					 ,v_body_pitch_rate
					 ,v_body_yaw_rate
					 ,v_thrust
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,short v_target_system
						,short v_target_component
						,short v_type_mask
						,float[] v_q
						,float v_body_roll_rate
						,float v_body_pitch_rate
						,float v_body_yaw_rate
						,float v_thrust
						)
	{
		// int[] mavLen = {4, 1, 1, 1, 4, 4, 4, 4, 4};
		// int[] javLen = {8, 2, 2, 2, 16, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByteS(v_type_mask);	// Add "type_mask" parameter
		sndPacket.putByte(v_q,0,16);	// Add "q" parameter
		sndPacket.putFloat(v_body_roll_rate);	// Add "body_roll_rate" parameter
		sndPacket.putFloat(v_body_pitch_rate);	// Add "body_pitch_rate" parameter
		sndPacket.putFloat(v_body_yaw_rate);	// Add "body_yaw_rate" parameter
		sndPacket.putFloat(v_thrust);	// Add "thrust" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_ATTITUDE_TARGET_time_boot_ms"
 				+ ", SET_ATTITUDE_TARGET_target_system"
 				+ ", SET_ATTITUDE_TARGET_target_component"
 				+ ", SET_ATTITUDE_TARGET_type_mask"
 				+ ", SET_ATTITUDE_TARGET_q"
 				+ ", SET_ATTITUDE_TARGET_body_roll_rate"
 				+ ", SET_ATTITUDE_TARGET_body_pitch_rate"
 				+ ", SET_ATTITUDE_TARGET_body_yaw_rate"
 				+ ", SET_ATTITUDE_TARGET_thrust"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + type_mask
 				+ ", " + q
 				+ ", " + body_roll_rate
 				+ ", " + body_pitch_rate
 				+ ", " + body_yaw_rate
 				+ ", " + thrust
				);
		return param;
	}
}
