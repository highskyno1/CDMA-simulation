function res = hamming(input,frame_size)
%hamming_encode ��ÿ���û����к��������/����
%input:�û���Ԫ����ÿһ��Ϊһ���û�����Ԫ
%frame_size��������ÿ֡�ĳ���
%��-1ת��Ϊ0
input(input == -1) = 0;
[user_num,code_size] = size(input);
%��������λ����
red_bit_num = red_bit_cal(frame_size);
%�ܵ�λ��
bit_num = red_bit_num + frame_size;
%֡����
frame_num = code_size / frame_size;
%��ʼ��res
res = int8(zeros(user_num,bit_num*frame_num));
%Ϊÿ���û�����
for i = 1:user_num
    res(i,:) = hamming_encode(input(i,:),frame_size);
end
%��0ת��Ϊ-1
res(res == 0) = -1;
end

