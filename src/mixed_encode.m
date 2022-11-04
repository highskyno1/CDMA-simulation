function res = mixed_encode(input,frame_size)
%mined_encode 本函数用于对输入信号进行交织编码
%input：用户数据
%frame_size：一帧数据所包含的二进制码元数
len_input = length(input);
if mod(len_input,frame_size) ~= 0
    error('用户数据二进制数必须为帧数的整数倍');
end
frame_num = len_input / frame_size;
res = reshape(input,frame_num,frame_size);
res = res';
res = res(:);
end

