function res = multiPathCodeGen(path_num)
%multiPathCodeGen �����ྶ˥��ʱ����
%   path_num:·������
res = rand(1,path_num);
%��Ϊһ�����ȵ������·���ź���ǿ�����Զ��������н��н�������
res = sort(res,'descend');
%��Ϊ�ྶ˥�䲻���ܶ��ź������������Զ��ź�����һ������
mult_fading_code_sum = sum(res);
res = res./mult_fading_code_sum;
end

