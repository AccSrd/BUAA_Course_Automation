s=tf('s');

G=-0.3/(s^2+1.75*s+0.37);
C_SS=-1.5/s;
L1=G*C_SS;
M_S_LF=-20;

Tp=0.42;
Sp=2.68;
wc=1;

figure(1)
nichols(L1,'b'),hold on
t_grid(Tp)
s_grid(Sp)
s_grid(M_S_LF)

wn=1.4;
wz=wc/wn;
C_Z=(1+s/wz)^2;
L2=C_Z*L1;
figure(1)
nichols(L2,'r')

K=10^(3/20);
L3=K*L2;
figure(1)
nichols(L3,'k')

wp=10;
C_P=1/(1+s/wp);
L4=C_P*L3;
figure(1)
nichols(L4,'m')


