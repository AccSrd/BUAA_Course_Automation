s=tf('s');
G=10/(s*(s+5)*(s+10));
L=5*G;
nyquist(L)