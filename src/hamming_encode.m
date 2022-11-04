function res = hamming_encode(input,frame_size)
%encode 对输入的二进制数组进行汉明码编码,奇校验
%input:需要编码的二进制数组
%frame_size:每一帧数据的二进制位数
len_input = length(input);
if mod(len_input,frame_size) ~= 0
    error('输入的数组数必须是分组数的整数倍')
end
%计算冗余位数量
red_bit_num = red_bit_cal(frame_size);
%总的位数
bit_num = red_bit_num + frame_size;
%帧数量
frame_num = len_input / frame_size;
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
%初始化一个结果单元
res = uint8(zeros(frame_num,bit_num));
%填满每一帧的数据位
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
%对每一帧加入校验位
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

