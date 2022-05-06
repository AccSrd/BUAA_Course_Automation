s=tf('s');

x0=[0;0];
U=[0;2];

A=[0 1;-1 -1];
B=[4 0;10 1];
C=[1 0];
D=0;

Y=zpk(minreal(C*inv(s*eye(2)-A)*(B*U+x0),1e-3));
[num_Y,den_Y]=tfdata(Y,'v');
[r,p]=residue(num_Y,den_Y)

M=abs(r(1));
2*M
phi=angle(r(1))
