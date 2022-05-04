%1.2
b = [3 10 3];
a = [3];
zplane(b,a)

%1.3
b1 = [3 11 19/3 1];
a1 = [1 3];
figure(1)
zplane(b1,a1)
figure(2)
[H,w] = freqz(b1,a1,'whole');
subplot(3,1,1)
plot(w/pi,abs(H));
title('幅值');
xlabel('\omega/\pi');
ylabel('|H(e^j^\omega)|');
grid on
subplot(3,1,2)
plot(w/pi,angle(H));
title('相位');
xlabel('\omega/\pi');
ylabel('\phi(\omega)')
grid on;
subplot(3,1,3)
grpdelay(b1,a1)
b1 = [1/3 1];
a1 = [1 1/3];
figure(1)
zplane(b1,a1)
figure(2)
[H,w] = freqz(b1,a1,'whole');
subplot(3,1,1)
plot(w/pi,abs(H));
title('幅值');
xlabel('\omega/\pi');
ylabel('|H(e^j^\omega)|');
grid on
subplot(3,1,2)
plot(w/pi,angle(H));
title('相位');
xlabel('\omega/\pi');
ylabel('\phi(\omega)')
grid on;
subplot(3,1,3)
grpdelay(b1,a1)

%1.4
b1 = [3 11 19/3 1];
a1 = [1 3];
b2 = [1/3 1];
a2 = [1 1/3];
b = conv(b1,b2);
a = conv(a1,a2);
impz(b,a)

%2.1
b1 = [1 1];
a1 = [4 -2];
b2 = [0.0445 -0.132 0.3703 -0.5103 1];
a2 = [1 -0.5103 0.3703 -0.132 0.0445];
figure(1)
zplane(b1,a1)
figure(2)
[H,w] = freqz(b1,a1);
subplot(3,1,1)
plot(w/pi,abs(H));
title('幅值');
xlabel('\omega/\pi');
ylabel('|H(e^j^\omega)|');
grid on
subplot(3,1,2)
plot(w/pi,angle(H));
title('相位');
xlabel('\omega/\pi');
ylabel('\phi(\omega)')
grid on;
subplot(3,1,3)
grpdelay(b1,a1)
figure(1)
zplane(b2,a2)
figure(2)
[H,w] = freqz(b2,a2);
subplot(3,1,1)
plot(w/pi,abs(H));
title('幅值');
xlabel('\omega/\pi');
ylabel('|H(e^j^\omega)|');
grid on
subplot(3,1,2)
plot(w/pi,angle(H));
title('相位');
xlabel('\omega/\pi');
ylabel('\phi(\omega)')
grid on;
subplot(3,1,3)
grpdelay(b2,a2)
b = conv(b1,b2);
a = conv(a1,a2);
figure(1)
zplane(b,a)
figure(2)
[H,w] = freqz(b,a);
subplot(3,1,1)
plot(w/pi,abs(H));
title('幅值');
xlabel('\omega/\pi');
ylabel('|H(e^j^\omega)|');
grid on
subplot(3,1,2)
plot(w/pi,angle(H));
title('相位');
xlabel('\omega/\pi');
ylabel('\phi(\omega)')
grid on;
subplot(3,1,3)
grpdelay(b,a)

%3
A = importdata('newaudio_44100_4s.mat')
figure(1)
plot(A)
xlabel('t');
ylabel('幅值');
AA = A(45000:125000,:);
figure(2)
h=[1,zeros(1,7999),0.32,zeros(1,15999),0.2];
y = conv(h,AA);
plot(y)
xlabel('t');
ylabel('幅值');
b = [1];
a = [1,zeros(1,7999),0.32,zeros(1,15999),0.2];
n = [0:1000000]';
K = impz(b,a,n);
A = conv(y,K);
figure(3)
plot(A)