function res = genBipolar(num_user,num_code)
% ����˫������
% num_code:˫������Ĺ�ģ
% num_user:�û���
% res:[�û�1˫������;�û���˫�����롣����;]
    res = rand(num_user,num_code);
    res = value2Bipolar(res);
end