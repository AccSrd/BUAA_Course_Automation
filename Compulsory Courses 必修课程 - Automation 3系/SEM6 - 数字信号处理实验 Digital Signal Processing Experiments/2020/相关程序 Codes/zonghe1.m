
% GS频率特性
% figure(1);
% subplot(2,1,1),plot(w,mag);
% grid on;
% axis ([0,35,0,1.2]);
% 
% subplot(2,1,2),plot(w,pha);
% grid on;
% axis([0,35,-200,200]);



pnumGz = [2 0];
pdenGz = [1 -0.6703];
T1 = 0.05;
% 
% GZ 频率特性
% w = 0:1:35;
% [dmag1, dpha1] = dbode(pnumGz, pdenGz, T1, w);
% for i = 1:1:36
%     if dpha1(i) <= -180
%         dpha1(i) = dpha1(i)+360;
%     end
% end
% 
% figure(1);
% subplot(2,1,1),plot(w,dmag1);
% grid on;
% 
% subplot(2,1,2),plot(w,dpha1);
% grid on;
% axis([0,35,-200,200]);

%Gz 脉冲响应
dimpulse(pnumGz, pdenGz, 15)
%impulse(pnumGs, pdenGs, 3)
