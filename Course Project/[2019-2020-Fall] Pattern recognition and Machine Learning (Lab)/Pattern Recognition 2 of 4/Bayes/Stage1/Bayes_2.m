%最小风险贝叶斯决策
x = [-3.9847 -3.5549 -1.2401 -0.9780 -0.7932 -2.8531
     -2.7605 -3.7287 -3.5414 -2.2692 -3.4549 -3.0752
     -3.9934  2.8792 -0.9780  0.7932  1.1882  3.0682
     -1.5799 -1.4885 -0.7431 -0.4221 -1.1186  4.2532];
 pw1 = 0.9; %正常概率
 pw2 = 0.1; %异常概率
 e1 = -2;   %正常期望
 e2 =  2;   %异常期望
 a1 = 0.5;  %正常方差
 a2 = 2;    %异常方差
 r11 = 0;
 r12 = 6;   %错误分为正常
 r21 = 1;   %正常分为错误
 r22 = 0;  %风险决策表
 
 m = numel(x); %待测数据个数  
 R1_x = zeros(1,m);
 R2_x = zeros(1,m);
 results = zeros(1,m);
 %计算风险值
 for i = 1:m
     R1_x(i) = r11*pw1*normpdf(x(i),e1,a1)/(pw1*normpdf(x(i),e1,a1)+pw2*normpdf(x(i),e2,a2))+r12*pw2*normpdf(x(i),e2,a2)/(pw1*normpdf(x(i),e1,a1)+pw2*normpdf(x(i),e2,a2));
     R2_x(i) = r21*pw1*normpdf(x(i),e1,a1)/(pw1*normpdf(x(i),e1,a1)+pw2*normpdf(x(i),e2,a2))+r22*pw2*normpdf(x(i),e2,a2)/(pw1*normpdf(x(i),e1,a1)+pw2*normpdf(x(i),e2,a2));
 end
 
 for i = 1:m
     if R1_x(i) < R2_x(i)
         results(i) = 0;
     else
         results(i) = 1;
     end
 end
 
 results