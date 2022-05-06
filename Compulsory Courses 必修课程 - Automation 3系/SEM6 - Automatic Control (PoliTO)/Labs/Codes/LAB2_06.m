s=tf('s');
H1=(10)/(s^2+1.6*s+4);
H2=(20)/(s^2+6*s+25);
step(H1);
hold on
step(H2);