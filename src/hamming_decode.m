function res = hamming_decode(input,frame_size)
%decode 对输入的二进制数组进行汉明码解码,奇校验
%input:需要编码的二进制数组
%frame_size:每一帧数据的二进制位数
len_input = length(input);
%计算冗余位数量
red_bit_num = red_bit_cal(frame_size);
%总的位数
bit_num = red_bit_num + frame_size;
if mod(len_input,bit_num) ~= 0
    error('输入的数组数必须是总的位数的整数倍');
end
%帧数量
frame_num = len_input / bit_num;
%对输入进行重构
input = uint8(input);
input = reshape(input,bit_num,frame_num);
input = input';
%计算校验位的位置
pos_red_bit = 2.^(0:red_bit_num-1);
%计算校验位的相关位
pos_relat_bit = uint8(zeros(red_bit_num,bit_num));
for i = 1:red_bit_num
    for j = 1:bit_num
        if bitand(2^(i-1),j) ~= 0
            pos_relat_bit(i,j) = 1;
        end
    end
end
%开始校验,注意是奇校验
for i = 1:frame_num
    %该帧的校验结果
    res_verify = uint8(zeros(1,red_bit_num));
    for j = 1:red_bit_num
        foo = sum(bitand(input(i,:),pos_relat_bit(j,:)));
        if mod(foo,2) == 0
            %奇校验失败
            res_verify(j) = 1;
        end
    end
    %计算出错位
    %转换为小端序
    res_verify = fliplr(res_verify);
    error_bit_pos = 0;
    for j = 1:red_bit_num
        error_bit_pos = error_bit_pos*2 + res_verify(j);
    end
    %出错位取反
    if error_bit_pos <= bit_num && error_bit_pos ~=0
        %如果为0，则没有发生传输错误
        input(i,error_bit_pos) = ~input(i,error_bit_pos);
    end
end
%提取结果
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

