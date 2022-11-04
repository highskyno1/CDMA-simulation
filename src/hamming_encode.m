function res = hamming_encode(input,frame_size)
%encode ������Ķ�����������к��������,��У��
%input:��Ҫ����Ķ���������
%frame_size:ÿһ֡���ݵĶ�����λ��
len_input = length(input);
if mod(len_input,frame_size) ~= 0
    error('����������������Ƿ�������������')
end
%��������λ����
red_bit_num = red_bit_cal(frame_size);
%�ܵ�λ��
bit_num = red_bit_num + frame_size;
%֡����
frame_num = len_input / frame_size;
%����У��λ��λ��
pos_red_bit = 2.^(0:red_bit_num-1);
%����У��λ�����λ
pos_relat_bit = uint8(zeros(red_bit_num,bit_num));
for i = 1:red_bit_num
    for j = 1:bit_num
        if bitand(2^(i-1),j) ~= 0
            pos_relat_bit(i,j) = 1;
        end
    end
end
%��ʼ��һ�������Ԫ
res = uint8(zeros(frame_num,bit_num));
%����ÿһ֡������λ
index = 1;
for i = 1:frame_num
    for j = 1:bit_num
        if ismember(j,pos_red_bit)
            continue
        end
        res(i,j) = input(index);
        index = index + 1;
    end
end
%��ÿһ֡����У��λ
for i = 1:frame_num
    for j = 1:red_bit_num
        foo = bitand(res(i,:),pos_relat_bit(j,:));
        foo = mod(sum(foo)+1,2);
        res(i,pos_red_bit(j)) = foo;
    end
end
res = res';
res = res(:);
end

