clc;
clear all;

% ����������
Kexi = 0.4559;
B = acos(Kexi);
TB = -1/tan(B);
WT = 0:0.01:2*pi;
EW = exp(WT*TB);
x = EW.*cos(WT);
y = EW.*sin(WT);
plot(x, y, 'r'),grid;
hold on

% Re(s)ͬ��Բ
t = 0:0.01:2*pi;
R = 0.8395;
xR = R*cos(t);
yR = R*sin(t);
x1 = cos(t);
y1 = sin(t);
plot(x1, y1, 'g');
plot(xR, yR, 'r');

% Im(s)����
thita = 16.73;
temp = thita*pi/180;
x2 = cos(temp);
y2 = sin(temp);
plot([0,x2], [0,y2], 'r');
plot([-1,1], [0,0], 'g');
plot([0,0], [-1,1], 'g');

% �������崫�ݺ���
[wnun, wdes] = c2dm([1], [1,2,2], 0.1, 'zoh');

% ��ֵ������
% rlocus(wnun, wdes)

% ���׿�����
numGD = [1 0.936];
denGD = [1 -1 0];
rlocus(numGD, denGD)
[K,pole] = rlocfind(numGD, denGD)