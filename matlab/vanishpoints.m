function [v, w] = vanishpoints(corners)

p1 = [corners(:,1);1];
p2 = [corners(:,2);1];
p3 = [corners(:,3);1];
p4 = [corners(:,4);1];

d1 = cross(p1,p2);
d2 = cross(p3,p4);
d3 = cross(p1,p4);
d4 = cross(p2,p3);


v = cross(d1, d2);
w = cross(d3, d4);
v = v(1:2) / v(3);
w = w(1:2) / w(3);

for i = 1:4
    line([v(1);corners(1,i)],[v(2);corners(2,i)]);
    line([w(1);corners(1,i)],[w(2);corners(2,i)]);
end