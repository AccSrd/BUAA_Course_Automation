function Xk=my_dft(xn,N)
%% 实现数字信号DFT
l = length(xn);
if l~=N
    xn = [xn,zeros(1,N-1)];
end
WN=exp(-1i*2*pi/N);
for k=1:N
    Xk(k) = 0;
    for n=1:N;
        Xk(k) = Xk(k)+xn(n)*(WN^((k-1)*(n-1)));
    end
end
end

