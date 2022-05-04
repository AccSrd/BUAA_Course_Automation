设置采样频率
fs = 100; %采样频率
N = 150;   %采样点数
n = 0:N-1;
t = n/fs; %时间序列

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
正弦序列x[n]=sin(n)
f_sin = 1;  %正弦波频率
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
title('正弦序列x1[n],\omega=\pi/16');
subplot(2,1,2)
stem(n,y2);
grid on;
xlabel('n');
ylabel('x2[n]');
title('正弦序列x2[n],\omega=31\pi/16');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%实指数序列x[n]=a^n
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
title('实指数序列x1[n]=1.1^n');  

subplot(2,2,2)                
stem(n,x2);                
grid on;                           
xlabel('n');                       
ylabel('x2[n]');                
title('实指数序列x2[n]=(-1.1)^n') 

subplot(2,2,3)                     
stem(n,x3);              
grid on;                         
xlabel('n');                   
ylabel('x3[n]');                
title('实指数序列x3[n]=0.9^n');  

subplot(2,2,4)        
stem(n,x4);               
grid on;                        
xlabel('n');                       
ylabel('x4[n]');               
title('实指数序列x4[n]=(-0.9)^n')       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %复指数序列x[n]=A*e^((a+jw)*n)
A=1;a=0.9;w=pi/8;                 
x=A*exp((a+1i*w)*n);              
figure(3)
subplot(2,2,1)                
stem(n,real(x));            %实部
grid on;                     
xlabel('n');                 
ylabel('x[n]');              
title('实部')              

subplot(2,2,2)                   
stem(n,imag(x));            %虚部
grid on;                        
xlabel('n');                    
ylabel('x[n]');                
title('虚部');               

subplot(2,2,3)         
stem(n,abs(x));             %模
grid on;                   
xlabel('n');                
ylabel('x[n]');           
title('模');               

subplot(2,2,4)                  
stem(n,angle(x));           %相角
grid on;                         
xlabel('n');               
ylabel('x[n]');         
title('相角');              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
多频正弦序列x[n]=sin1(n)+sin2(n)
w_sin_1 = pi/32;
w_sin_2 = 3*pi/32;
w_sin_3 = 5*pi/32;
A_1 = 1;              %正弦波1幅值
A_2 = 0.75;           %正弦波2幅值
A_3 = 0.25;           %正弦波3幅值
phi_1 = 0;            %正弦波1相位
phi_2 = pi/3;         %正弦波2相位
phi_3 = 2*pi/3;       %正弦波3相位
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
title('多频正弦序列x[n]=x1[n]+x2[n]+x3[n]');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%含噪声正弦序列x[n]=sin(n)+noise
ep = 0.3;           %噪声信号增益
RAND = ep*(rand(1,length(n))-0.5);
w_sin = pi/16;
y = cos(w_sin*n)+RAND; 
figure(5)
subplot(2,1,1)
stem(n,RAND);
grid on;
xlabel('n');
ylabel('x[n]');
title('噪声序列z[n]');
subplot(2,1,2)
stem(n,y);
grid on;
xlabel('n');
ylabel('x[n]');
title('含噪声正弦序列x[n]=s[n]+z[n]');
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

























