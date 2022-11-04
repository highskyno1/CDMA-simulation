function res = value2Bipolar(input)
% 本函数用户把随机生成的0~1之间的double数转换成双极性码
% input:double二维数组
    [row,col] = size(input);
    res = int8(ones(row,col));
    for i = 1:row
        for j = 1:col
            if input(i,j) < 0.5
                res(i,j) = -1;
            end
        end
    end
end