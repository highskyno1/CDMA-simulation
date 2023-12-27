function res = demodulate(input,carrier)
%������ʵ�ֶԽ����źŵĽ��
%ԭ��:���ԱȽ�
%input:��������ź�
%carrier:�ز��ź�

%��λѭ�����
res_bitMultiple = bitMultiple(input,carrier);
%�������
res_arrayGroupSum = arrayGroupSum(res_bitMultiple,length(carrier));
%�����׼��
res_std = std(res_arrayGroupSum);
%����ƽ����
res_mean = mean(res_arrayGroupSum);
%������ֵ
%�������Ϊ1/3ʱ����ֵ��Ҳ�����о�Ϊ-1����ֵ
threshhold_negative = norminv(1/3,res_mean,res_std);
%�������Ϊ2/3ʱ����ֵ��Ҳ�����о�Ϊ1����ֵ
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