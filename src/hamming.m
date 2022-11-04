function res = hamming(input,frame_size)
%hamming_encode 对每个用户进行汉明码编码/解码
%input:用户码元矩阵，每一行为一个用户的码元
%frame_size：汉明码每帧的长度
%把-1转换为0
input(input == -1) = 0;
[user_num,code_size] = size(input);
%计算冗余位数量
red_bit_num = red_bit_cal(frame_size);
%总的位数
bit_num = red_bit_num + frame_size;
%帧数量
frame_num = code_size / frame_size;
%初始化res
res = int8(zeros(user_num,bit_num*frame_num));
%为每个用户计算
for i = 1:user_num
    res(i,:) = hamming_encode(input(i,:),frame_size);
end
%把0转换为-1
res(res == 0) = -1;
end

