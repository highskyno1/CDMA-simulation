function res = unhamming(input,frame_size)
%hamming_encode 对每个用户进行汉明码编码/解码
%input:用户码元矩阵，每一行为一个用户的码元
%frame_size：汉明码每帧的长度
%把-1转换为0
input(input == -1) = 0;
[user_num,len_input] = size(input);
%计算冗余位数量
red_bit_num = red_bit_cal(frame_size);
%总的位数
bit_num = red_bit_num + frame_size;
if mod(len_input,bit_num) ~= 0
    error('输入的数组数必须是总的位数的整数倍');
end
%帧数量
frame_num = len_input / bit_num;
%初始化res
res = int8(zeros(user_num,frame_size*frame_num));
%为每个用户计算
for i = 1:user_num
    res(i,:) = hamming_decode(input(i,:),frame_size);
end
%把0转换为-1
res(res == 0) = -1;
end
