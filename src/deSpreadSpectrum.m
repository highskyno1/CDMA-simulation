function res = deSpreadSpectrum(userSpreadCode,spreadCode,user_num)
%本函数用于解扩
%userSpreadCode:需要解扩的用户码元
%spreadCode:用于扩频的随机码
%user_num:用户数量
[~,col] = size(userSpreadCode);
res = zeros(user_num,col);
%为每一个用户分别解扩
for i = 1:user_num
    res(i,:) = bitMultiple(userSpreadCode,spreadCode(i,:));
end
end