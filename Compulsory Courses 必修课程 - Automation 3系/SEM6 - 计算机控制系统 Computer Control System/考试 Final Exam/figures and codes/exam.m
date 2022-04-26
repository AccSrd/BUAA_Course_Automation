%% 2.1
% A = [-1 0;1 0];
% B = [1;0];
% syms T
% [F,G] = c2d(A,B,T)

%% 4
% zG = [1 0.5];
% pG = [3 -4 1];
% T = 1;
% 
% hd = tf(zG,pG,T);
% [Gm,Pm,Wg,Wp]=margin(hd)
% Gm_dB = 20*log10(Gm)
% 
% w = logspace(-1,1);
% dbode(zG,pG,T,w);
% grid

%% 5
T = 1;
w = 0:0.1:100;
nGs = [1 0 1];
dGs = [1 10.1 1];
[nGz,dGz] = c2dm(nGs,dGs,T,'tustin');
figure(1)
bode(nGs,dGs,w);grid;hold on
dbode(nGz,dGz,T,w);
legend('con','dis')

[nGz1,dGz1] = c2dm(nGs,dGs,T,'prewarp',1);
figure(2)
bode(nGs,dGs,w);grid;hold on
dbode(nGz1,dGz1,T,w);
legend('con','dis')