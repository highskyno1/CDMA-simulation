function res = mixed_decode(input,frame_size)
%mined_encode ���������ڶ������źŽ��н�֯����
%input���û�����
%frame_size��һ֡�����������Ķ�������Ԫ��
len_input = length(input);
if mod(len_input,frame_size) ~= 0
    error('�û����ݶ�����������Ϊ֡����������');
end
frame_num = len_input / frame_size;
res = reshape(input,frame_size,frame_num);
res = res';
res = res(:);
end

