function res = value2Bipolar(input)
% �������û���������ɵ�0~1֮���double��ת����˫������
% input:double��ά����
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