//MavLink 1.0

//package gov.nasa.larc.AP;
//import gov.nasa.larc.serial.Loggable;

/**
Message ID: COMMAND_INT(75)
--------------------------------------
%%~ Message encoding a command with parameters as scaled integers. Scaling depends on 
%%~ the actual command value.
--------------------------------------
*/
public class COMMAND_INT_class //implements Loggable
{
	public static final int msgID = 75;
	public short	 target_system;	 	// System ID
	public short	 target_component; 	// Component ID
	public short	 frame;			 	// The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h
	public int		 command;			 	// The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs
	public short	 current;			 	// false:0, true:1
	public short	 autocontinue;	 	// autocontinue to next wp
	public float	 param1;			 	// PARAM1, see MAV_CMD enum
	public float	 param2;			 	// PARAM2, see MAV_CMD enum
	public float	 param3;			 	// PARAM3, see MAV_CMD enum
	public float	 param4;			 	// PARAM4, see MAV_CMD enum
	public int		 x;				 	// PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7
	public int		 y;				 	// PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7
	public float	 z;				 	// PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame.

	private packet rcvPacket;
	private packet sndPacket;

	public COMMAND_INT_class()
	{
		rcvPacket = new packet(msgID);
		sndPacket = new packet(msgID);
		target_system = 1;
		target_component = 1;
	}

	public COMMAND_INT_class(COMMAND_INT_class o)
	{
		target_system = o.target_system;
		target_component = o.target_component;
		frame = o.frame;
		command = o.command;
		current = o.current;
		autocontinue = o.autocontinue;
		param1 = o.param1;
		param2 = o.param2;
		param3 = o.param3;
		param4 = o.param4;
		x = o.x;
		y = o.y;
		z = o.z;
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

			// int[] mavLen = {1, 1, 1, 2, 1, 1, 4, 4, 4, 4, 4, 4, 4};
			// int[] javLen = {2, 2, 2, 4, 2, 2, 4, 4, 4, 4, 4, 4, 4};

			target_system	= rcvPacket.getShortB();
			target_component	= rcvPacket.getShortB();
			frame			= rcvPacket.getShortB();
			command			= rcvPacket.getIntS();
			current			= rcvPacket.getShortB();
			autocontinue		= rcvPacket.getShortB();
			param1			= rcvPacket.getFloat();
			param2			= rcvPacket.getFloat();
			param3			= rcvPacket.getFloat();
			param4			= rcvPacket.getFloat();
			x				= rcvPacket.getInt();
			y				= rcvPacket.getInt();
			z				= rcvPacket.getFloat();
		}
		return(pstatus);
	}

	public byte[] encode()
	{
		return encode(
					  (short)1
					 ,(short)1
					 ,frame
					 ,command
					 ,current
					 ,autocontinue
					 ,param1
					 ,param2
					 ,param3
					 ,param4
					 ,x
					 ,y
					 ,z
					 );
	}

	public byte[] encode(
						 short v_frame
						,int v_command
						,short v_current
						,short v_autocontinue
						,float v_param1
						,float v_param2
						,float v_param3
						,float v_param4
						,int v_x
						,int v_y
						,float v_z
						)
	{
		return encode(
					    (short)1
					 ,  (short)1
					 ,v_frame
					 ,v_command
					 ,v_current
					 ,v_autocontinue
					 ,v_param1
					 ,v_param2
					 ,v_param3
					 ,v_param4
					 ,v_x
					 ,v_y
					 ,v_z
					 );
	}

	public byte[] encode(
						 short v_target_system
						,short v_target_component
						,short v_frame
						,int v_command
						,short v_current
						,short v_autocontinue
						,float v_param1
						,float v_param2
						,float v_param3
						,float v_param4
						,int v_x
						,int v_y
						,float v_z
						)
	{
		// int[] mavLen = {1, 1, 1, 2, 1, 1, 4, 4, 4, 4, 4, 4, 4};
		// int[] javLen = {2, 2, 2, 4, 2, 2, 4, 4, 4, 4, 4, 4, 4};

		sndPacket.setSndSeq();

		sndPacket.resetDataIdx();
		sndPacket.putByteS(v_target_system);	// Add "target_system" parameter
		sndPacket.putByteS(v_target_component);	// Add "target_component" parameter
		sndPacket.putByteS(v_frame);	// Add "frame" parameter
		sndPacket.putShortI(v_command);	// Add "command" parameter
		sndPacket.putByteS(v_current);	// Add "current" parameter
		sndPacket.putByteS(v_autocontinue);	// Add "autocontinue" parameter
		sndPacket.putFloat(v_param1);	// Add "param1" parameter
		sndPacket.putFloat(v_param2);	// Add "param2" parameter
		sndPacket.putFloat(v_param3);	// Add "param3" parameter
		sndPacket.putFloat(v_param4);	// Add "param4" parameter
		sndPacket.putInt(v_x);	// Add "x" parameter
		sndPacket.putInt(v_y);	// Add "y" parameter
		sndPacket.putFloat(v_z);	// Add "z" parameter

		// encode the checksum

		sndPacket.putChkSum();

		return sndPacket.getPacket();
	}

	public String getLogHeader()
	{
		String param = (
				  "  time"
 				+ ", COMMAND_INT_target_system"
 				+ ", COMMAND_INT_target_component"
 				+ ", COMMAND_INT_frame"
 				+ ", COMMAND_INT_command"
 				+ ", COMMAND_INT_current"
 				+ ", COMMAND_INT_autocontinue"
 				+ ", COMMAND_INT_param1"
 				+ ", COMMAND_INT_param2"
 				+ ", COMMAND_INT_param3"
 				+ ", COMMAND_INT_param4"
 				+ ", COMMAND_INT_x"
 				+ ", COMMAND_INT_y"
 				+ ", COMMAND_INT_z"
				);
		return param;
	}

    public String getLogData()
	{
		String param = (
				System.currentTimeMillis()
 				+ ", " + target_system
 				+ ", " + target_component
 				+ ", " + frame
 				+ ", " + command
 				+ ", " + current
 				+ ", " + autocontinue
 				+ ", " + param1
 				+ ", " + param2
 				+ ", " + param3
 				+ ", " + param4
 				+ ", " + x
 				+ ", " + y
 				+ ", " + z
				);
		return param;
	}
}
