s=tf('s');

A=[0 6;-1 -5];

X=zpk(inv(s*eye(2)-A))

[num_X11,den_X11]=tfdata(X(1,1),'v');
[r11,p11]=residue(num_X11,den_X11)
[num_X12,den_X12]=tfdata(X(1,2),'v');
[r12,p12]=residue(num_X12,den_X12)
[num_X21,den_X21]=tfdata(X(2,1),'v');
[r21,p21]=residue(num_X21,den_X21)
[num_X22,den_X22]=tfdata(X(2,2),'v');
[r22,p22]=residue(num_X22,den_X22)