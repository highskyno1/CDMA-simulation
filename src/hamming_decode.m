function res = hamming_decode(input,frame_size)
%decode ������Ķ�����������к��������,��У��
%input:��Ҫ����Ķ���������
%frame_size:ÿһ֡���ݵĶ�����λ��
len_input = length(input);
%��������λ����
red_bit_num = red_bit_cal(frame_size);
%�ܵ�λ��
bit_num = red_bit_num + frame_size;
if mod(len_input,bit_num) ~= 0
    error('������������������ܵ�λ����������');
end
%֡����
frame_num = len_input / bit_num;
%����������ع�
input = uint8(input);
input = reshape(input,bit_num,frame_num);
input = input';
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
%��ʼУ��,ע������У��
for i = 1:frame_num
    %��֡��У����
    res_verify = uint8(zeros(1,red_bit_num));
    for j = 1:red_bit_num
        foo = sum(bitand(input(i,:),pos_relat_bit(j,:)));
        if mod(foo,2) == 0
            %��У��ʧ��
            res_verify(j) = 1;
        end
    end
    %�������λ
    %ת��ΪС����
    res_verify = fliplr(res_verify);
    error_bit_pos = 0;
    for j = 1:red_bit_num
        error_bit_pos = error_bit_pos*2 + res_verify(j);
    end
    %����λȡ��
    if error_bit_pos <= bit_num && error_bit_pos ~=0
        %���Ϊ0����û�з����������
        input(i,error_bit_pos) = ~input(i,error_bit_pos);
    end
end
%��ȡ���
res = uint8(zeros(1,frame_num*frame_size));
res_index = 1;
for i = 1:frame_num
    for j = 1:bit_num
        if ismember(j,pos_red_bit)
            continue
        end
        res(res_index) = input(i,j);
        res_index = res_index + 1;
    end
end
end

