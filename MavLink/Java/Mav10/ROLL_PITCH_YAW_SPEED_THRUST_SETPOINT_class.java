//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT(59)
--------------------------------------
%%~ Setpoint in rollspeed, pitchspeed, yawspeed currently active on the system.
--------------------------------------
*/
public class ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class //implements Loggable
{
	public static final int msgID = 59;
	public long	 time_boot_ms; 	// Timestamp in milliseconds since system boot
	public float	 roll_speed;	 	// Desired roll angular speed in rad/s
	public float	 pitch_speed;	 	// Desired pitch angular speed in rad/s
	public float	 yaw_speed;	 	// Desired yaw angular speed in rad/s
	public float	 thrust;		 	// Collective thrust, normalized to 0 .. 1

	private packet rcvPacket;
	private packet sndPacket;

	public ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class(ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_class o)
	{
		time_boot_ms = o.time_boot_ms;
		roll_speed = o.roll_speed;
		pitch_speed = o.pitch_speed;
		yaw_speed = o.yaw_speed;
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
			roll_speed	= rcvPacket.getFloat();
			pitch_speed	= rcvPacket.getFloat();
			yaw_speed	= rcvPacket.getFloat();
			thrust		= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_boot_ms
					 ,roll_speed
					 ,pitch_speed
					 ,yaw_speed
					 ,thrust
					 );
	}

	public byte[] encode(
						 long v_time_boot_ms
						,float v_roll_speed
						,float v_pitch_speed
						,float v_yaw_speed
						,float v_thrust
						)
	{
		// int[] mavLen = {4, 4, 4, 4, 4};
		// int[] javLen = {8, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putIntL(v_time_boot_ms);	// Add "time_boot_ms" parameter
		sndPacket.putFloat(v_roll_speed);	// Add "roll_speed" parameter
		sndPacket.putFloat(v_pitch_speed);	// Add "pitch_speed" parameter
		sndPacket.putFloat(v_yaw_speed);	// Add "yaw_speed" parameter
		sndPacket.putFloat(v_thrust);	// Add "thrust" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_time_boot_ms"
 				+ ", ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_roll_speed"
 				+ ", ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_pitch_speed"
 				+ ", ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_yaw_speed"
 				+ ", ROLL_PITCH_YAW_SPEED_THRUST_SETPOINT_thrust"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_boot_ms
 				+ ", " + roll_speed
 				+ ", " + pitch_speed
 				+ ", " + yaw_speed
 				+ ", " + thrust
				);
		return param;
	}
}
