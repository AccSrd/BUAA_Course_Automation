%% Zƽ����켣�����D(z)

kexi = 0.5;
R = 0.7047;
theta = 4.84;

figure(1)
% ����������
B = acos(kexi);
TB = -1/tan(B);
WT = 0:0.01:2*pi;
EW = exp(WT*TB);
x = EW.*cos(WT);
y = EW.*sin(WT);
plot(x, y, 'r'),grid;
hold on

% Re(s)ͬ��Բ
t = 0:0.01:2*pi;
xR = R*cos(t);
yR = R*sin(t);
x1 = cos(t);
y1 = sin(t);
plot(x1, y1, 'g');
plot(xR, yR, 'r');

% Im(s)����
temp = theta*pi/180;
x2 = cos(temp);
y2 = sin(temp);
plot([0,x2], [0,y2], 'r');
plot([-1,1], [0,0], 'g');
plot([0,0], [-1,1], 'g');

% �������崫�ݺ���
num = [1];
den = [1 2 0];
T = 0.2;
[wnun, wdes] = c2dm(num,den,T,'zoh');

% ��ֵ������
% rlocus(wnun, wdes)

% ���׿�����
numGD = [1 0.205 -0.5867];
denGD = [1 -1 0];
rlocus(numGD, denGD)
[K,pole] = rlocfind(numGD, denGD)