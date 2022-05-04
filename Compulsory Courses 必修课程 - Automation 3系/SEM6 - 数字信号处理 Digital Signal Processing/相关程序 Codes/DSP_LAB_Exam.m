%% 1.1 ############################################
fs = 360;
T = 5;
n = 0:fs*T-1;
time = (1/360)*n';
formatSpec = '%f';
sizeA = [fs*T 1];
fileID = fopen('Ecg360.txt','r');
data = fscanf(fileID,formatSpec,sizeA);
figure('Name','ECGԭʼ�ź�','IntegerHandle','off')
subplot(2,1,1);plot(data);
title('�ĵ��ź�x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.7,1])
subplot(2,1,2);plot(time,data);
title('�ĵ��ź�x(t)');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.7,1])

%% 1.2 ############################################
ep = 0.2;           %�����ź�����
RAND = ep*(rand(1,length(n))-0.5);
y = 0.2*sin(2*pi*50*time);    %��Ƶ����
figure('Name','��������','IntegerHandle','off')
subplot(2,1,1);stem(n,RAND);
grid on;xlabel('n');ylabel('z[n]');title('���Ȱ���������z[n]');axis([0,360, -0.1,0.1])
subplot(2,1,2);plot(time,y);
grid on;xlabel('n');ylabel('s[n]');title('��Ƶ��������s[n]');axis([0,1, -0.2,0.2])

ECG = data+RAND'+y;
figure('Name','������ǰ��ECG�źŶԱ�','IntegerHandle','off')
subplot(3,1,1);plot(data);
title('�ĵ��ź�x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])
subplot(3,1,2);plot(RAND'+y);
title('�����ź�N[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])
subplot(3,1,3);plot(ECG);
title('�����������ĵ��ź�x[n]');xlabel('n');ylabel('x[n]');axis([0,fs*T, -0.9,1.2])

figure('Name','�ź�DFT��Ƶ����','IntegerHandle','off')
xk = fft(ECG,1800);N = 1800;
k = 0:N-1;
xk(1) = 0;
subplot(2,1,1);stem(k,abs(xk),'.');
title('�ź�DFT��Ƶ����');xlabel('k');ylabel('|X_{DFT}[k]|');
subplot(2,1,2);stem(k,20*log10(abs(xk)),'.');
title('�ֱ���ʽDFT�źŷ�Ƶ����');xlabel('k');ylabel('20log|X_{DFT}[k]|');

figure('Name','�ź�DTFT��Ƶ����','IntegerHandle','off')
xk = fft(ECG,1800);N = 1800;
k = 0:N-1;wk = 2*k/N;
xk(1) = 0;
subplot(2,1,1);plot(wk,abs(xk));
title('�ź�DTFT��Ƶ����');xlabel('\omega/\pi');ylabel('|X(e^{j\omega})|');axis([0,2,0,185])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('�ֱ���ʽDTFT�źŷ�Ƶ����');xlabel('\omega/\pi');ylabel('20log|X(e^{j\omega})|');axis([0,2,-30,50])

figure('Name','�ź�CTFT��Ƶ����','IntegerHandle','off')
wk = fs*k/N;
subplot(2,1,1);plot(wk,abs(xk));
title('�ź�CTFT��Ƶ����');xlabel('f/Hz');ylabel('|X(e^{j\omega})|');axis([0,360,0,185])
subplot(2,1,2);plot(wk,20*log10(abs(xk)));
title('�ֱ���ʽCTFT�źŷ�Ƶ����');xlabel('f/Hz');ylabel('20log|X(e^{j\omega})|');axis([0,360,-30,50])

%% 2.1 ############################################
alpha_s = 40;
beta = 0.5842*(alpha_s-21)^0.4 + 0.07886*(alpha_s-21);
L = ceil((alpha_s-8)/(2.285*0.1*pi));
wn = kaiser(L,beta);

figure('Name','Kaiser���������������','IntegerHandle','off')
subplot(2,1,1);stem(0:L-1,wn,'.');
title('Kaiser������');xlabel('n');ylabel('w[n]');axis([-1,45,0,1])
N = 1800;
k = 0:N-1;wk = 2*k/N;
Hk = fft(wn,N);
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('Kaiser������������');xlabel('\omega/\pi');ylabel('20log|W(e^{j\omega})|');

%% 2.2 ############################################
n = 0:L-1;
fc = 45;
wc = 0.2*pi;
tao = (L-1)/2;
hd = sin((n-tao)*wc)/pi./(n-tao);
hd((L+1)/2) = wc/pi;

figure('Name','��λ������Ӧ','IntegerHandle','off')
subplot(2,1,1);stem(0:44,hd,'.');
title('���������˲�����λ������Ӧh_d[n]');xlabel('n');ylabel('h_d[n]');axis([-1,45, -0.1,0.3])
hn = hd.*wn';
subplot(2,1,2);stem(0:44,hn,'.');
title('FIR�����˲�����λ������Ӧh[n]');xlabel('n');ylabel('h[n]');axis([-1,45, -0.1,0.3])

figure('Name','�����˲����㼫��ͼ','IntegerHandle','off')
zplane(hn,1)

figure('Name','�����˲�����Ƶ����','IntegerHandle','off')
Hk = fft(hn,N);
k = 0:N-1;wk = 2*k/N;
Hk(1) = 0;
subplot(2,1,1);plot(wk,abs(Hk));
title('�����˲�����Ƶ����');xlabel('\omega/\pi');ylabel('|H(e^{j\omega})|');
subplot(2,1,2);plot(wk,20*log10(abs(Hk)));
title('�ֱ���ʽ�����˲�����Ƶ����');xlabel('\omega/\pi');ylabel('20log|H(e^{j\omega})|');

figure('Name','��λ��Ӧ��Ⱥ�ӳ�','IntegerHandle','off')
subplot(2,1,1);freqz(hn,1);
subplot(2,1,1);grpdelay(hn,1)

%% 3.1 ############################################
L = length(ECG)+length(hn)-1;
k = 0:L-1;wk = 2*k/L;
time_new = (5*(k/(L-1)))';

yn_0 = conv(hn,ECG);
figure('Name','���Ծ���˲�ǰ��ECG�ź�','IntegerHandle','off')
subplot(2,1,1);plot(time,ECG);
title('�˲�ǰ�ĵ��ź�');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])
subplot(2,1,2);plot(time_new,yn_0);
title('���Ծ���˲����ĵ��ź�');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])

%% 3.2 ############################################ 
XK=fft(ECG,L);
H1=fft(hn,L);
Yk = XK.*H1';
yn = ifft(Yk,L);

figure('Name','ѭ������˲�ǰ��ECG�ź�','IntegerHandle','off')
subplot(2,1,1);plot(time,ECG);
title('�˲�ǰ�ĵ��ź�');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])
subplot(2,1,2);plot(time_new,yn);
title('ѭ������˲����ĵ��ź�');xlabel('t/s');ylabel('x(t)');axis([0,5, -0.9,1.2])

figure('Name','ѭ������˲�ǰ��ECG�ź�DFT������','IntegerHandle','off')
subplot(2,2,1);plot(k,abs(XK));
title('�˲�ǰ�ĵ��ź�DFT��Ƶ����');xlabel('k');ylabel('|X[k]|');axis([0,1844,0,185])
subplot(2,2,3);plot(k,20*log10(abs(XK)));
title('�ֱ���ʽ�˲�ǰ�ĵ��ź�DFT��Ƶ����');xlabel('k');ylabel('20log|X[k]|');axis([0,1844,-20,50])
subplot(2,2,2);plot(k,abs(Yk));
title('�˲����ĵ��ź�DFT��Ƶ����');xlabel('k');ylabel('|X_{f}[k]|');axis([0,1844,0,60])
subplot(2,2,4);plot(k,20*log10(abs(Yk)));
title('�ֱ���ʽ�˲����ĵ��ź�DFT��Ƶ����');xlabel('k');ylabel('20log|X_{f}[k]|');axis([0,1844,-120,50])






