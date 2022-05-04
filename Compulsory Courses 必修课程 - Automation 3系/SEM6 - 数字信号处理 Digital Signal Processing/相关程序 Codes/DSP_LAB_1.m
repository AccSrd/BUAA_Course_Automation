���ò���Ƶ��
fs = 100; %����Ƶ��
N = 150;   %��������
n = 0:N-1;
t = n/fs; %ʱ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
��������x[n]=sin(n)
f_sin = 1;  %���Ҳ�Ƶ��
w_sin1 = pi/16;
w_sin2 = 31*pi/16;
y1 = cos(w_sin1*n);
y2 = cos(w_sin2*n);
figure(1)
subplot(2,1,1)
stem(n,y1);
grid on;
xlabel('n');
ylabel('x1[n]');
title('��������x1[n],\omega=\pi/16');
subplot(2,1,2)
stem(n,y2);
grid on;
xlabel('n');
ylabel('x2[n]');
title('��������x2[n],\omega=31\pi/16');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ʵָ������x[n]=a^n
x1=(1.1).^n;                   
x2=(-1.1).^n;         
x3=(0.9).^n;                
x4=(-0.9).^n;

figure(2)
subplot(2,2,1)                      
stem(n,x1);                
grid on;                           
xlabel('n');                      
ylabel('x1[n]');                  
title('ʵָ������x1[n]=1.1^n');  

subplot(2,2,2)                
stem(n,x2);                
grid on;                           
xlabel('n');                       
ylabel('x2[n]');                
title('ʵָ������x2[n]=(-1.1)^n') 

subplot(2,2,3)                     
stem(n,x3);              
grid on;                         
xlabel('n');                   
ylabel('x3[n]');                
title('ʵָ������x3[n]=0.9^n');  

subplot(2,2,4)        
stem(n,x4);               
grid on;                        
xlabel('n');                       
ylabel('x4[n]');               
title('ʵָ������x4[n]=(-0.9)^n')       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %��ָ������x[n]=A*e^((a+jw)*n)
A=1;a=0.9;w=pi/8;                 
x=A*exp((a+1i*w)*n);              
figure(3)
subplot(2,2,1)                
stem(n,real(x));            %ʵ��
grid on;                     
xlabel('n');                 
ylabel('x[n]');              
title('ʵ��')              

subplot(2,2,2)                   
stem(n,imag(x));            %�鲿
grid on;                        
xlabel('n');                    
ylabel('x[n]');                
title('�鲿');               

subplot(2,2,3)         
stem(n,abs(x));             %ģ
grid on;                   
xlabel('n');                
ylabel('x[n]');           
title('ģ');               

subplot(2,2,4)                  
stem(n,angle(x));           %���
grid on;                         
xlabel('n');               
ylabel('x[n]');         
title('���');              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
��Ƶ��������x[n]=sin1(n)+sin2(n)
w_sin_1 = pi/32;
w_sin_2 = 3*pi/32;
w_sin_3 = 5*pi/32;
A_1 = 1;              %���Ҳ�1��ֵ
A_2 = 0.75;           %���Ҳ�2��ֵ
A_3 = 0.25;           %���Ҳ�3��ֵ
phi_1 = 0;            %���Ҳ�1��λ
phi_2 = pi/3;         %���Ҳ�2��λ
phi_3 = 2*pi/3;       %���Ҳ�3��λ
y_1 = A_1*cos(w_sin_1*n+phi_1); 
y_2 = A_2*cos(w_sin_2*n+phi_2); 
y_3 = A_3*cos(w_sin_3*n+phi_3); 
y = y_1+y_2+y_3;
figure(4)
subplot(4,1,1)                  
stem(n,y_1);           %y1
grid on;                         
xlabel('n');               
ylabel('x_1[n]');    
subplot(4,1,2)                  
stem(n,y_2);           %y2
grid on;                         
xlabel('n');               
ylabel('x_2[n]');    
subplot(4,1,3) 
stem(n,y_3);
grid on;
xlabel('n');
ylabel('x3[n]');
subplot(4,1,4) 
stem(n,y);
grid on;
xlabel('n');
ylabel('x[n]');
title('��Ƶ��������x[n]=x1[n]+x2[n]+x3[n]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��������������x[n]=sin(n)+noise
ep = 0.3;           %�����ź�����
RAND = ep*(rand(1,length(n))-0.5);
w_sin = pi/16;
y = cos(w_sin*n)+RAND; 
figure(5)
subplot(2,1,1)
stem(n,RAND);
grid on;
xlabel('n');
ylabel('x[n]');
title('��������z[n]');
subplot(2,1,2)
stem(n,y);
grid on;
xlabel('n');
ylabel('x[n]');
title('��������������x[n]=s[n]+z[n]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MVF
Y_3 = DSP_MVF(y,3);
Y_5 = DSP_MVF(y,5);
Y_7 = DSP_MVF(y,7);
Y_9 = DSP_MVF(y,9);
Y_11 = DSP_MVF(y,11);

figure(6)
subplot(3,1,1)
plot(y,'-*')
title('MVF')
hold on;
grid on;
plot(Y_3,'k-p')
xlabel('n');
ylabel('x[n]');
legend('Raw Data','Len=3')
subplot(3,1,2)
plot(Y_5,'r-o')
hold on;
grid on;
plot(Y_7,'c-^')
xlabel('n');
ylabel('x[n]');
legend('Len=5','Len=7')
subplot(3,1,3)
plot(Y_9,'g-x')
hold on;
grid on;
plot(Y_11,'c-^')
xlabel('n');
ylabel('x[n]');
legend('Len=9','Len=11')

























