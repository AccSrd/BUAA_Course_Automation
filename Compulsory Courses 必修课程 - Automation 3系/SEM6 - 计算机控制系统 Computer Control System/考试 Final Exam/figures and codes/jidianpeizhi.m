%% 极点配置法求全状态反馈增益

F = [1 0.05;0 1];
G = [1/800; 0.05];
C = [1 0];

kexi = 0.7;
wn = 10;
T = 0.05;

dens = [1,2*kexi*wn,wn^2];
pc = (roots(dens))'  % s平面期望闭环极点
pz = exp(pc*T)       % z平面期望闭环极点
% pz = roots([1,-0.5,0.5])
K = acker(F,G,pz)    % 状态反馈增益K


%% 二阶预测观测器1
% 先检测可观性！！！

a2 = 1;
a1 = -0.7504;
a0 = 0.2465;
n = 2;

acF = a2*F*F + a1*F + a0*eye(2);
L = acF*([C;C*F]^(-1))*[0;1];
F1 = F-L*C, G, L

%% 预测观测器2

% syms z L1 L2
% Det = sym2poly(det(z*eye(n)-(F-[L1;L2]*C)) - (a2*z^2+a1*z+a0))

%% 现今值观测器

% syms z L1 L2
% Det = sym2poly(det(z*eye(n)-(F-[L1;L2]*C*F)) - (a2*z^2+a1*z+a0))

%% 降维观测器
% 
% syms L
% 
% z0 = 0;
% L = solve(z0 - F(2,2) + L*F(1,2));
% vpa(L,5)



