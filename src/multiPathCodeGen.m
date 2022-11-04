function res = multiPathCodeGen(path_num)
%multiPathCodeGen 产生多径衰落时滞码
%   path_num:路径数量
res = rand(1,path_num);
%因为一般最先到到达的路径信号最强，所以对上述数列进行降序排序
res = sort(res,'descend');
%因为多径衰落不可能对信号有增幅，所以对信号做归一化处理
mult_fading_code_sum = sum(res);
res = res./mult_fading_code_sum;
end

