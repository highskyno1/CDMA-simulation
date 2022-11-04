function res = overlay(input)
% 码元叠加函数，对输入的每一列进行相加，然后判决相加结果为1、-1或0
% input:扩频后的用户码元
%对每一列进行相加
foo = sum(input(1:end,:));
%计算标准差
res_std = std(foo);
%计算平均数
res_mean = mean(foo);
%计算概率为1/3时的阈值，也就是判决为-1的阈值
syms temp;
%以下计算时会有一个"Unable to solve symbolically. Returning a numeric solution using
%vpasolve"的警告,让系统不显示
warning off;
threshhold_negative = double(solve(normcdf(temp,res_mean,res_std)==1/3,temp));
%计算概率为2/3时的阈值，也就是判决为1的阈值
threshhold_postive = double(solve(normcdf(temp,res_mean,res_std)==2/3,temp));
%根据阈值分类
res = int8(zeros(1,length(foo)));
for i = 1:length(foo)
    if foo(i) > threshhold_postive
        res(i) = 1;
    elseif foo(i) < threshhold_negative
        res(i) = -1;
    end
end
end

