%% 使用ZOH+G(s)求得传递函数Z变换G(z)
% num den为Gs系数，例：1/s+1为[1] [1 1]
% T为采样时间
% 输出c为分子，d为分母，例：c=0,0.6 d=1,-0.3  Gz = (0.6z^-1)/(1-0.3z^-1)

num = [1];
den = [1 2 2];
T = 0.1;
[c,d] = c2dm(num,den,T,'zoh');
sys = tf(c,d,1,'Variable','z^-1')
[z,p,k] = tf2zp(c,d);
zpk(z,p,k,1,'Variable','z')