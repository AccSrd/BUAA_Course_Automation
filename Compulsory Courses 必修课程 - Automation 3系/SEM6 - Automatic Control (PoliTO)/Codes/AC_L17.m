s=tf('s');

G=0.045/(s^2+2.6*s+1.2);

Kc=34;
C_SS=Kc/s;
L1=G*C_SS;

Tp=0.42;
Sp=2.68;
wc=1;

figure(1)
nichols(L1,'b')
hold on
t_grid(Tp)
s_grid(Sp)

wnorm=1.8;
wz=wc/wnorm;
C_Z=(1+s/wz);
L2=C_Z*L1;
nichols(L2,'r')