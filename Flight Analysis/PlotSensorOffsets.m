%%
slvFigure('Sensor Sensitivity');
h = subplot(4,2,1);
plot(MavLink.ANALOG_EU.time,MavLink.ANALOG_EU.RPM)
grid on
ylabel('RPM')

h = [h subplot(4,2,2)];
plot(MavLink.ATTITUDE.time,MavLink.ATTITUDE.roll)
grid on
ylabel('Roll (deg)')

h = [h subplot(4,2,3)];
hold off
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.xacc)
hold all
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.yacc)
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.zacc)
grid on
ylabel('Acc (mg)')

h = [h subplot(4,2,4)];
hold off
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.accel_cal_x)
hold all
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.accel_cal_y)
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.accel_cal_z)
grid on
ylabel('Acc Offset (mg)')

h = [h subplot(4,2,5)];
hold off
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.xgyro)
hold all
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.ygyro)
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.zgyro)
grid on
ylabel('Gyro (mrad/sec)')

h = [h subplot(4,2,6)];
hold off
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.gyro_cal_x)
hold all
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.gyro_cal_y)
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.gyro_cal_z)
grid on
ylabel('Gyro Offset (mrad/sec)')

h = [h subplot(4,2,7)];
hold off
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.xmag)
hold all
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.ymag)
plot(MavLink.RAW_IMU.time,MavLink.RAW_IMU.zmag)
grid on
ylabel('Mag')

h = [h subplot(4,2,8)];
hold off
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.mag_ofs_x)
hold all
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.mag_ofs_y)
plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.mag_ofs_z)
grid on
ylabel('Mag Offset')

% h = [h subplot(,,9)];
% hold off
% plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.raw_press)
% hold all
% plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.raw_temp)
% plot(MavLink.SENSOR_OFFSETS.time,MavLink.SENSOR_OFFSETS.mag_declination)

%text(-1500, 780,'Flight 52 (aborted)','FontSize',14)
text(-1200, 780,'Flight 50','FontSize',14)

linkaxes(h,'x');
