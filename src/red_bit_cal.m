function res = red_bit_cal(group_num)
%red_bit_cal ��������λ����
%group_num:ÿһ֡���ݵĶ�����λ��
res = 0;
while 2^res - res < group_num + 1
    res = res + 1;
end
end

