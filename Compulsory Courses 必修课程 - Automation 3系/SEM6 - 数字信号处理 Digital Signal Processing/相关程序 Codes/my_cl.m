function y = my_cl(hn,xn,L)
%% Բ�ܾ��
N=length(hn);
M=length(xn);
HK=fft(hn,L);
XK=fft(xn,L);
YK=XK.*HK;
y=ifft(YK,L);
end
