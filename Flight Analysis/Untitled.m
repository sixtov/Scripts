%%
t=4300;
[mv mi] = min(abs(MavLink.SENSOR_OFFSETS.time-t));
disp(sprintf('%0.2f\t',[double(MavLink.SENSOR_OFFSETS.accel_cal_x(mi)) ...
      double(MavLink.SENSOR_OFFSETS.accel_cal_y(mi)) ...
      double(MavLink.SENSOR_OFFSETS.accel_cal_z(mi)) ...
      double(MavLink.SENSOR_OFFSETS.gyro_cal_x(mi)) ...
      double(MavLink.SENSOR_OFFSETS.gyro_cal_y(mi)) ...
      double(MavLink.SENSOR_OFFSETS.gyro_cal_z(mi)) ...
      double(MavLink.SENSOR_OFFSETS.mag_ofs_x(mi)) ...
      double(MavLink.SENSOR_OFFSETS.mag_ofs_y(mi)) ...
      double(MavLink.SENSOR_OFFSETS.mag_ofs_z(mi))]));

%%
[a b c] = xlsread('BadSensorDetectionData.xls');
attFlag = a(:,1);
ax = a(:,4);
ay = a(:,5);
az = a(:,6);
gx = a(:,7);
gx = a(:,8);
gz = a(:,9);
mx = a(:,10);
my = a(:,11);
my = a(:,12);
hold off
plot3(ax(attFlag==1),ay(attFlag==1),az(attFlag==1),'bo')
grid on
hold on
plot3(ax(attFlag==0),ay(attFlag==0),az(attFlag==0),'rd')

%%
ra = sqrt(ax.^2 + ay.^2 + az.^2);
hold off
plot(attFlag(attFlag==1),ra(attFlag==1),'bo')
hold on
plot(attFlag(attFlag==0),ra(attFlag==0),'rd')

