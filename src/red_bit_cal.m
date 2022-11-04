function res = red_bit_cal(group_num)
%red_bit_cal 计算冗余位数量
%group_num:每一帧数据的二进制位数
res = 0;
while 2^res - res < group_num + 1
    res = res + 1;
end
end

