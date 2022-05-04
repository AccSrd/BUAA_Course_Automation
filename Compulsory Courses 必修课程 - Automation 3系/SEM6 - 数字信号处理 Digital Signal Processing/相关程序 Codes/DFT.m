
xn=[1 1 1 1 1 1 1 1];   %R8(n)
Xk8=fft(xn,8);  
Xk16=fft(xn,16);  
Xk32=fft(xn,32);        
Xk64=fft(xn,64);
Xk128=fft(xn,128);    

k=0:7;wk=2*k/8;       
subplot(5,2,1);stem(wk,abs(Xk8),'.');                        
title('8点DFT的幅频特性图');xlabel('ω/\pi');ylabel('幅度')
subplot(5,2,2);stem(wk,angle(Xk8),'.');               
title('8点DFT的相频特性图');
xlabel('ω/\pi');ylabel('相位');axis([0,2,-3.5,3.5])

k=0:15;wk=2*k/16;       
subplot(5,2,3);stem(wk,abs(Xk16),'.');                        
title('16点DFT的幅频特性图');xlabel('ω/\pi');ylabel('幅度')
subplot(5,2,4);stem(wk,angle(Xk16),'.');               
title('16点DFT的相频特性图');
xlabel('ω/\pi');ylabel('相位');axis([0,2,-3.5,3.5])

k=0:31;wk=2*k/32;       
subplot(5,2,5);stem(wk,abs(Xk32),'.');                        
title('32点DFT的幅频特性图');xlabel('ω/\pi');ylabel('幅度')
subplot(5,2,6);stem(wk,angle(Xk32),'.');               
title('32点DFT的相频特性图');
xlabel('ω/\pi');ylabel('相位');axis([0,2,-3.5,3.5])

k=0:63;wk=2*k/64;       
subplot(5,2,7);stem(wk,abs(Xk64),'.');               
title('64点DFT的幅频特性图');xlabel('ω/\pi');ylabel('幅度')
subplot(5,2,8);stem(wk,angle(Xk64),'.');      
title('64点DFT的相频特性图')
xlabel('ω/\pi');ylabel('相位');axis([0,2,-3.5,3.5])

k=0:127;wk=2*k/128;       
subplot(5,2,9);stem(wk,abs(Xk128),'.');                        
title('128点DFT的幅频特性图');xlabel('ω/\pi');ylabel('幅度')
subplot(5,2,10);stem(wk,angle(Xk128),'.');               
title('128点DFT的相频特性图');
xlabel('ω/\pi');ylabel('相位');axis([0,2,-3.5,3.5])