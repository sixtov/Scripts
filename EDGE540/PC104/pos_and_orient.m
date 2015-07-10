%% GPS DATA
PC.ts_GPStime = timeseries(GPStime,Xpctime,'name','GPStime');
PC.ts_lat = timeseries(lat,Xpctime,'name','lat');
PC.ts_lon = timeseries(lon,Xpctime,'name','lon');
PC.ts_alt = timeseries(alt,Xpctime,'name','alt');

%% VN100 DATA
PC.ts_yaw   = timeseries(psi,  time,'name','yaw');
PC.ts_pitch = timeseries(theta,time,'name','pitch');
PC.ts_roll  = timeseries(phi,  time,'name','roll');

%% RESAMPLE GPS TO VN100
PC.ts_GPStime20hz = PC.ts_GPStime.resample(PC.ts_yaw.time);
PC.ts_lat20hz = PC.ts_lat.resample(PC.ts_yaw.time);
PC.ts_lon20hz = PC.ts_lon.resample(PC.ts_yaw.time);
PC.ts_alt20hz = PC.ts_alt.resample(PC.ts_yaw.time);

%% RESAMPLE VN100 TO GPS
PC.ts_yaw1hz   = PC.ts_yaw.resample(PC.ts_lat.time);
PC.ts_pitch1hz = PC.ts_pitch.resample(PC.ts_lat.time);
PC.ts_roll1hz   = PC.ts_roll.resample(PC.ts_lat.time);

plot(PC.ts_lat20hz.time,PC.ts_lat20hz.data)
axis([ 0 1000 37.01 37.03 ])
figure
plot(PC.ts_lon20hz.time,PC.ts_lon20hz.data)
axis([ 0 1000 -76.60 -76.58 ])
figure
plot(PC.ts_alt20hz.time,PC.ts_alt20hz.data)

%save pos_and_orient.mat PC.ts_GPStime20hz PC.ts_lat20hz PC.ts_lon20hz PC.ts_alt20hz PC.ts_yaw PC.ts_pitch PC.ts_roll 
%save pos_and_orient.mat PC.ts_lat20hz PC.ts_lon20hz PC.ts_alt20hz PC.ts_yaw PC.ts_pitch PC.ts_roll 
save pos_and_orient.mat PC
