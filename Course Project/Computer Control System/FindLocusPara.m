%% ������켣���ʱ���켣ָ��

T = 0.1;    % ��������
Delta = 15; % �ٷ���������
Ts = 0.55;     % 5%����ʱ��
Tr = 1;  % ����ʱ��

Delta = Delta/100;
kexi = (abs(log(1/Delta)))/((pi^2)+(log(1/Delta))^2)^(1/2)   %kexi����������

Re_s = 3.5/Ts;
R = exp(-T*Re_s)    %ͬ��Բ�뾶 

Im_s = (pi-acos(kexi))/Tr;
theta = 360*(T*Im_s)/(2*pi)    %���߽Ƕ�
