function res = spreadSpectrum(userCode,spreadCode)
% ʵ�ֶ�ÿ���û�������Ƶ
% userCode:�û���Ԫ��ÿһ��Ϊһ���û����е���Ԫ
% spreadCode:��Ƶ�룬ÿһ����Ϊһ���û��Լ�����Ƶ��
    [row_userCode,col_userCode] = size(userCode);
    [row_spreadCode,col_spreadCode] = size(spreadCode);
    if row_spreadCode < row_userCode
        error('��Ƶ����������С���û���');
    end
    res = int8(zeros(row_userCode,col_userCode * col_spreadCode));
    %��ÿһ���û�������Ƶ
    for i = 1:row_userCode
        for j = 1:col_userCode
            res(i,(j-1)*col_spreadCode+1:j*col_spreadCode) = userCode(i,j).*spreadCode(i,:);
        end
    end
end