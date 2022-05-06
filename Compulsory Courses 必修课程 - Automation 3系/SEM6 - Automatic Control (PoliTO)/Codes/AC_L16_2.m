s=tf('s');

G=(s+0.2)/(s*(s+0.4)*(s+1));
C_SS=20;
L1=C_SS*G;

Tp=0.42;
Sp=2.68;
wc=4;

figure(1)
nichols(L1,'b')
hold on
t_grid(Tp)
s_grid(Sp)

md=12;
wd=4/3;
C_D=(1+s/wd)/(1+s/(md*wd));
L2=C_D*L1;
figure(1)
nichols(L2,'r')

mi=10^(10/20);
alpha=10;
wi=wc/(alpha*mi);
C_I=(1+s/(mi*wi))/(1+s/wi);
L3=C_I*L2;
figure(1)
nichols(L3,'k')
C=C_SS*C_D*C_I;
zpk(G);
zpk(C)

r_s=1;
da=0;
dy=0;
t_stop=10;
sim('AC_L16_sim2')
figure
plot(r.time,r.data,'r')
grid on
hold on
plot(y.time,y.data,'b')

r_s=-1;
t_stop=100;
sim('AC_L16_sim2')
figure
plot(r.time,r.data,'r')
grid on
hold on
plot(y.time,y.data,'b')

figure
plot(e.time,e.data,'b')
grid on

