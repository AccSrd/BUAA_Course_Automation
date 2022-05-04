%1
% x1 = [1 1 1 1];
% x11k = my_dft(x1,8);
% x12k = my_dft(x1,32);
% x21k = fft(x1,8);
% x22k = fft(x1,32);
% figure(1)
% N = 8;
% k = 0:N-1;wk = 2*k/N;
% subplot(2,2,1);stem(wk,abs(x11k),'.');
% title('x11k��Ƶ����');xlabel('\omega/\pi');ylabel('����');
% subplot(2,2,3);stem(wk,angle(x11k),'.');
% title('x11k��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
% N = 32;
% k = 0:N-1;wk = 2*k/N;
% subplot(2,2,2);stem(wk,abs(x12k),'.');
% title('x12k��Ƶ����');xlabel('\omega/\pi');ylabel('����');
% subplot(2,2,4);stem(wk,angle(x12k),'.');
% title('x12k��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
% figure(2)
% N = 8;
% k = 0:N-1;wk = 2*k/N;
% subplot(2,2,1);stem(wk,abs(x21k),'.');
% title('x21k��Ƶ����');xlabel('\omega/\pi');ylabel('����');
% subplot(2,2,3);stem(wk,angle(x21k),'.');
% title('x21k��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
% N = 32;
% k = 0:N-1;wk = 2*k/N;
% subplot(2,2,2);stem(wk,abs(x22k),'.');
% title('x22k��Ƶ����');xlabel('\omega/\pi');ylabel('����');
% subplot(2,2,4);stem(wk,angle(x22k),'.');
% title('x22k��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
% figure(3)
% y = [0 1 2 3];
% stem(y,x1);
% title('x1[n]ʱ��ͼ��');xlabel('n');ylabel('x1[n]');axis([-1,4, 0,2]);

%2
x2 = [3 2 1 3 -2 -1 2 4];
N = 2048;
x3k = fft(x2,N);
figure(1)
k = 0:N-1;wk = 2*k/N;
subplot(2,1,1);plot(wk,abs(x3k));grid on;
title('x3k��Ƶ����');xlabel('\omega/\pi');ylabel('����');
subplot(2,1,2);plot(wk,angle(x3k));grid on;
title('x3k��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
x4k = fft(x2,16);
x5k = fft(x2,64);
figure(2)
N = 16;
k = 0:N-1;wk = 2*k/N;
subplot(2,2,1);stem(wk,abs(x4k),'.');
title('x4k��ɢ��Ƶ����');xlabel('\omega/\pi');ylabel('����');
subplot(2,2,3);stem(wk,angle(x4k),'.');
title('x4k��ɢ��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
N = 64;
k = 0:N-1;wk = 2*k/N;
subplot(2,2,2);stem(wk,abs(x5k),'.');
title('x5k��ɢ��Ƶ����');xlabel('\omega/\pi');ylabel('����');
subplot(2,2,4);stem(wk,angle(x5k),'.');
title('x5k��ɢ��Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
figure(3)
N = 16;
k = 0:N-1;wk = 2*k/N;
subplot(2,2,1);plot(wk,abs(x4k));grid on;
title('x4k������Ƶ����');xlabel('\omega/\pi');ylabel('����');
subplot(2,2,3);plot(wk,angle(x4k));grid on;
title('x4k��������');xlabel('\omega/\pi');ylabel('��λ');
N = 64;
k = 0:N-1;wk = 2*k/N;
subplot(2,2,2);plot(wk,abs(x5k));grid on;
title('x5k������Ƶ����');xlabel('\omega/\pi');ylabel('����');
subplot(2,2,4);plot(wk,angle(x5k));grid on;
title('x3k������Ƶ����');xlabel('\omega/\pi');ylabel('��λ');
figure(4)
y = 0:7;
stem(y,x2);
title('x2[n]ʱ��ͼ��');xlabel('n');ylabel('x2[n]');axis([-1,8, -5,5]);

%3.1
x1 = [1 1 1 1];
x1_16 = [x1,zeros(1,12)];
x1_32 = [x1,zeros(1,28)];
x1_128 = [x1,zeros(1,124)];
x16k = fft(x1_16,16);
x32k = fft(x1_32,32);
x128k = fft(x1_128,128);
figure(1)
y = 0:15;
subplot(3,1,1);
stem(y,x1_16,'.');
title('x1_{16}ʱ��ͼ��');xlabel('n');ylabel('x1_{16}[n]');axis([-1,16, 0,2]);
y = 0:31;
subplot(3,1,2);
stem(y,x1_32,'.');
title('x1_{32}ʱ��ͼ��');xlabel('n');ylabel('x1_{32}[n]');axis([-1,32, 0,2]);
y = 0:127;
subplot(3,1,3);
stem(y,x1_128,'.');
title('x1_{128}ʱ��ͼ��');xlabel('n');ylabel('x1_{128}[n]');axis([-1,128, 0,2]);
figure(2)
N = 16;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,1);stem(wk,abs(x16k),'.');
title('xk_{16}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 32;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,2);stem(wk,abs(x32k),'.');
title('xk_{32}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 128;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,3);stem(wk,abs(x128k),'.');
title('xk_{128}��Ƶ����');xlabel('\omega/\pi');ylabel('����');

%3.2
M = 0:7;
x3 = sin((pi/4)*M);
x3_16 = [x3,zeros(1,8)];
x3_32 = [x3,zeros(1,24)];
x3_128 = [x3,zeros(1,120)];
x8k = fft(x3,8);
x16k = fft(x3_16,16);
x32k = fft(x3_32,32);
x128k = fft(x3_128,128);
figure(1)
y = 0:7;
subplot(4,1,1);
stem(y,x3,'.');
title('x3ʱ��ͼ��');xlabel('n');ylabel('x3[n]');axis([-1,8, -1.5,1.5]);
y = 0:15;
subplot(4,1,2);
stem(y,x3_16,'.');
title('x3_{16}ʱ��ͼ��');xlabel('n');ylabel('x3_{16}[n]');axis([-1,16, -1.5,1.5]);
y = 0:31;
subplot(4,1,3);
stem(y,x3_32,'.');
title('x3_{32}ʱ��ͼ��');xlabel('n');ylabel('x3_{32}[n]');axis([-1,32, -1.5,1.5]);
y = 0:127;
subplot(4,1,4);
stem(y,x3_128,'.');
title('x3_{128}ʱ��ͼ��');xlabel('n');ylabel('x3_{128}[n]');axis([-1,128, -1.5,1.5]);
figure(2)
N = 8;
k = 0:N-1;wk = 2*k/N;
subplot(4,1,1);stem(wk,abs(x8k),'.');
title('x3��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 16;
k = 0:N-1;wk = 2*k/N;
subplot(4,1,2);stem(wk,abs(x16k),'.');
title('x3k_{16}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 32;
k = 0:N-1;wk = 2*k/N;
subplot(4,1,3);stem(wk,abs(x32k),'.');
title('x3k_{32}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 128;
k = 0:N-1;wk = 2*k/N;
subplot(4,1,4);stem(wk,abs(x128k),'.');
title('x3k_{128}��Ƶ����');xlabel('\omega/\pi');ylabel('����');

%4.1
N = 0:31;
xss1n = cos((pi/8)*N)+0.75*sin((pi/15)*N);
N = 0:127;
xss2n = cos((pi/8)*N)+0.75*sin((pi/15)*N);
N = 0:511;
xss3n = cos((pi/8)*N)+0.75*sin((pi/15)*N);
xss1k = fft(xss1n,32);
xss2k = fft(xss2n,128);
xss3k = fft(xss3n,512);
figure(1)
N = 32;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,1);plot(wk,abs(xss1k));
title('xk_{32}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 128;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,2);plot(wk,abs(xss2k));
title('xk_{128}��Ƶ����');xlabel('\omega/\pi');ylabel('����');
N = 512;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,3);plot(wk,abs(xss3k));
title('xk_{512}��Ƶ����');xlabel('\omega/\pi');ylabel('����');