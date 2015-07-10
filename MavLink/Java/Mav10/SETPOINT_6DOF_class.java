//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SETPOINT_6DOF(149)
--------------------------------------
%%~ Set the 6 DOF setpoint for a attitude and position controller.
--------------------------------------
*/
public class SETPOINT_6DOF_class //implements Loggable
{
	public static final int msgID = 149;
	public short	 target_system;	 	// System ID
	public float	 trans_x;			 	// Translational Component in x
	public float	 trans_y;			 	// Translational Component in y
	public float	 trans_z;			 	// Translational Component in z
	public float	 rot_x;			 	// Rotational Component in x
	public float	 rot_y;			 	// Rotational Component in y
	public float	 rot_z;			 	// Rotational Component in z

	private packet rcvPacket;
	private packet sndPacket;

	public SETPOINT_6DOF_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
	}

	public SETPOINT_6DOF_class(SETPOINT_6DOF_class o)
	{
		target_system = o.target_system;
		trans_x = o.trans_x;
		trans_y = o.trans_y;
		trans_z = o.trans_z;
		rot_x = o.rot_x;
		rot_y = o.rot_y;
		rot_z = o.rot_z;
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

			// int[] mavLen = {1, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {2, 4, 4, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			trans_x			= rcvPacket.getFloat();
			trans_y			= rcvPacket.getFloat();
			trans_z			= rcvPacket.getFloat();
			rot_x			= rcvPacket.getFloat();
			rot_y			= rcvPacket.getFloat();
			rot_z			= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,trans_x
					 ,trans_y
					 ,trans_z
					 ,rot_x
					 ,rot_y
					 ,rot_z
					 );
	}

	public byte[] encode(
						 float v_trans_x
						,float v_trans_y
						,float v_trans_z
						,float v_rot_x
						,float v_rot_y
						,float v_rot_z
						)
	{
		return encode(
					    (short)1
					 ,v_trans_x
					 ,v_trans_y
					 ,v_trans_z
					 ,v_rot_x
					 ,v_rot_y
					 ,v_rot_z
					 );
	}

	public byte[] encode(
						 short v_target_system
						,float v_trans_x
						,float v_trans_y
						,float v_trans_z
						,float v_rot_x
						,float v_rot_y
						,float v_rot_z
						)
	{
		// int[] mavLen = {1, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {2, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putFloat(v_trans_x);	// Add "trans_x" parameter
		sndPacket.putFloat(v_trans_y);	// Add "trans_y" parameter
		sndPacket.putFloat(v_trans_z);	// Add "trans_z" parameter
		sndPacket.putFloat(v_rot_x);	// Add "rot_x" parameter
		sndPacket.putFloat(v_rot_y);	// Add "rot_y" parameter
		sndPacket.putFloat(v_rot_z);	// Add "rot_z" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SETPOINT_6DOF_target_system"
 				+ ", SETPOINT_6DOF_trans_x"
 				+ ", SETPOINT_6DOF_trans_y"
 				+ ", SETPOINT_6DOF_trans_z"
 				+ ", SETPOINT_6DOF_rot_x"
 				+ ", SETPOINT_6DOF_rot_y"
 				+ ", SETPOINT_6DOF_rot_z"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + trans_x
 				+ ", " + trans_y
 				+ ", " + trans_z
 				+ ", " + rot_x
 				+ ", " + rot_y
 				+ ", " + rot_z
				);
		return param;
	}
}
