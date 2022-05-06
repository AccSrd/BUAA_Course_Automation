R1=68;
L1=10E-3;
C1=4E-6;

A=[-R1/L1 -1/L1;1/C1 0];
B=[1/L1;0];
C=[0 1];
D=0;

x0=[0;0];

lambda=eig(A);
tau=1./abs(real(lambda));

T_stop=0.003;
Min_step=0.000003;
Max_step=0.00003;

sim('Example_1');

figure
plot(x_1.time,x_1.data,'b','linewidth',2)
grid on
xlabel('t(s)'),ylabel('i_L(A)')
figure
plot(x_2.time,x_2.data,'b','linewidth',2)
grid on
hold on
plot(u.time,u.data,'r','linewidth',2)
xlabel('t(s)'),ylabel('v_C(V)')

