A=[-1 2;1 0];
B=[2;0];
C=[0.5 -0.5];
D=0;

eig(A)

sys=ss(A,B,C,D);
H=minreal(zpk(tf(sys)))