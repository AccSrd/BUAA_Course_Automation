%% 计算根轨迹设计时根轨迹指标

T = 0.1;    % 采样周期
Delta = 15; % 百分数超调量
Ts = 0.55;     % 5%调节时间
Tr = 1;  % 上升时间

Delta = Delta/100;
kexi = (abs(log(1/Delta)))/((pi^2)+(log(1/Delta))^2)^(1/2)   %kexi对数螺旋线

Re_s = 3.5/Ts;
R = exp(-T*Re_s)    %同心圆半径 

Im_s = (pi-acos(kexi))/Tr;
theta = 360*(T*Im_s)/(2*pi)    %射线角度
