function [v, w] = vanishpoints(corners)
p1 = [corners(:,1);1];
p2 = [corners(:,2);1];
p3 = [corners(:,3);1];
p4 = [corners(:,4);1];
...
for i = 1:4
    line([v(1);corners(1,i)],[v(2);corners(2,i)]);
    line([w(1);corners(1,i)],[w(2);corners(2,i)]);
end