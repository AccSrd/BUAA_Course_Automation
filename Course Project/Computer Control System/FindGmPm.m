%% 求离散系统裕度
% zG,pG 为开环传递函数D(z)G(z)
% Wp    ->截止频率omega_c rad/s
% Pm    ->相位裕度gamma_m deg
% Gm_dB ->幅度裕度L_h dB
% Wg    ->幅度裕度omega_h rad/s

% 相位裕度 gamma_h = [Pm]deg at [Wp]rad/s
% 幅度裕度 L_h = [Gm_dB]dB at [Wg]rad/s

zG = [0.198 0.198];
pG = [1 -1.242 0.242];
T = 0.1;

hd = tf(zG,pG,T);
[Gm,Pm,Wg,Wp]=margin(hd)
Gm_dB = 20*log10(Gm)

w = logspace(0,2);
dbode(zG,pG,T,w);
grid