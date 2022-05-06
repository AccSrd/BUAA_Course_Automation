s=tf('s');

G=2/((0.1*s+1)*(0.2*s+1));

Kc=10;
C_SS=Kc/s;
L1=G*C_SS;

T_p=1.72;
S_p=3.63;
wc=1.9;

figure(1)
nichols(L1,'b')
hold on
t_grid(T_p)
s_grid(S_p)

mi=10^(19.7/20);
alpha=10;
wi=wc/(alpha*mi);
C_I=(1+s/(mi*wi))/(1+s/wi);
L2=L1*C_I;
figure(1)
nichols(L2,'r')
C=C_SS*C_I;
zpk(G);
zpk(C);

rho=1;
da=0;
dy=0;
t_stop=20;
sim('AC_L16_sim1')
figure
plot(r.time,r.data,'r')
grid on
hold on
plot(y.time,y.data,'b')

rho=0;
da=1;
dy=0;
t_stop=1000;
sim('AC_L16_sim1')
figure
plot(y.time,y.data,'b')


