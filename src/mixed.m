function res = mixed(input,frame_size,method)
%mixed ��֯�������׺���
%input:�û���Ԫ���飬ÿһ�б�ʾһ���û�����Ԫ
%frame_size:��֯����ÿ֡����
%method:���㷽��
[user_num,~] = size(input);
res = input;
for i = 1:user_num
    res(i,:) = method(input(i,:),frame_size);
end
end

