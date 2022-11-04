function res = overlay2(input)
% 码元叠加函数，对输入的每一列进行相加，然后判决相加结果为1、-1或0
% input:用户码元
%对每一列进行相加
res = sum(input(1:end,:));
end

