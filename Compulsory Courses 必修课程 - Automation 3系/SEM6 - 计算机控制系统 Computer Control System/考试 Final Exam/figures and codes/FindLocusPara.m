%% ������켣���ʱ���켣ָ��

T = 0.2;    % ��������
Delta = 1; % �ٷ���������
Ts = 2;     % 5%����ʱ��
Tr = 5;  % ����ʱ��

Delta = Delta/100;
kexi = (abs(log(1/Delta)))/((pi^2)+(log(1/Delta))^2)^(1/2)   %kexi����������

Re_s = 3.5/Ts;
R = exp(-T*Re_s)    %ͬ��Բ�뾶 

Im_s = (pi-acos(kexi))/Tr;
theta = 360*(T*Im_s)/(2*pi)    %���߽Ƕ�
