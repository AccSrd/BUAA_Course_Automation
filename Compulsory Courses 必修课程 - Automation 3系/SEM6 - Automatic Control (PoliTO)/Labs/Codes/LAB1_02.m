s=tf('s');

U=2/s;
x0=[2;2];

A=[1 2;4 3];
B=[5;8];
C=[-1 3];
D=8;

X=zpk(minreal(inv(s*eye(2)-A)*(B*U+x0),1e-3));
[num_X1,den_X1]=tfdata(X(1),'v');
[num_X2,den_X2]=tfdata(X(2),'v');
[r1,p1]=residue(num_X1,den_X1)
[r2,p2]=residue(num_X2,den_X2)

Y=zpk(minreal(C*inv(s*eye(2)-A)*(B*U+x0)+D*U,1e-3));
[num_Y,den_Y]=tfdata(Y,'v');
[r,p]=residue(num_Y,den_Y)
