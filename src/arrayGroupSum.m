function res = arrayGroupSum(input,group_num)
%arrayGroupSum ����������,������鳤�ȳ�ȥgroup_num�޷���������ض�input����
%input Ŀ������
%group_num ������
len = floor(length(input)/group_num);
res = zeros(1,len);
for i = 1:len
    res(i) = sum(input((i-1)*group_num+1:i*group_num));
end
end

