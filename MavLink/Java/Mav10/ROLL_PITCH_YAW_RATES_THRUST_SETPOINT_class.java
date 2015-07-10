//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: ROLL_PITCH_YAW_RATES_THRUST_SETPOINT(80)
--------------------------------------
%%~ Setpoint in roll, pitch, yaw rates and thrust currently active on the system.
--------------------------------------
*/
public class ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class //implements Loggable
{
	public static final int msgID = 80;
	public long	 time_boot_ms; 	// Timestamp in milliseconds since system boot
	public float	 roll_rate;	 	// Desired roll rate in radians per second
	public float	 pitch_rate;	 	// Desired pitch rate in radians per second
	public float	 yaw_rate;	 	// Desired yaw rate in radians per second
	public float	 thrust;		 	// Collective thrust, normalized to 0 .. 1

	private packet rcvPacket;
	private packet sndPacket;

	public ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class(ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_class o)
	{
		time_boot_ms = o.time_boot_ms;
		roll_rate = o.roll_rate;
		pitch_rate = o.pitch_rate;
		yaw_rate = o.yaw_rate;
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

			// int[] mavLen = {4, 4, 4, 4, 4};
			// int[] javLen = {8, 4, 4, 4, 4};

			time_boot_ms	= rcvPacket.getLongI();
			roll_rate	= rcvPacket.getFloat();
			pitch_rate	= rcvPacket.getFloat();
			yaw_rate		= rcvPacket.getFloat();
			thrust		= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,roll_rate
					 ,pitch_rate
					 ,yaw_rate
					 ,thrust
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,float v_roll_rate
						,float v_pitch_rate
						,float v_yaw_rate
						,float v_thrust
						)
	{
		// int[] mavLen = {4, 4, 4, 4, 4};
		// int[] javLen = {8, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putFloat(v_roll_rate);	// Add "roll_rate" parameter
		sndPacket.putFloat(v_pitch_rate);	// Add "pitch_rate" parameter
		sndPacket.putFloat(v_yaw_rate);	// Add "yaw_rate" parameter
		sndPacket.putFloat(v_thrust);	// Add "thrust" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_time_boot_ms"
 				+ ", ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_roll_rate"
 				+ ", ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_pitch_rate"
 				+ ", ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_yaw_rate"
 				+ ", ROLL_PITCH_YAW_RATES_THRUST_SETPOINT_thrust"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + roll_rate
 				+ ", " + pitch_rate
 				+ ", " + yaw_rate
 				+ ", " + thrust
				);
		return param;
	}
}
