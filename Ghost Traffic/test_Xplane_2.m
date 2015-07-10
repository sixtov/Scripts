%%
a1  = getFlightDataforXPlane('Deployment 19\\R3_Flight_41_2012-07-16 09-48-10_mavLink.mat');
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

%%
%cd('G:\\Flight Data');
load('XPlane_Data.mat');
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
if (exist('u2','var')==1)
    fclose(u2);
    clear u2
end

%%
rPort = 6700;
lPort = 6701;
ip = 'localhost';
%ip = '255.255.255.255';
%u2 = udp('192.168.0.151',...%udp('localhost', ...%u2 = udp('192.168.0.150', ...
u2 = udp(ip,...
         'RemotePort', rPort, ...
         'LocalPort', lPort, ...
         'ByteOrder','bigEndian',...
         'InputBufferSize',1024,...
         'OutputBufferSize',1024);
%%
fopen(u2);

%%
list = [1 3 5];
Nmax = max(N(list));
while 1
    for i=150:6500 %i=1:Nmax
        for j=1:length(list)
            %% UDP data for aircraft in list
            if (i<N(list(j))-100)
                d = genAircraftLocationByteArray( ...
                    sprintf('N8%02dRE',list(j)), ...
                    A(list(j),i,1), ...
                    A(list(j),i,2), ...
                    A(list(j),i,3), ...
                    A(list(j),i,4), ...
                    A(list(j),i,5), ...
                    A(list(j),i,6) ...
                    );
                fwrite(u2, d, 'uint8');
            end
        end
        disp(sprintf('Frame %d/%d',i,Nmax))
        pause(0.1)
    end
end
