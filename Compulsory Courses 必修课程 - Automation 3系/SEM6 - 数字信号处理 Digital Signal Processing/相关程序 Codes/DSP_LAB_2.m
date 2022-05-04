%逆Z变换
% b = [6 -10 2];
% a = [1 -3 2];
% [r,p,k] = residuez(b,a);
% disp('留数:');disp(r');
% disp('极点:');disp(p');
% disp('系数:');disp(k');
% figure(1)
% zplane(b,a)

%系统单位脉冲
% syms z;
% b = [2 -2];
% a = [1 -1/3];
% impz(b,a,12)
% zplane(b,a)
% fz = (2-2*z^(-1))/(1-(5/6)*z^(-1)+(1/6)*z^(-2));
% yn = iztrans(fz);
% x = 1:11;
% for i = 1:11
%     y(i) = 8*(1/3)^i - 6*(1/2)^i;
% end
% stem(x,y)

% %系统频率响应
b = [1 -1.8 -1.44 0.64];
a = [1 -1.6485 1.03882 -0.228];
z = roots(b);
p = roots(a);
disp('零点:');disp(z');
disp('极点:');disp(p');
% zplane(b,a);
% [H,w] = freqz(b,a,'whole');
% subplot(2,1,1)
% plot(w/pi,abs(H));
% title('幅值');
% xlabel('\omega/\pi');
% ylabel('|H(e^j^\omega)|');
% grid on
% subplot(2,1,2)
% plot(w/pi,angle(H));
% title('相位');
% xlabel('\omega/\pi');
% ylabel('\phi(\omega)')
% grid on;

%正弦波发生器
% b1 = [0 2*sin(pi/25)];
% a1 = [1 -2*cos(pi/25) 1];
% b2 = [2 -2*cos(pi/25)];
% a2 = [1 -2*cos(pi/25) 1];
% [h1,n1] = impz(b1,a1,100);
% [h2,n2] = impz(b2,a2,100);
% figure(1)
% stem(n1,h1);grid on
% hold on
% stem(n2,h2);
% title('正弦波发生器')
% ylabel('y[n]');
% xlabel('n');
% legend('y[n]=2sin(\pi/25n)','y[n]=2cos(\pi/25n)')

