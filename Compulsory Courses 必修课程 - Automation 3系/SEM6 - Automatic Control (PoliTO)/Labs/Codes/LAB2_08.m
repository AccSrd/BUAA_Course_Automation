s=tf('s');
H=1/(s^3+2*s^2+5.25*s+4.25);

w0=0.1;
[m,f]=bode(H,w0);
3*m
f_rad=f/180*pi
H0=1/4.25;
2*H0

w1=3;
[m1,f1]=bode(H,w1);
Au=1/m1
