function max=my_findmax(xn)
%% Ѱ��xn�����ֵ
if length(xn)==0
    max = 'no result';
end
if length(xn)~=0
    max = xn(1);
    for i=2:length(xn)
        if xn(i)>max
            max = xn(i);
        end
    end
end
end
