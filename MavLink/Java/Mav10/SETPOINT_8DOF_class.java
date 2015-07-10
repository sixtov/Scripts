//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SETPOINT_8DOF(148)
--------------------------------------
%%~ Set the 8 DOF setpoint for a controller.
--------------------------------------
*/
public class SETPOINT_8DOF_class //implements Loggable
{
	public static final int msgID = 148;
	public short	 target_system;	 	// System ID
	public float	 val1;			 	// Value 1
	public float	 val2;			 	// Value 2
	public float	 val3;			 	// Value 3
	public float	 val4;			 	// Value 4
	public float	 val5;			 	// Value 5
	public float	 val6;			 	// Value 6
	public float	 val7;			 	// Value 7
	public float	 val8;			 	// Value 8

	private packet rcvPacket;
	private packet sndPacket;

	public SETPOINT_8DOF_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
	}

	public SETPOINT_8DOF_class(SETPOINT_8DOF_class o)
	{
		target_system = o.target_system;
		val1 = o.val1;
		val2 = o.val2;
		val3 = o.val3;
		val4 = o.val4;
		val5 = o.val5;
		val6 = o.val6;
		val7 = o.val7;
		val8 = o.val8;
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

			// int[] mavLen = {1, 4, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {2, 4, 4, 4, 4, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			val1				= rcvPacket.getFloat();
			val2				= rcvPacket.getFloat();
			val3				= rcvPacket.getFloat();
			val4				= rcvPacket.getFloat();
			val5				= rcvPacket.getFloat();
			val6				= rcvPacket.getFloat();
			val7				= rcvPacket.getFloat();
			val8				= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,val1
					 ,val2
					 ,val3
					 ,val4
					 ,val5
					 ,val6
					 ,val7
					 ,val8
					 );
	}

	public byte[] encode(
						 float v_val1
						,float v_val2
						,float v_val3
						,float v_val4
						,float v_val5
						,float v_val6
						,float v_val7
						,float v_val8
						)
	{
		return encode(
					    (short)1
					 ,v_val1
					 ,v_val2
					 ,v_val3
					 ,v_val4
					 ,v_val5
					 ,v_val6
					 ,v_val7
					 ,v_val8
					 );
	}

	public byte[] encode(
						 short v_target_system
						,float v_val1
						,float v_val2
						,float v_val3
						,float v_val4
						,float v_val5
						,float v_val6
						,float v_val7
						,float v_val8
						)
	{
		// int[] mavLen = {1, 4, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {2, 4, 4, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putFloat(v_val1);	// Add "val1" parameter
		sndPacket.putFloat(v_val2);	// Add "val2" parameter
		sndPacket.putFloat(v_val3);	// Add "val3" parameter
		sndPacket.putFloat(v_val4);	// Add "val4" parameter
		sndPacket.putFloat(v_val5);	// Add "val5" parameter
		sndPacket.putFloat(v_val6);	// Add "val6" parameter
		sndPacket.putFloat(v_val7);	// Add "val7" parameter
		sndPacket.putFloat(v_val8);	// Add "val8" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SETPOINT_8DOF_target_system"
 				+ ", SETPOINT_8DOF_val1"
 				+ ", SETPOINT_8DOF_val2"
 				+ ", SETPOINT_8DOF_val3"
 				+ ", SETPOINT_8DOF_val4"
 				+ ", SETPOINT_8DOF_val5"
 				+ ", SETPOINT_8DOF_val6"
 				+ ", SETPOINT_8DOF_val7"
 				+ ", SETPOINT_8DOF_val8"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + val1
 				+ ", " + val2
 				+ ", " + val3
 				+ ", " + val4
 				+ ", " + val5
 				+ ", " + val6
 				+ ", " + val7
 				+ ", " + val8
				);
		return param;
	}
}
