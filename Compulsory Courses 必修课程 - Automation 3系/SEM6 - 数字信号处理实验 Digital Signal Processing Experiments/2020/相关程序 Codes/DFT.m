
xn=[1 1 1 1 1 1 1 1];   %R8(n)
Xk8=fft(xn,8);  
Xk16=fft(xn,16);  
Xk32=fft(xn,32);        
Xk64=fft(xn,64);
Xk128=fft(xn,128);    

k=0:7;wk=2*k/8;       
subplot(5,2,1);stem(wk,abs(Xk8),'.');                        
title('8��DFT�ķ�Ƶ����ͼ');xlabel('��/\pi');ylabel('����')
subplot(5,2,2);stem(wk,angle(Xk8),'.');               
title('8��DFT����Ƶ����ͼ');
xlabel('��/\pi');ylabel('��λ');axis([0,2,-3.5,3.5])

k=0:15;wk=2*k/16;       
subplot(5,2,3);stem(wk,abs(Xk16),'.');                        
title('16��DFT�ķ�Ƶ����ͼ');xlabel('��/\pi');ylabel('����')
subplot(5,2,4);stem(wk,angle(Xk16),'.');               
title('16��DFT����Ƶ����ͼ');
xlabel('��/\pi');ylabel('��λ');axis([0,2,-3.5,3.5])

k=0:31;wk=2*k/32;       
subplot(5,2,5);stem(wk,abs(Xk32),'.');                        
title('32��DFT�ķ�Ƶ����ͼ');xlabel('��/\pi');ylabel('����')
subplot(5,2,6);stem(wk,angle(Xk32),'.');               
title('32��DFT����Ƶ����ͼ');
xlabel('��/\pi');ylabel('��λ');axis([0,2,-3.5,3.5])

k=0:63;wk=2*k/64;       
subplot(5,2,7);stem(wk,abs(Xk64),'.');               
title('64��DFT�ķ�Ƶ����ͼ');xlabel('��/\pi');ylabel('����')
subplot(5,2,8);stem(wk,angle(Xk64),'.');      
title('64��DFT����Ƶ����ͼ')
xlabel('��/\pi');ylabel('��λ');axis([0,2,-3.5,3.5])

k=0:127;wk=2*k/128;       
subplot(5,2,9);stem(wk,abs(Xk128),'.');                        
title('128��DFT�ķ�Ƶ����ͼ');xlabel('��/\pi');ylabel('����')
subplot(5,2,10);stem(wk,angle(Xk128),'.');               
title('128��DFT����Ƶ����ͼ');
xlabel('��/\pi');ylabel('��λ');axis([0,2,-3.5,3.5])