//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: SET_QUAD_MOTORS_SETPOINT(60)
--------------------------------------
%%~ Setpoint in the four motor speeds
--------------------------------------
*/
public class SET_QUAD_MOTORS_SETPOINT_class //implements Loggable
{
	public static final int msgID = 60;
	public short	 target_system;	 	// System ID of the system that should set these motor commands
	public int		 motor_front_nw;	 	// Front motor in + configuration, front left motor in x configuration
	public int		 motor_right_ne;	 	// Right motor in + configuration, front right motor in x configuration
	public int		 motor_back_se;	 	// Back motor in + configuration, back right motor in x configuration
	public int		 motor_left_sw;	 	// Left motor in + configuration, back left motor in x configuration

	private packet rcvPacket;
	private packet sndPacket;

	public SET_QUAD_MOTORS_SETPOINT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
	}

	public SET_QUAD_MOTORS_SETPOINT_class(SET_QUAD_MOTORS_SETPOINT_class o)
	{
		target_system = o.target_system;
		motor_front_nw = o.motor_front_nw;
		motor_right_ne = o.motor_right_ne;
		motor_back_se = o.motor_back_se;
		motor_left_sw = o.motor_left_sw;
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

			// int[] mavLen = {1, 2, 2, 2, 2};
			// int[] javLen = {2, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			motor_front_nw	= rcvPacket.getIntS();
			motor_right_ne	= rcvPacket.getIntS();
			motor_back_se	= rcvPacket.getIntS();
			motor_left_sw	= rcvPacket.getIntS();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,motor_front_nw
					 ,motor_right_ne
					 ,motor_back_se
					 ,motor_left_sw
					 );
	}

	public byte[] encode(
						 int v_motor_front_nw
						,int v_motor_right_ne
						,int v_motor_back_se
						,int v_motor_left_sw
						)
	{
		return encode(
					    (short)1
					 ,v_motor_front_nw
					 ,v_motor_right_ne
					 ,v_motor_back_se
					 ,v_motor_left_sw
					 );
	}

	public byte[] encode(
						 short v_target_system
						,int v_motor_front_nw
						,int v_motor_right_ne
						,int v_motor_back_se
						,int v_motor_left_sw
						)
	{
		// int[] mavLen = {1, 2, 2, 2, 2};
		// int[] javLen = {2, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putShortI(v_motor_front_nw);	// Add "motor_front_nw" parameter
		sndPacket.putShortI(v_motor_right_ne);	// Add "motor_right_ne" parameter
		sndPacket.putShortI(v_motor_back_se);	// Add "motor_back_se" parameter
		sndPacket.putShortI(v_motor_left_sw);	// Add "motor_left_sw" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", SET_QUAD_MOTORS_SETPOINT_target_system"
 				+ ", SET_QUAD_MOTORS_SETPOINT_motor_front_nw"
 				+ ", SET_QUAD_MOTORS_SETPOINT_motor_right_ne"
 				+ ", SET_QUAD_MOTORS_SETPOINT_motor_back_se"
 				+ ", SET_QUAD_MOTORS_SETPOINT_motor_left_sw"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + motor_front_nw
 				+ ", " + motor_right_ne
 				+ ", " + motor_back_se
 				+ ", " + motor_left_sw
				);
		return param;
	}
}
