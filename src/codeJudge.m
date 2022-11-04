function res = codeJudge(input,spreadSpectrumGain)
%codeJudge 码元判决，基于分组相加判决原理
%input 解扩后各个用户的矩阵，每一行为一个用户
%spreadSpectrumGain 扩频增益
[row,col] = size(input);
res = int8(ones(row,floor(col/spreadSpectrumGain)));
%对于每一个用户
for i = 1:row
   %分组判决
   res_group = arrayGroupSum(input(i,:),spreadSpectrumGain);
   for j = 1:length(res_group)
       if res_group(j) < 0
           res(i,j) = -1;
       end
   end
end
end