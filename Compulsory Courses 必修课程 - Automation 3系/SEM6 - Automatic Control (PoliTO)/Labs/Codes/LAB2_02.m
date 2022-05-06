A=[-2 0 0;0 0 1;0 0 0];
eig(A)
s=tf('s');
X=minreal(zpk(inv(s*eye(3)-A)))