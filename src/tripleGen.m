%��������������ָ�������������������,��Ҫ������ģ�����
%num:����
%res:���ؽ��������
function res = tripleGen(num)
    raw = rand(1,num);
    for i = 1:num
        if raw(i) >= 0.75
            raw(i) = 1;
        elseif raw(i) <= 0.25
            raw(i) = -1;
        else
            raw(i) = 0;
        end
    end
    res = int8(raw);
end