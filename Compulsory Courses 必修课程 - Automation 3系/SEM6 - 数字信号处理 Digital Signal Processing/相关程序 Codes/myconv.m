function y=myconv(x,h)
%% ���Ծ��
N = length(x);
M = length(h);
L = M+N-1;
y = zeros(L,1);
for n=1:N
  for k=1:M
    y(n+k-1) = y(n+k-1) + x(n)*h(k);
  end 
end
y = y';
end