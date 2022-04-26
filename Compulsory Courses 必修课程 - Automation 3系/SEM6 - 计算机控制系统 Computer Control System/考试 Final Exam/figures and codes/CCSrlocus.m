%% Z平面根轨迹法设计D(z)

kexi = 0.5;
R = 0.7047;
theta = 4.84;

figure(1)
% 对数螺旋线
B = acos(kexi);
TB = -1/tan(B);
WT = 0:0.01:2*pi;
EW = exp(WT*TB);
x = EW.*cos(WT);
y = EW.*sin(WT);
plot(x, y, 'r'),grid;
hold on

% Re(s)同心圆
t = 0:0.01:2*pi;
xR = R*cos(t);
yR = R*sin(t);
x1 = cos(t);
y1 = sin(t);
plot(x1, y1, 'g');
plot(xR, yR, 'r');

% Im(s)射线
temp = theta*pi/180;
x2 = cos(temp);
y2 = sin(temp);
plot([0,x2], [0,y2], 'r');
plot([-1,1], [0,0], 'g');
plot([0,0], [-1,1], 'g');

% 计算脉冲传递函数
num = [1];
den = [1 2 0];
T = 0.2;
[wnun, wdes] = c2dm(num,den,T,'zoh');

% 常值控制器
% rlocus(wnun, wdes)

% 二阶控制器
numGD = [1 0.205 -0.5867];
denGD = [1 -1 0];
rlocus(numGD, denGD)
[K,pole] = rlocfind(numGD, denGD)