function res = unhamming(input,frame_size)
%hamming_encode ��ÿ���û����к��������/����
%input:�û���Ԫ����ÿһ��Ϊһ���û�����Ԫ
%frame_size��������ÿ֡�ĳ���
%��-1ת��Ϊ0
input(input == -1) = 0;
[user_num,len_input] = size(input);
%��������λ����
red_bit_num = red_bit_cal(frame_size);
%�ܵ�λ��
bit_num = red_bit_num + frame_size;
if mod(len_input,bit_num) ~= 0
    error('������������������ܵ�λ����������');
end
%֡����
frame_num = len_input / bit_num;
%��ʼ��res
res = int8(zeros(user_num,frame_size*frame_num));
%Ϊÿ���û�����
for i = 1:user_num
    res(i,:) = hamming_decode(input(i,:),frame_size);
end
%��0ת��Ϊ-1
res(res == 0) = -1;
end
