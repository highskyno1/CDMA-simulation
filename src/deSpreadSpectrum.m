function res = deSpreadSpectrum(userSpreadCode,spreadCode,user_num)
%���������ڽ���
%userSpreadCode:��Ҫ�������û���Ԫ
%spreadCode:������Ƶ�������
%user_num:�û�����
[~,col] = size(userSpreadCode);
res = zeros(user_num,col);
%Ϊÿһ���û��ֱ����
for i = 1:user_num
    res(i,:) = bitMultiple(userSpreadCode,spreadCode(i,:));
end
end