%% ����ɢϵͳԣ��
% zG,pG Ϊ�������ݺ���D(z)G(z)
% Wp    ->��ֹƵ��omega_c rad/s
% Pm    ->��λԣ��gamma_m deg
% Gm_dB ->����ԣ��L_h dB
% Wg    ->����ԣ��omega_h rad/s

% ��λԣ�� gamma_h = [Pm]deg at [Wp]rad/s
% ����ԣ�� L_h = [Gm_dB]dB at [Wg]rad/s

zG = [0.198 0.198];
pG = [1 -1.242 0.242];
T = 0.1;

hd = tf(zG,pG,T);
[Gm,Pm,Wg,Wp]=margin(hd)
Gm_dB = 20*log10(Gm)

w = logspace(0,2);
dbode(zG,pG,T,w);
grid