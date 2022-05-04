%1
A = importdata('LeadBK-1.txt');
time = 0:2000;
time = 1E-3*time;
figure(1)
subplot(2,1,1);plot(A);
title('¶ÏÇ¦Éù·¢ÉäÐÅºÅx[n]');xlabel('n');ylabel('x[n]');axis([0,2000, -1,1])
subplot(2,1,2);plot(time,A);
title('¶ÏÇ¦Éù·¢ÉäÐÅºÅx(t)');xlabel('t/ms');ylabel('µçÑ¹/V');axis([0,2, -1,1])

%2
tic
x1 = my_dft(A,2000);
toc
max = my_findmax(abs(x1))
figure(1)
N = 2000;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,1);plot(A);
title('¶ÏÇ¦Éù·¢ÉäÐÅºÅx[n]');xlabel('n');ylabel('x[n]');axis([0,2000, -1,1])
subplot(3,1,2);plot(wk,abs(x1));
title('ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('|X_{DFT}(k)|');
subplot(3,1,3);plot(wk,20*log10(abs(x1)));
title('·Ö±´ÐÎÊ½ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('20log|X_{DFT}(k)|');

%3
A_0 = [A,zeros(1,47)];
tic
Xfft = fft(A_0,2048);
toc
max = my_findmax(abs(Xfft))
figure(1)
N = 2048;
k = 0:N-1;wk = 2*k/N;
subplot(3,1,1);plot(A_0);
title('¶ÏÇ¦Éù·¢ÉäÐÅºÅx[n]');xlabel('n');ylabel('x[n]');axis([0,2047, -1,1])
subplot(3,1,2);plot(wk,abs(Xfft));
title('ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('|X_{FFT}(k)|');
subplot(3,1,3);plot(wk,20*log10(abs(Xfft)));
title('·Ö±´ÐÎÊ½ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('20log|X_{FFT}(k)|');

%4
Fs = 1E6;
N = 2048;k = 0:N-1;x = Fs*k/N;
figure(1)
subplot(3,1,1);plot(A_0);
title('¶ÏÇ¦Éù·¢ÉäÐÅºÅx[n]');xlabel('n');ylabel('x[n]');axis([0,2047, -1,1])
subplot(3,1,2);plot(x,abs(Xfft));
title('ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('|X_{FFT}(k)|');
subplot(3,1,3);plot(x,20*log10(abs(Xfft)));
title('·Ö±´ÐÎÊ½ÐÅºÅ·ùÆµÌØÐÔ');xlabel('\omega/\pi');ylabel('20log|X_{FFT}(k)|');