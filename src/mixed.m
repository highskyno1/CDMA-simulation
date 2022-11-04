function res = mixed(input,frame_size,method)
%mixed 交织编码外套函数
%input:用户码元数组，每一行表示一个用户的码元
%frame_size:交织编码每帧长度
%method:运算方法
[user_num,~] = size(input);
res = input;
for i = 1:user_num
    res(i,:) = method(input(i,:),frame_size);
end
end

