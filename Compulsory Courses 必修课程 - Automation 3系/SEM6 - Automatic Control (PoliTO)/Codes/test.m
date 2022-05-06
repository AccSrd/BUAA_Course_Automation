clear; 
A=[ 0 1 0 0; 
  0 0 0 0; 
  0 0 0 1; 
  0 0 29.4 0]; 
B=[ 0 1 0 3]'; 
C=[ 1 0 0 0; 
  0 0 1 0]; 
D=[ 0 0 ]'; 
Q11=1000; Q33=200; 
Q=[Q11 0 0 0; 
  0 0 0 0; 
  0 0 Q33 0; 
  0 0 0 0]; 
R = 1; 
K = lqr(A,B,Q,R) 
Ac = [(A-B*K)]; Bc = [B]; Cc = [C]; Dc = [D]; 
T=0:0.005:5; 
U=0.2*ones(size(T)); 
Cn=[1 0 0 0]; 
Nbar=rscale(A,B,Cn,0,K); 
Bcn=[Nbar*B]; 
[Y,X]=lsim(Ac,Bcn,Cc,Dc,U,T); 
plot(T,X(:,1),'-');hold on; 
plot(T,X(:,2),'-.');hold on; 
plot(T,X(:,3),'.');hold on; 
plot(T,X(:,4),'-') 
leend('CartPos','CartSpd','PendAn','PendSpd')