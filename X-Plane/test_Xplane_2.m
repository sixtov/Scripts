%%
if (exist('uXPLANE','var'))
    if (~isempty(uXPLANE))
        fclose(uXPLANE);
        uXPLANE = [];
    end
end
%%
%clear 
%u2 = udp('localhost', 'RemotePort', 49000, 'LocalPort', 49005,'ByteOrder','littleEndian','InputBufferSize',1024,'OutputBufferSize',1024);
%u2 = udp('localhost', 'RemotePort', 49000, 'LocalPort', 49005,'ByteOrder','bigEndian','InputBufferSize',1024,'OutputBufferSize',1024);
rPort = 6700;
lPort = 6701;
%uXPLANE = udp('localhost', ...%u2 = udp('192.168.0.150', ...
uXPLANE = udp('255.255.255.255', ...%u2 = udp('192.168.0.150', ...
    'RemotePort', rPort, ...
    'LocalPort', lPort, ...
    'ByteOrder','bigEndian','InputBufferSize',1024,'OutputBufferSize',1024);
fopen(uXPLANE);

%%
if (exist('uAPM','var'))
    if (~isempty(uAPM))
        fclose(uAPM);
        uAPM = [];
    end
end
%clear
%%
%clear 
%u2 = udp('localhost', 'RemotePort', 49000, 'LocalPort', 49005,'ByteOrder','littleEndian','InputBufferSize',1024,'OutputBufferSize',1024);
%u2 = udp('localhost', 'RemotePort', 49000, 'LocalPort', 49005,'ByteOrder','bigEndian','InputBufferSize',1024,'OutputBufferSize',1024);
rPort = 5700;
lPort = 5701;
uAPM = udp('localhost', ...%u2 = udp('192.168.0.150', ...
    'RemotePort', rPort, ...
    'LocalPort', lPort, ...
    'ByteOrder','bigEndian','InputBufferSize',1024,'OutputBufferSize',1024);
fopen(uAPM);

%%
%cd('G:\\Flight Data');
load('XPlane_Data.mat');
% load('R2_Flight_50_2013-04-09 09-35-09_mavLink.mat');
% a1 = [ ...
%     MavLink_tsc.APM_GPS_RAW_lat.data(29000:end) ...
%     MavLink_tsc.APM_GPS_RAW_lon.data(29000:end) ... 
%     3.28*MavLink_tsc.APM_GPS_RAW_alt.data(29000:end) ...
%     (180/pi)*MavLink_tsc.APM_ATTITUDE_roll.data(29000:end) ...
%     (180/pi)*MavLink_tsc.APM_ATTITUDE_pitch.data(29000:end) ...
%     (180/pi)*MavLink_tsc.APM_ATTITUDE_yaw.data(29000:end) ...
%     ];


latOff =   -0.3394749958;   %37.458103 - a11(1,1);
a1(:,1)  = a1(:,1) +latOff;
a2(:,1)  = a2(:,1) +latOff;
a3(:,1)  = a3(:,1) +latOff;
a4(:,1)  = a4(:,1) +latOff;
a5(:,1)  = a5(:,1) +latOff;
a6(:,1)  = a6(:,1) +latOff;
a7(:,1)  = a7(:,1) +latOff;
a8(:,1)  = a8(:,1) +latOff;
a9(:,1)  = a9(:,1) +latOff;
a10(:,1) = a10(:,1)+latOff;
a11(:,1) = a11(:,1)+latOff;
a12(:,1) = a12(:,1)+latOff;
a13(:,1) = a13(:,1)+latOff;
a14(:,1) = a14(:,1)+latOff;
a15(:,1) = a15(:,1)+latOff;
a16(:,1) = a16(:,1)+latOff;
a17(:,1) = a17(:,1)+latOff;
a18(:,1) = a18(:,1)+latOff;
a19(:,1) = a19(:,1)+latOff;

lonOff = 0.558049678; %-122.112061  - a11(1,2);
a1(:,2)  = a1(:,2) +lonOff;
a2(:,2)  = a2(:,2) +lonOff;
a3(:,2)  = a3(:,2) +lonOff;
a4(:,2)  = a4(:,2) +lonOff;
a5(:,2)  = a5(:,2) +lonOff;
a6(:,2)  = a6(:,2) +lonOff;
a7(:,2)  = a7(:,2) +lonOff;
a8(:,2)  = a8(:,2) +lonOff;
a9(:,2)  = a9(:,2) +lonOff;
a10(:,2) = a10(:,2)+lonOff;
a11(:,2) = a11(:,2)+lonOff;
a12(:,2) = a12(:,2)+lonOff;
a13(:,2) = a13(:,2)+lonOff;
a14(:,2) = a14(:,2)+lonOff;
a15(:,2) = a15(:,2)+lonOff;
a16(:,2) = a16(:,2)+lonOff;
a17(:,2) = a17(:,2)+lonOff;
a18(:,2) = a18(:,2)+lonOff;
a19(:,2) = a19(:,2)+lonOff;


altScale = 3.19; %-122.112061  - a11(1,2);
a1(:,3)  = a1(:,3) * altScale;
a2(:,3)  = a2(:,3) * altScale;
a3(:,3)  = a3(:,3) * altScale;
a4(:,3)  = a4(:,3) * altScale;
a5(:,3)  = a5(:,3) * altScale;
a6(:,3)  = a6(:,3) * altScale;
a7(:,3)  = a7(:,3) * altScale;
a8(:,3)  = a8(:,3) * altScale;
a9(:,3)  = a9(:,3) * altScale;
a10(:,3) = a10(:,3)* altScale;
a11(:,3) = a11(:,3)* altScale;
a12(:,3) = a12(:,3)* altScale;
a13(:,3) = a13(:,3)* altScale;
a14(:,3) = a14(:,3)* altScale;
a15(:,3) = a15(:,3)* altScale;
a16(:,3) = a16(:,3)* altScale;
a17(:,3) = a17(:,3)* altScale;
a18(:,3) = a18(:,3)* altScale;
a19(:,3) = a19(:,3)* altScale;

hdgOff = 0; %330 - a11(1,6);
a1(:,6)  = a1(:,6) +hdgOff;
a2(:,6)  = a2(:,6) +hdgOff;
a3(:,6)  = a3(:,6) +hdgOff;
a4(:,6)  = a4(:,6) +hdgOff;
a5(:,6)  = a5(:,6) +hdgOff;
a6(:,6)  = a6(:,6) +hdgOff;
a7(:,6)  = a7(:,6) +hdgOff;
a8(:,6)  = a8(:,6) +hdgOff;
a9(:,6)  = a9(:,6) +hdgOff;
a10(:,6) = a10(:,6)+hdgOff;
a11(:,6) = a11(:,6)+hdgOff;
a12(:,6) = a12(:,6)+hdgOff;
a13(:,6) = a13(:,6)+hdgOff;
a14(:,6) = a14(:,6)+hdgOff;
a15(:,6) = a15(:,6)+hdgOff;
a16(:,6) = a16(:,6)+hdgOff;
a17(:,6) = a17(:,6)+hdgOff;
a18(:,6) = a18(:,6)+hdgOff;
a19(:,6) = a19(:,6)+hdgOff;

N  = [size(a1 ,1) ...
      size(a2 ,1) ...
      size(a3 ,1) ...
      size(a4 ,1) ...
      size(a5 ,1) ...
      size(a6 ,1) ...
      size(a7 ,1) ...
      size(a8 ,1) ...
      size(a9 ,1) ...
      size(a10,1) ...
      size(a11,1) ...
      size(a12,1) ...
      size(a13,1) ...
      size(a14,1) ...
      size(a15,1) ...
      size(a16,1) ...
      size(a17,1) ...
      size(a18,1) ...
      size(a19,1) ...
];
Nmax = max(N);
A = zeros(19,Nmax,size(a1,2));
A( 1,1:N(1) ,:) = a1;
A( 2,1:N(2) ,:) = a2;
A( 3,1:N(3) ,:) = a3;
A( 4,1:N(4) ,:) = a4;
A( 5,1:N(5) ,:) = a5;
A( 6,1:N(6) ,:) = a6;
A( 7,1:N(7) ,:) = a7;
A( 8,1:N(8) ,:) = a8;
A( 9,1:N(9) ,:) = a9;
A(10,1:N(10),:) = a10;
A(11,1:N(11),:) = a11;
A(12,1:N(12),:) = a12;
A(13,1:N(13),:) = a13;
A(14,1:N(14),:) = a14;
A(15,1:N(15),:) = a15;
A(16,1:N(16),:) = a16;
A(17,1:N(17),:) = a17;
A(18,1:N(18),:) = a18;
A(19,1:N(19),:) = a19;

%%
list = [3 5];
ownship = 1;
Nmax = max(N(list));
while 1
    for i=1:min(8000,Nmax)
        for j=1:length(list)
            %% UDaP data for aircraft in list
            if (i<N(list(j))-100)
%                 if (mod(i,100)==0)
%                     ID = 'WAYPOINT';
%                     d = genAircraftLocationByteArray( ...
%                         ID, ...
%                         A(ownship,i+100,1), ...
%                         A(ownship,i+100,2), ...
%                         A(ownship,i+100,3), ...
%                         A(ownship,i+100,4), ...
%                         A(ownship,i+100,5), ...
%                         A(ownship,i+100,6), ...
%                         0,0);
%                     fwrite(uXPLANE, d, 'uint8');
%                 end
                if (list(j) == ownship)
                    oFlag = 1;
                    type = 0;
                else
                    oFlag = 0;
                    type = mod(list(j),2)+1;
                end
                ID = sprintf('N8%02dRE',list(j));
                d = genAircraftLocationByteArray( ...
                    ID, ...
                    A(list(j),i,1), ...
                    A(list(j),i,2), ...
                    A(list(j),i,3), ...
                    A(list(j),i,4), ...
                    A(list(j),i,5), ...
                    A(list(j),i,6), ...
                    oFlag,type);
                fwrite(uXPLANE, d, 'uint8');
                pause(0.1)
                %fwrite(uAPM, d, 'uint8');
            end
        end
        disp(sprintf('Frame %d/%d',i,Nmax))
        %pause(0.25)
    end
end

%%
%a1  = getFlightDataforXPlane('Deployment 19\\R3_Flight_41_2012-07-16 09-48-10_mavLink.mat');
a1  = getFlightDataforXPlane('R2 Deployment 23\\R2_Flight 50\\R2_Flight_50_2013-04-09 09-35-09_mavLink.mat');
%%
a2  = getFlightDataforXPlane('Deployment 19\\R3_Flight_42_2012-07-16 12-03-54_mavLink.mat');
a3  = getFlightDataforXPlane('Deployment 19\\R3_Flight_43_2012-07-16 12-51-44_mavLink.mat');
a4  = getFlightDataforXPlane('Deployment 21\\R2_Flight_43_2012-08-08 10-46-40_mavLink.mat');
a5  = getFlightDataforXPlane('Deployment 21\\R2_Flight_44_2012-08-08 12-41-26_mavLink.mat');
a6  = getFlightDataforXPlane('Deployment 21\\R2_Flight_45_2012-08-08 01-49-30_mavLink.mat');
a7  = getFlightDataforXPlane('Deployment 18\\Flight-39_2012-05-31 10-14-52_mavLink.mat');
a8  = getFlightDataforXPlane('Deployment 18\\Flight_40B_2012-05-31 12-19-57_mavLink.mat');
a9  = getFlightDataforXPlane('Deployment 17\\Flight_32_2012-05-17 09-57-24_mavLink.mat');
a10 = getFlightDataforXPlane('Deployment 17\\Flight_33_2012-05-17 10-55-46_mavLink.mat');
a11 = getFlightDataforXPlane('Deployment 17\\Flight_34_2012-05-17 11-37-55_mavLink.mat');
a12 = getFlightDataforXPlane('Deployment 17\\Flight_35_2012-05-17 12-58-32_mavLink.mat');
a13 = getFlightDataforXPlane('Deployment 17\\Flight_36_2012-05-17 01-32-47_mavLink.mat');
a14 = getFlightDataforXPlane('Deployment 17\\Flight_37_2012-05-17 02-05-16_mavLink.mat');
a15 = getFlightDataforXPlane('Deployment 17\\Flight_38_2012-05-17 02-39-49_mavLink.mat');
a16 = getFlightDataforXPlane('Deployment 16\\Flight_28_mavLink.mat');
a17 = getFlightDataforXPlane('Deployment 16\\Flight_29_mavLink.mat');
a18 = getFlightDataforXPlane('Deployment 16\\Flight_30_mavLink.mat');
a19 = getFlightDataforXPlane('Deployment 16\\Flight_31_mavLink.mat');

%%
save('XPlane_Data.mat','a1','a2','a3','a4','a5','a6','a7','a8','a9','a10','a11','a12','a13','a14','a15','a16','a17','a18','a19');
