s=tf('s');
G=2/((1+0.2*s)*(1+0.1*s));
zpk(G);
C_SS=5/s;
L1=(G*C_SS);

Tp=3.67;
Sp=5.1;
wc_des=7;

figure(1)
nichols(L1,'b'),hold on
t_grid(Tp)
s_grid(Sp)

md=10;
wd=7;
C_D=(1+s/wd)/(1+s/(md*wd));
L2=C_D*L1;
C=C_SS*C_D;
zpk(C);
figure(1)
nichols(L2,'r')

r_s=1;
t_stop=3;
da=0;
dy=0;
sim('AC_L15_sim')
figure
plot(r.time,r.data,'r','linewidth',1.5)
grid on
hold on
plot(y.time,y.data,'b','linewidth',1.5)
xlabel('t (s)')
ylabel('y(t)')
legend('r(t)','y(t)')

r_s=-1;
t_stop=3;
da=0;
dy=0;
sim('AC_L15_sim')
figure
plot(r.time,r.data,'r','linewidth',1.5)
grid on
hold on
plot(y.time,y.data,'b','linewidth',1.5)
xlabel('t (s)')
ylabel('y(t)')
legend('r(t)','y(t)')
figure
plot(e.time,e.data,'b','linewidth',1.5)
grid on
xlabel('t(s)')
ylabel('e(t)')