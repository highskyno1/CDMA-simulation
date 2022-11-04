function res = overlay(input)
% ��Ԫ���Ӻ������������ÿһ�н�����ӣ�Ȼ���о���ӽ��Ϊ1��-1��0
% input:��Ƶ����û���Ԫ
%��ÿһ�н������
foo = sum(input(1:end,:));
%�����׼��
res_std = std(foo);
%����ƽ����
res_mean = mean(foo);
%�������Ϊ1/3ʱ����ֵ��Ҳ�����о�Ϊ-1����ֵ
syms temp;
%���¼���ʱ����һ��"Unable to solve symbolically. Returning a numeric solution using
%vpasolve"�ľ���,��ϵͳ����ʾ
warning off;
threshhold_negative = double(solve(normcdf(temp,res_mean,res_std)==1/3,temp));
%�������Ϊ2/3ʱ����ֵ��Ҳ�����о�Ϊ1����ֵ
threshhold_postive = double(solve(normcdf(temp,res_mean,res_std)==2/3,temp));
%������ֵ����
res = int8(zeros(1,length(foo)));
for i = 1:length(foo)
    if foo(i) > threshhold_postive
        res(i) = 1;
    elseif foo(i) < threshhold_negative
        res(i) = -1;
    end
end
end

