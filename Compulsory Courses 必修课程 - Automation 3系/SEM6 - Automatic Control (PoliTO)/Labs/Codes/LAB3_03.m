s=tf('s');
G=1/(s+1)^2;
C=(1+s)^2/(s*(1+s/4));
%1
R=1/s;
L=G*C;
U=zpk(minreal(R*C/(1+L)));
[num_U,den_U]=tfdata(U,'v');
[rU,pU]=residue(num_U,den_U)
%2
w0=1;
S=1/(1+L);
[m,f]=bode(S,w0);
y=0.5*m
f_rad=f/180*pi
%3
R=3/s;
dy=2/s;
T=L/(L+1);
k1=dcgain(T);
k2=dcgain(S);
Yss=k1*3+k2*2
