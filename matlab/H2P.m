function [P,s]=H2P(H,K)
Rt = inv(K)*H;
n = norm(Rt(:,1));
Rt = Rt/n;
...
P = K*[r1 r2 r3 t];
P = P/P(3,4);
end