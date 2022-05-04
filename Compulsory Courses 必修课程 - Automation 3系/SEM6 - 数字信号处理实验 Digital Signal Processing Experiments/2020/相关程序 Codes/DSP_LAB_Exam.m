%% 1.1 ############################################
fs = 360;
T = 5;
n = 0:fs*T-1;
time = (1/360)*n';
formatSpec = '%f';
sizeA = [fs*T 1];
fileID = fopen('Ecg360.txt','r');
data = fscanf(fileID,formatSpec,sizeA);
figure('Name','ECG原始信号','IntegerHandle','off')
subplot(2,1,1);plot(data);
title('心电信号x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.7,1])
subplot(2,1,2);plot(time,data);
title('心电信号x(t)');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.7,1])

%% 1.2 ############################################
ep = 0.2;           %噪声信号增益
RAND = ep*(rand(1,length(n))-0.5);
y = 0.2*sin(2*pi*50*time);    %工频噪声
figure('Name','噪声波形','IntegerHandle','off')
subplot(2,1,1);stem(n,RAND);
grid on;xlabel('n');ylabel('z[n]');title('均匀白噪声序列z[n]');axis([0,360, -0.1,0.1])
subplot(2,1,2);plot(time,y);
grid on;xlabel('n');ylabel('s[n]');title('工频干扰序列s[n]');axis([0,1, -0.2,0.2])

ECG = data+RAND'+y;
figure('Name','加噪声前后ECG信号对比','IntegerHandle','off')
subplot(3,1,1);plot(data);
title('心电信号x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])
subplot(3,1,2);plot(RAND'+y);
title('噪声信号N[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])
subplot(3,1,3);plot(ECG);
title('加入噪声后心电信号x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])

figure('Name','信号DFT幅频特性','IntegerHandle','off')
xk = fft(ECG,1800);N = 1800;
k = 0:N-1;
xk(1) = 0;
subplot(2,1,1);stem(k,abs(xk),'.');
title('信号DFT幅频特性');xlabel('k');ylabel('|X_{DFT}[k]|');
subplot(2,1,2);stem(k,20*log10(abs(xk)),'.');
title('分贝形式DFT信号幅频特性');xlabel('k');ylabel('20log|X_{DFT}[k]|');

figure('Name','信号DTFT幅频特性','IntegerHandle','off')
xk = fft(ECG,1800);N = 1800;
k = 0:N-1;wk = 2*k/N;
xk(1) = 0;
subplot(2,1,1);plot(wk,abs(xk));
title('信号DTFT幅频特性');xlabel('\omega/\pi');ylabel('|X(e^{j\omega})|');axis([0,2,0,185])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('分贝形式DTFT信号幅频特性');xlabel('\omega/\pi');ylabel('20log|X(e^{j\omega})|');axis([0,2,-30,50])

figure('Name','信号CTFT幅频特性','IntegerHandle','off')
wk = fs*k/N;
subplot(2,1,1);plot(wk,abs(xk));
title('信号CTFT幅频特性');xlabel('f/Hz');ylabel('|X(e^{j\omega})|');axis([0,360,0,185])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('分贝形式CTFT信号幅频特性');xlabel('f/Hz');ylabel('20log|X(e^{j\omega})|');axis([0,360,-30,50])

%% 2.1 ############################################
alpha_s = 40;
beta = 0.5842*(alpha_s-21)^0.4 + 0.07886*(alpha_s-21);
L = ceil((alpha_s-8)/(2.285*0.1*pi));
wn = kaiser(L,beta);

figure('Name','Kaiser窗函数及其幅度谱','IntegerHandle','off')
subplot(2,1,1);stem(0:L-1,wn,'.');
title('Kaiser窗函数');xlabel('n');ylabel('w[n]');axis([-1,45,0,1])
N = 1800;
k = 0:N-1;wk = 2*k/N;
Hk = fft(wn,N);
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('Kaiser窗函数幅度谱');xlabel('\omega/\pi');ylabel('20log|W(e^{j\omega})|');

%% 2.2 ############################################
n = 0:L-1;
fc = 45;
wc = 0.2*pi;
tao = (L-1)/2;
hd = sin((n-tao)*wc)/pi./(n-tao);
hd((L+1)/2) = wc/pi;

figure('Name','单位脉冲响应','IntegerHandle','off')
subplot(2,1,1);stem(0:44,hd,'.');
title('理想数字滤波器单位脉冲响应h_d[n]');xlabel('n');ylabel('h_d[n]');axis([-1,45, -0.1,0.3])
hn = hd.*wn';
subplot(2,1,2);stem(0:44,hn,'.');
title('FIR数字滤波器单位脉冲响应h[n]');xlabel('n');ylabel('h[n]');axis([-1,45, -0.1,0.3])

figure('Name','数字滤波器零极点图','IntegerHandle','off')
zplane(hn,1)

figure('Name','数字滤波器幅频特性','IntegerHandle','off')
Hk = fft(hn,N);
k = 0:N-1;wk = 2*k/N;
Hk(1) = 0;
subplot(2,1,1);plot(wk,abs(Hk));
title('数字滤波器幅频特性');xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('分贝形式数字滤波器幅频特性');xlabel('\omega/\pi');ylabel('20log|H(e^{j\omega})|');

figure('Name','相位响应与群延迟','IntegerHandle','off')
subplot(2,1,1);freqz(hn,1);
subplot(2,1,1);grpdelay(hn,1)

%% 3.1 ############################################
L = length(ECG)+length(hn)-1;
k = 0:L-1;wk = 2*k/L;
time_new = (5*(k/(L-1)))';

yn_0 = conv(hn,ECG);
figure('Name','线性卷积滤波前后ECG信号','IntegerHandle','off')
subplot(2,1,1);plot(time,ECG);
title('滤波前心电信号');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])
subplot(2,1,2);plot(time_new,yn_0);
title('线性卷积滤波后心电信号');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])

%% 3.2 ############################################ 
XK=fft(ECG,L);
H1=fft(hn,L);
Yk = XK.*H1';
yn = ifft(Yk,L);

figure('Name','循环卷积滤波前后ECG信号','IntegerHandle','off')
subplot(2,1,1);plot(time,ECG);
title('滤波前心电信号');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])
subplot(2,1,2);plot(time_new,yn);
title('循环卷积滤波后心电信号');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])

figure('Name','循环卷积滤波前后ECG信号DFT幅度谱','IntegerHandle','off')
subplot(2,2,1);plot(k,abs(XK));
title('滤波前心电信号DFT幅频特性');xlabel('k');ylabel('|X[k]|');axis([0,1844,0,185])
subplot(2,2,3);plot(k,20*log10(abs(XK)));
title('分贝形式滤波前心电信号DFT幅频特性');xlabel('k');ylabel('20log|X[k]|');axis([0,1844,-20,50])
subplot(2,2,2);plot(k,abs(Yk));
title('滤波后心电信号DFT幅频特性');xlabel('k');ylabel('|X_{f}[k]|');axis([0,1844,0,60])
subplot(2,2,4);plot(k,20*log10(abs(Yk)));
title('分贝形式滤波后心电信号DFT幅频特性');xlabel('k');ylabel('20log|X_{f}[k]|');axis([0,1844,-120,50])






