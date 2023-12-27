function res = demodulate(input,carrier)
%本函数实现对接收信号的解调
%原理:极性比较
%input:被解调的信号
%carrier:载波信号

%按位循环相乘
res_bitMultiple = bitMultiple(input,carrier);
%分组相加
res_arrayGroupSum = arrayGroupSum(res_bitMultiple,length(carrier));
%计算标准差
res_std = std(res_arrayGroupSum);
%计算平均数
res_mean = mean(res_arrayGroupSum);
%解算阈值
%计算概率为1/3时的阈值，也就是判决为-1的阈值
threshhold_negative = norminv(1/3,res_mean,res_std);
%计算概率为2/3时的阈值，也就是判决为1的阈值
threshhold_postive = norminv(2/3,res_mean,res_std);
res = zeros(1,length(res_arrayGroupSum));
for i = 1:length(res_arrayGroupSum)
    if res_arrayGroupSum(i) > threshhold_postive
        res(i) = 1;
    elseif res_arrayGroupSum(i) < threshhold_negative
        res(i) = -1;
    end
end
end