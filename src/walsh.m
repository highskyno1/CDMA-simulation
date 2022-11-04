function walsh = walsh(N)
% 产生Walsh函数通用函数
% N:Walsh函数阶数,当N不是2的幂时,通过向无穷大取整使得所得Walsh阶数为2的幂
    M = ceil(log2(N));
    wn = 0;
    for i = 1:M
        w2n = [wn,wn;wn,~wn];
        wn = w2n;
    end
    wn(wn == 0) = -1;
    walsh = int8(wn);
end