function res = spreadSpectrum(userCode,spreadCode)
% 实现对每个用户进行扩频
% userCode:用户码元，每一行为一个用户所有的码元
% spreadCode:扩频码，每一行作为一个用户自己的扩频码
    [row_userCode,col_userCode] = size(userCode);
    [row_spreadCode,col_spreadCode] = size(spreadCode);
    if row_spreadCode < row_userCode
        error('扩频码行数不能小于用户数');
    end
    res = int8(zeros(row_userCode,col_userCode * col_spreadCode));
    %对每一个用户进行扩频
    for i = 1:row_userCode
        for j = 1:col_userCode
            res(i,(j-1)*col_spreadCode+1:j*col_spreadCode) = userCode(i,j).*spreadCode(i,:);
        end
    end
end