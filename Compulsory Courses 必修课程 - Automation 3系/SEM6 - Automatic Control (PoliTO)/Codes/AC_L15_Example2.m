s=tf('s');
G=(s+1)/(s^2*(s-1));
C_SS=10;

T_p=2.67;
S_p=4.35;
wc=18;

L1=C_SS*G;
figure(1)
nichols(L1,'b')
hold on
t_grid(T_p)
s_grid(S_p)
axis([-360 -90 -80 100])

md=16;
wd=18/6;

C_D=(1+s/wd)/(1+s/(md*wd));
L2=C_D*L1;
figure(1)
nichols(L2,'r')

K1=10^(17/20);
L3=K1*L2;
figure(1)
nichols(L3,'k')
C=K1*C_D*C_SS;
zpk(C)

r_s=1;
rho=1;
da=0;
dy=0;
t_stop=5;
sim('AC_L15_sim2')
figure
plot(r.time,r.data,'r','linewidth',1.5)
grid on
hold on
plot(y.time,y.data,'b','linewidth',1.5)
xlabel('t')
ylabel('y(t)')
legend('r(t)','y(t)')

r_s=1;
rho=0;
da=1;
dy=0;
t_stop=50;
sim('AC_L15_sim2')
figure
grid on
hold on
plot(y.time,y.data,'b','linewidth',1.5)
xlabel('t')
ylabel('y(t)')
