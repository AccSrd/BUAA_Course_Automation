
%1.2
x = [3 11 7 0 -1 4 2];
h = [2 3 0 -5 2 1];
y = conv(x,h);
my_y = myconv(x,h);
figure(1)
max_x = max([max(x),max(h)]);
max_y = max([max(my_y),max(y)]);
subplot(4,1,1),stem(x);title('x(n)');xlabel('n');ylabel('x[n]');grid on;axis([0 length(y) 0 max_x])
subplot(4,1,2),stem(h);title('h(n)');xlabel('n');ylabel('h[n]');grid on;axis([0 length(y) 0 max_x])
subplot(4,1,3),stem(y);title('线性卷积y1(n)');xlabel('n');ylabel('y1[n]');grid on;axis([0 length(y) 0 max_y])
subplot(4,1,4),stem(my_y);title('自己编写的线性卷积y2(n)');xlabel('n');ylabel('y2[n]');grid on;axis([0 length(y) 0 max_y])

%2.2
x1 = 2*ones(1,15);
x2 = ones(1,20);
L = 28;
y = my_cl(x1,x2,L);
b1 = zeros(1,L-length(x1));
x1_0 = [x1,b1];
b2 = zeros(1,L-length(x2));
x2_0 = [x2,b2];
max_x = max([max(x1),max(x2)]);
max_y = max(y);
subplot(3,1,1),stem(x1_0);title('x1(n)');xlabel('n');ylabel('x1[n]');grid on;axis([0 length(y) 0 max_x])
subplot(3,1,2),stem(x2_0);title('x2(n)');xlabel('n');ylabel('x2[n]');grid on;axis([0 length(y) 0 max_x])
subplot(3,1,3),stem(y);title('圆周卷积y(n)');xlabel('n');ylabel('y1[n]');grid on;axis([0 length(y) 0 max_y])


%3.1
x1 = ones(1,15);
x2 = ones(1,20);
for n = 1:20
    x2(n) = 0.98^(n-1);
end
L = 40;
y = my_cl(x1,x2,L);
b1 = zeros(1,L-length(x1));
x1_0 = [x1,b1];
b2 = zeros(1,L-length(x2));
x2_0 = [x2,b2];
max_x = max([max(x1),max(x2)]);
max_y = max(y);
subplot(3,1,1),stem(x1_0);title('x1(n)');xlabel('n');ylabel('x1[n]');grid on;axis([0 length(y) 0 max_x])
subplot(3,1,2),stem(x2_0);title('x2(n)');xlabel('n');ylabel('x2[n]');grid on;axis([0 length(y) 0 max_x])
subplot(3,1,3),stem(y);title('圆周卷积y(n)');xlabel('n');ylabel('y1[n]');grid on;axis([0 length(y) 0 max_y])

%3.2
L = 34;
y1 = my_cl(x1,x2,L);
y2 = myconv(x1,x2);
b1 = zeros(1,L-length(x1));
x1_0 = [x1,b1];
b2 = zeros(1,L-length(x2));
x2_0 = [x2,b2];
max_x = max([max(x1),max(x2)]);
max_y = max([max(y1),max(y2)]);
subplot(4,1,1),stem(x1_0);title('x1(n)');xlabel('n');ylabel('x1[n]');grid on;axis([0 length(y) 0 max_x])
subplot(4,1,2),stem(x2_0);title('x2(n)');xlabel('n');ylabel('x2[n]');grid on;axis([0 length(y) 0 max_x])
subplot(4,1,3),stem(y1);title('圆周卷积y1(n)');xlabel('n');ylabel('y1[n]');grid on;axis([0 length(y) 0 max_y])
subplot(4,1,4),stem(y2);title('线性卷积y2(n)');xlabel('n');ylabel('y2[n]');grid on;axis([0 length(y) 0 max_y])