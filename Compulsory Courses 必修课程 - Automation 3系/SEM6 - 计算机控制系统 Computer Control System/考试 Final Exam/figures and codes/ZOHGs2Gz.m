%% ʹ��ZOH+G(s)��ô��ݺ���Z�任G(z)
% num denΪGsϵ��������1/s+1Ϊ[1] [1 1]
% TΪ����ʱ��
% ���cΪ���ӣ�dΪ��ĸ������c=0,0.6 d=1,-0.3  Gz = (0.6z^-1)/(1-0.3z^-1)

num = [1];
den = [1 2 2];
T = 0.1;
[c,d] = c2dm(num,den,T,'zoh');
sys = tf(c,d,1,'Variable','z^-1')
[z,p,k] = tf2zp(c,d);
zpk(z,p,k,1,'Variable','z')