function Y = DSP_MVF( y_raw, WindowLength )
%%
%»¬¶¯Æ½¾ùÂË²¨
L = length(y_raw);
k = 0;
m = 0;
for i = 1:L
    m = m+1;
    if i+WindowLength-1 > L
        break
    else
        for j = i:WindowLength+i-1
            k = k+1;
            W(k) = y_raw(j) ;
        end
        Y(m) = mean(W);
        k = 0;
    end
end
end