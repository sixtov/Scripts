N = size(pc104.data,1);            % Number of logged strings with number to skip until
time = [];

q0 =    [];
q1 =    [];
q2 =    [];
q3 =    [];

psi =   [];
theta = [];
phi =   [];


for i = 1:N;
    [q0 q1 q2 q3 m1 m2 m3 a1 a2 a3 r1 r2 r3] = parse_vnqmr(char(pc104.data(i,51:200)));
    ltime = pc104.data(i,201);
    if ~isempty(q0)
        [lpsi ltheta lphi] = quat2euler3([q0 q1 q2 q3]);
        time  = [time; ltime];
        psi = [psi; lpsi];
        theta = [theta; ltheta];
        phi = [phi; lphi];
    end
end
