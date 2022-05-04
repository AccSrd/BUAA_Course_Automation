%1.1
fs = 360;
T = 60;
time = 0:21600-1;
time = (1/360)*time';
formatSpec = '%f';
sizeA = [fs*T 1];
fileID = fopen('Ecginf.txt','r');
data = fscanf(fileID,formatSpec,sizeA);
figure(1)
subplot(2,1,1);plot(data);
title('心电信号x[n]');xlabel('n');ylabel('x[n]');axis([0,21600, -0.85,1.2])
subplot(2,1,2);plot(time,data);
title('心电信号x(t)');xlabel('t/s');ylabel('x(t)');axis([0,60, -0.85,1.2])

%1.2
figure(1)
xk = fft(data,512);
N = 512;
k = 0:N-1;wk = 2*k/N;
xk(1) = 0;
subplot(2,1,1);stem(k,abs(xk),'.');
title('信号DFT幅频特性');xlabel('k');ylabel('|X_{DFT}[k]|');axis([-1,512, 0,50])
subplot(2,1,2);stem(k,20*log10(abs(xk)),'.');
title('分贝形式DFT信号幅频特性');xlabel('k');ylabel('20log|X_{DFT}[k]|');axis([-1,512, -50,65])
figure(2)
xk = fft(data,21600);
N = 21600;
k = 0:N-1;wk = 2*k/N;
xk(1) = 0;
subplot(2,1,1);plot(wk,abs(xk));
title('信号DTFT幅频特性');xlabel('\omega/\pi');ylabel('|X(e^{j\omega})|');axis([0,2, 0,2000])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('分贝形式DTFT信号幅频特性');xlabel('\omega/\pi');ylabel('20log|X(e^{j\omega})|');
figure(3)
wk = fs*k/N;
subplot(2,1,1);plot(wk,abs(xk));
title('信号CTFT幅频特性');xlabel('f/Hz');ylabel('|X(e^{j\omega})|');axis([0,360, 0,2000])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('分贝形式CTFT信号幅频特性');xlabel('f/Hz');ylabel('20log|X(e^{j\omega})|');axis([0,360, -50,65])

%2.1
fs = 360;
N = 67;
hmn = 0:N-1;
whn = (0.54-0.46*cos(2*pi*hmn/(N-1)));
figure(1)
subplot(2,1,1);stem(0:66,whn,'.');axis([-1,67, 0,1])
title('Hamming窗函数');xlabel('n');ylabel('w[n]');
N = 21600;
k = 0:N-1;wk = 2*k/N;
Hk = fft(whn,N);
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('Hamming窗函数幅度谱');xlabel('\omega/\pi');ylabel('20log|W(e^{j\omega})|');

%2.2
fs = 360;
N = 67;
n = 0:N-1;
fc = 45;
wc = 2*pi*fc/fs;
tao = (N-1)/2;
hd = sin((n-tao)*wc)/pi./(n-tao);
hd((N+1)/2) = wc/pi;
figure(1)
subplot(2,1,1);stem(hd,'.');
title('理想数字滤波器单位脉冲响应h_d[n]');xlabel('n');ylabel('h_d[n]');axis([-1,67, -0.1,0.3])
hn = hd.*whn;
subplot(2,1,2);stem(hn,'.');
title('FIR数字滤波器单位脉冲响应h[n]');xlabel('n');ylabel('h[n]');axis([-1,67, -0.1,0.3])
figure(2)
Hk = fft(hn,N);
k = 0:N-1;wk = 2*k/N;
Hk(1) = 0;
subplot(2,1,1);plot(wk,abs(Hk));
title('数字滤波器幅频特性');xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('分贝形式数字滤波器幅频特性');xlabel('\omega/\pi');ylabel('20log|H(e^{j\omega})|');



%3
N=21600;
k = 0:N-1;wk = 2*k/N;
time = 0:21600-1;
time = (1/360)*time';
XK=fft(data,N);
H1=fft(hn,N); 
Yk = XK.*H1';
yn = ifft(Yk,N);
figure(1)
XK(1) = 0;
subplot(2,2,1);plot(k,abs(XK));
title('滤波前心电信号DFT幅频特性');xlabel('k');ylabel('|X[k]|');
subplot(2,2,3);plot(k,20*log10(abs(XK)));
title('分贝形式滤波前心电信号DFT幅频特性');xlabel('k');ylabel('20log|X[k]|');
Yk(1) = 0;
subplot(2,2,2);plot(k,abs(Yk));
title('滤波后心电信号DFT幅频特性');xlabel('k');ylabel('|X_{f}[k]|');
subplot(2,2,4);plot(k,20*log10(abs(Yk)));
title('分贝形式滤波后心电信号DFT幅频特性');xlabel('k');ylabel('20log|X_{f}[k]|');
figure(2)
subplot(2,1,1);plot(time,data);
title('滤波前心电信号');xlabel('t/s');ylabel('x(t)');axis([0,60, -0.85,1.2])
subplot(2,1,2);plot(time,yn);
title('滤波后心电信号');xlabel('t/s');ylabel('x(t)');axis([0,60, -0.85,1.2])

