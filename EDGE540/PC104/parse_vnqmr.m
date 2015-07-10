function [q0 q1 q2 q3 m1 m2 m3 a1 a2 a3 r1 r2 r3] = parse_vnqmr(inchars)

q0 = [];
q1 = [];
q2 = [];
q3 = [];
m1 = [];
m2 = [];
m3 = [];
a1 = [];
a2 = [];
a3 = [];
r1 = [];
r2 = [];
r3 = [];

hdridx = findstr('$VNQMR',inchars);
if isempty(hdridx)
     return
end

inchars(hdridx+6+1:length(inchars));
%length(inchars)
char(inchars((hdridx+6+1:hdridx+6+1+113)));
dbls = str2num(inchars((hdridx+6+1:hdridx+6+1+113)));
q0 = dbls(1);
q1 = dbls(2);
q2 = dbls(3);
q3 = dbls(4);
m1 = dbls(5);
m2 = dbls(6);
m3 = dbls(7);
a1 = dbls(8);
a2 = dbls(9);
a3 = dbls(10);
r1 = dbls(11);
r2 = dbls(12);
r3 = dbls(13);

