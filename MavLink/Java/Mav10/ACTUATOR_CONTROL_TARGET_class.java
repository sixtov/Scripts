//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: ACTUATOR_CONTROL_TARGET(140)
--------------------------------------
%%~ Set the vehicle attitude and body angular rates.
--------------------------------------
*/
public class ACTUATOR_CONTROL_TARGET_class //implements Loggable
{
	public static final int msgID = 140;
	public long	 time_usec;	 	// Timestamp (micros since boot or Unix epoch)
	public short	 group_mlx;	 	// Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
	public float[]	 controls = new float[32];		// Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.

	private packet rcvPacket;
	private packet sndPacket;

	public ACTUATOR_CONTROL_TARGET_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
	}

	public ACTUATOR_CONTROL_TARGET_class(ACTUATOR_CONTROL_TARGET_class o)
	{
		time_usec = o.time_usec;
		group_mlx = o.group_mlx;
		controls = o.controls;
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

			// int[] mavLen = {8, 1, 4};
			// int[] javLen = {8, 2, 32};

			time_usec	= rcvPacket.getLong();
			group_mlx	= rcvPacket.getShortB();
			rcvPacket.getByte(controls, 0, 32);
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  time_usec
					 ,group_mlx
					 ,controls
					 );
	}

	public byte[] encode(
						 long v_time_usec
						,short v_group_mlx
						,float[] v_controls
						)
	{
		// int[] mavLen = {8, 1, 4};
		// int[] javLen = {8, 2, 32};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putLong(v_time_usec);	// Add "time_usec" parameter
		sndPacket.putByteS(v_group_mlx);	// Add "group_mlx" parameter
		sndPacket.putByte(v_controls,0,32);	// Add "controls" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", ACTUATOR_CONTROL_TARGET_time_usec"
 				+ ", ACTUATOR_CONTROL_TARGET_group_mlx"
 				+ ", ACTUATOR_CONTROL_TARGET_controls"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + time_usec
 				+ ", " + group_mlx
 				+ ", " + controls
				);
		return param;
	}
}
