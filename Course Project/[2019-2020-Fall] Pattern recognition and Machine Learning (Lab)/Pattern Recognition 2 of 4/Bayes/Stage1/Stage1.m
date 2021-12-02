clear all;
clc;

x1 = [-3.9847,-3.5549,-1.2401,-0.9780,-0.7932,-2.8531,-2.7605,-3.7287,-3.5414,...
    -2.2692,-3.4549,-3.0752,-3.9934,-0.9780,-1.5799,-1.4885,-0.7431,-0.4221,...
    -1.1186,-2.3462,-1.0826,-3.4196,-1.3193,-0.8367,-0.6579,-2.9683];
x2 = [2.8792,0.7932,1.1882,3.0682,4.2532,0.3271,0.9846,2.7648,2.6588];
[miu1,sigma1]=normfit(x1);
[miu2,sigma2]=normfit(x2);
sqsigma1 = sigma1*sigma1;
sqsigma2 = sigma2*sigma2;

P_w1=0.9;
P_w2=0.1;

y(1,1)=0;y(1,2)=1;
y(2,1)=6;y(2,2)=0;


x = [-2,-1,0,1,2];

m=numel(x); 				%得到待测细胞个数
pw1_x=zeros(1,m); 			%存放对w1的后验概率矩阵
pw2_x=zeros(1,m); 			%存放对w2的后验概率矩阵

r1_x=zeros(1,m);            %存放将样本x判为正常细胞所造成的损失
r2_x=zeros(1,m);            %存放将样本x判为异常细胞所造成的损失
results=zeros(1,m);			%存放比较结果矩阵

for i = 1:m
pw1_x(i)=(P_w1*normpdf(x(i),miu1,sqsigma1))/...
    (P_w1*normpdf(x(i),miu1,sqsigma1)+P_w2*normpdf(x(i),miu2,sqsigma2));

pw2_x(i)=(P_w2*normpdf(x(i),miu2,sqsigma2))/...
    (P_w1*normpdf(x(i),miu1,sqsigma1)+P_w2*normpdf(x(i),miu2,sqsigma2));
end

for i=1:m
    r1_x(i)=y(1,1)*pw1_x(i)+y(2,1)*pw2_x(i);
    r2_x(i)=y(1,2)*pw1_x(i)+y(2,2)*pw2_x(i);
end


for i=1:m
    if r1_x(i)<r2_x(i) 
        results(i)=1;%%当第一类风险小于第二类风险的时候，判为正常细胞
    else
        results(i)=2;%%当第一类风险大于或者等于第二类风险的时候，判为异常细胞
    end
end

a=-5:0.01:5;  				%取样本点以画图
n=numel(a);
r1_plot=zeros(1,n);
r2_plot=zeros(1,n);
r1_polt_error=zeros(1,n);
r2_polt_error=zeros(1,n);
for j=1:n
    r1_plot(j)=y(1,1)*P_w1*normpdf(a(j),miu1,sqsigma1)/...
        (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2))+...
        y(2,1)*P_w2*normpdf(a(j),miu2,sqsigma2)/...
        (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2));
    %%计算每个样本点对w1的条件画图
    
    r2_plot(j)=y(1,2)*P_w1*normpdf(a(j),miu1,sqsigma1)/...
        (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2))+...
        y(2,2)*P_w2*normpdf(a(j),miu2,sqsigma2)/...
        (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2));
    %%计算每个样本点对w2的条件风险画图
    
    r1_polt_error(j)=(P_w1*normpdf(a(j),miu1,sqsigma1))/...
    (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2)) ;

    r2_polt_error(j)=(P_w2*normpdf(a(j),miu2,sqsigma2))/...
    (P_w1*normpdf(a(j),miu1,sqsigma1)+P_w2*normpdf(a(j),miu2,sqsigma2)) ;
end

figure(1);
hold on
h1=plot(a,r1_plot,'b');
h2=plot(a,r2_plot,'r--');

%for k=1:m
%    if results(k)==0 
%        h3=plot(x(k),-0.1,'cp'); %正常细胞用五角星表示
%    else
%        h4=plot(x(k),-0.1,'r*'); %异常细胞用*表示
%    end
%end

legend([h1,h2],'Decision of \omega_1','Decision of \omega_2');
xlabel('X');
%title('Posterior Probability Density Functions');
title('Conditional Risk');
grid on

figure(2);
hold on
h3=plot(a,r1_polt_error,'b');
h4=plot(a,r2_polt_error,'r--');
legend([h3,h4],'P(\omega_1|X)','P(\omega_2|X)');
xlabel('X');
title('Posterior Probability Density Functions');
grid on

figure(3);
hold on
x1=-10:0.0001:10;
y1=(1/((sqrt(2*pi))*sqsigma1))*exp(-((x1-miu1).^2)/(2*sqsigma1.^2));
plot(x1,y1,'b');
x2=-10:0.0001:10;
y2=(1/((sqrt(2*pi))*sqsigma2))*exp(-((x2-miu2).^2)/(2*sqsigma2.^2));
plot(x2,y2,'r--');
legend('P(X|\omega_1)','P(X|\omega_2)');
xlabel('X');
title('Prior Probability Density Functions');
grid on

results
