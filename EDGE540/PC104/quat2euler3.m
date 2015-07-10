function [psi,theta,phi] = quat2euler(quat)
% This block supports the Embedded MATLAB subset.
% This uses the algorithm from page 2 of the
% VectorNav AN002 application note.

q0 = quat(:,1);
q1 = quat(:,2);
q2 = quat(:,3);
q3 = quat(:,4);

% Yaw angle

psi = (180/pi)*atan2( (2*( q0.*q1 + q3.*q2 )),(q3.*q3 - q2.*q2 - q1.*q1 - q0.*q0) );

% Pitch angle

theta = asind( -2*( q0.*q2 - q1.*q3 ) );

% Roll angle

phi = (180/pi)*atan2((2*( q1.*q2 + q0.*q3 )),(q3.*q3 + q2.*q2 - q1.*q1 - q0.*q0) );